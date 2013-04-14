Dadoseducacionais::Application.routes.draw do
  match '/school/info/:id' => 'school#info'
  match '/school/search' => 'school#search'
  match '/school/your_indicator/:id' => 'school#your_indicator'

  match '/sobre' => 'home#about'
  match '/como-usar' => 'home#how_to_use'
  match '/proximos-passos' => 'home#next_steps'

  root :to => 'school#index'
end
