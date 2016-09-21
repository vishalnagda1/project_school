Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'

  get 'classrooms/index_by_school_id', to: 'classrooms#index_by_school_id'
  get 'subjects/index_by_school_id', to: 'subjects#index_by_school_id'
  get 'students/index_by_classroom_id', to: 'students#index_by_classroom_id'
  get 'teachers/index_by_school_id', to: 'teachers#index_by_school_id'

  resources :schools
  resources :classrooms
  resources :subjects
  resources :teachers
  resources :students
end
