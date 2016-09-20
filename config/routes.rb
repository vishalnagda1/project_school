Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  resources :schools
  resources :classrooms
  resources :subjects
  resources :teachers
  resources :students
end
