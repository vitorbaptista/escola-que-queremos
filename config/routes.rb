Dadoseducacionais::Application.routes.draw do
  match '/school/info/:id' => 'school#info'
  match '/school/search' => 'school#search'

  root :to => 'school#index'
end
