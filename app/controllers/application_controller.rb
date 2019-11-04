class ApplicationController < ActionController::Base
  before_action :check_user, except: [:public, :public_final, :login, :login_proc, :get_departments_by_faculty, :get_groups_by_department, :test]
  
def test
  p '#'*50
  puts "#{root_url}"
  p '#'*50
end  

  def public
    @faculties = Faculty.all.collect {|t| [t.name, t.id]}
  end

  def public_final
      @group = Group.find(params[:group_id])
      @days = Day.all
      @clocks = Clock.all
  end 

  def get_departments_by_faculty
    @payload = Department.where(faculty_id: params[:faculty_id])

    render :json => @payload.to_json
  end
  def get_groups_by_department
    @payload = Group.where(department_id: params[:department_id])

    render :json => @payload.to_json
  end
  

  def login
  end
  def login_proc
    if User.where(name: 'admin').first.authenticate(params[:password])
      cookies.signed[:schedule] = 'admin'
      redirect_to '/admin'
    elsif
      flash[:notice] = 'Вы не авторизированы'
      redirect_to '/login'
    end
  end

  def admin
    
    @groups = Group.all.collect {|t| [t.fullname, t.id]}
    @days = Day.all.collect {|t| [t.name, t.id]}
    @clocks = Clock.all.collect {|t| [t.name, t.id]}
    @faculties = Faculty.all.collect {|t| [t.name, t.id]}
  end
  
  def set_new_pwd
    pwd = params[:password]
    if pwd && !pwd.blank?
      User.where(name: 'admin').first.update(password: pwd)
      render :plain => 'Password successfully updated'
    elsif
      render :plain => 'Error'
    end
  end

  
  def post_schedule
    if params[:group_id].blank? || params[:teacher].blank? || params[:course].blank? || params[:room].blank? || params[:days].empty? || params[:clock_id].blank?
      flash[:error] = 'Не опубликовано, пустые поля недопустимы'
  
    #every week
    elsif params[:parz].nil?
      day_ids = []
      params[:days].each {|key, value| day_ids << key}

      day_ids.each do |day_id|
        current = Schedul.where group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id]
        count = current.count

        if count == 0
          Schedul.create group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room]
        elsif count == 1
          current.destroy_all
          Schedul.create group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room]
        elsif count == 2
          current.destroy_all
          Schedul.create group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room]
        end
      end
      flash[:notice] = 'Успешно опублиkoвано'


    # #only even weeks
    elsif params[:parz] == 'even'
      day_ids = []
      params[:days].each {|key, value| day_ids << key}

      day_ids.each do |day_id|
        current = Schedul.where group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id]
        count = current.count
        if    count == 0
          Schedul.create group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room], even: true
        elsif count == 1
          if current.first.even 
            Schedul.update group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room]
          elsif current.first.odd
            Schedul.create group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room], even: true
          elsif !current.first.even && !current.first.odd 
            current.destroy_all
            Schedul.create group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room], even: true
          end
        elsif count == 2
          myself = Schedul.where(group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], even: true).first
          myself.update group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room]
        end
      end
      flash[:notice] = 'Успешно опублиkoвано'

    # #only odd weeks
    elsif params[:parz] == 'odd'
      day_ids = []
      params[:days].each {|key, value| day_ids << key}
      
      day_ids.each do |day_id|
        current = Schedul.where group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id]
        count = current.count
        if    count == 0
          Schedul.create group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room], odd: true
        elsif count == 1
          if current.first.even 
            Schedul.create group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room], odd: true
          elsif current.first.odd
            Schedul.update group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room]
          elsif !current.first.even && !current.first.odd 
            current.destroy_all
            Schedul.create group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room], odd: true
          end
        elsif count == 2
          myself = Schedul.where(group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], odd: true).first
          myself.update group_id: params[:group_id], day_id: day_id, clock_id: params[:clock_id], teacher: params[:teacher], course: params[:course], room: params[:room]
        end
      end
      flash[:notice] = 'Успешно опублиkoвано'
    end
    redirect_to '/admin'
  end

  private
  def check_user
    if cookies.signed[:schedule].nil?
      flash[:notice] = 'Вы не авторизированы'
      redirect_to '/login'
    end
  end

end


