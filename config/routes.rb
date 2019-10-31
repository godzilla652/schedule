Rails.application.routes.draw do
  root 'application#public'
  get '/admin', to: 'application#admin'
  
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


  get '/public_final', to: 'application#public_final'


  get '/get_departments_by_faculty', to: 'application#get_departments_by_faculty'
  get '/get_groups_by_department', to: 'application#get_groups_by_department'
  
  
end
