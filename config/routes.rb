Dadoseducacionais::Application.routes.draw do
  match '/show/:id' => 'school#show'
  match '/search' => 'school#search'
  match '/your_indicator/:id' => 'school#your_indicator'
  match '/indicators/:id' => 'school#indicators'

  root :to => 'school#index'
end
