Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
  root 'films#index'
  resources :films do
  	get 'films/:id' => 'films#show'
  end
  resources :persons do
  	get 'persons/:id' => 'persons#show'
  end  
  resources :starships do
  	get 'starships/:id' => 'starships#show'
  end 
  resources :planets do
  	get 'planets/:id' => 'planets#show'
  end 
  resources :searchbar do
  	get 'searchbar' => 'searchbar#show'
  end 
  

end
	