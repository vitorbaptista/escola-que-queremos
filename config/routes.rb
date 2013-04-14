Dadoseducacionais::Application.routes.draw do
  match '/school/info/:id' => 'school#info'
  match '/school/search' => 'school#search'
  match '/school/your_indicator/:id' => 'school#your_indicator'
  match '/school/indicators/:id' => 'school#indicators'

  root :to => 'school#index'
end
