Dadoseducacionais::Application.routes.draw do
  match '/school/info/:id' => 'school#info'
  match '/school/search' => 'school#search'
  match '/school/your_indicator/:id' => 'school#your_indicator'

  root :to => 'school#index'
end
