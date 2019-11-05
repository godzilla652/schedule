Rails.application.routes.draw do
  get '/test', to: 'application#test'

  root 'application#public'
  get '/admin', to: 'application#admin', as: 'admin'
  
  scope '/admin' do
    resources :faculties
  end
  scope '/admin' do
    resources :departments
  end
  scope '/admin' do
    resources :groups
  end


  post '/post_schedule', to: 'application#post_schedule'
  post '/delete_schedule', to: 'application#delete_schedule'


  get '/public_final', to: 'application#public_final'


  get '/get_departments_by_faculty', to: 'application#get_departments_by_faculty'
  get '/get_groups_by_department', to: 'application#get_groups_by_department'
  
  get '/login', to: 'application#login'  
  post '/login_proc', to: 'application#login_proc'
  
  post '/set_new_pwd', to: 'application#set_new_pwd'

  get '/quit', to: 'application#quit'
end

