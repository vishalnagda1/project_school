Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  get 'classrooms/school_class_index' => 'classrooms#school_class_index'
  resources :schools
  resources :classrooms
  resources :subjects
  resources :teachers
  resources :students
end
