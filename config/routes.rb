Dadoseducacionais::Application.routes.draw do
  root :to => 'school#index'

  match '/school/info/:id' => 'school#info'
end
