# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :auths

  namespace :api do
    # auth
    resources :auths, only: :show
    get '/auths_by_email', to: 'auths_by_emails#show', as: :auths_by_email
  end

  resources :accounts
  resource :profile, only: %i[show update]

  # kanban
  resources :kanbans
  patch '/kanbans/:id/sort', to: 'kanbans#sort', as: 'kanban_sort'

  # kanban column
  resources :kanban_columns

  # card
  resources :cards

  # kanban_assignee
  post '/kanban_assignees', to: 'kanban_assignees#assign'
  put '/kanban_assignees', to: 'kanban_assignees#reassign'
  
  root 'home#index'
end
