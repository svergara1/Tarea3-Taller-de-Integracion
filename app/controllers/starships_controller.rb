require 'httparty'

class StarshipsController < ApplicationController

	include HTTParty
	format :json

	def index
		
	end

	  def show
		response = @@client.query <<~GRAPHQL
		query {
  			starship(id: "#{params[:id]}" ) {
  			id
  			name
  			model
  			starshipClass
  			manufacturers
  			costInCredits
  			length
  			crew
  			passengers
  			maxAtmospheringSpeed
  			hyperdriveRating
  			MGLT
  			cargoCapacity
  			consumables
  			pilotConnection { edges { node { ...pilotFragment } } }
			filmConnection { edges { node { ...filmFragment } } }
					}
				}
				fragment pilotFragment on Person {
					id
					name
				}
				fragment filmFragment on Film {
					title
					id
				}
		GRAPHQL

		@starship = response.data.starship
		@pilots ||= []
		@starship.pilot_connection.edges.each do |pilot| 
			@pilots.push(pilot.node)
		end
		@films ||= []
		@starship.film_connection.edges.each do |film| 
			@films.push(film.node)
		end


  		# @starship = HTTParty.get("https://swapi.co/api/starships/#{params[:id]}",
  		# :headers =>{'Content-Type' => 'application/json'} )
  		# @films ||= []
  		# @starship['films'].each do |film|
  		# 	@films.push(HTTParty.get(film,
  		# 	:headers =>{'Content-Type' => 'application/json'}))  		
  		# end
  		# @pilots ||= []
  		# @starship['pilots'].each do |pilot|
  		# 	@pilots.push(HTTParty.get(pilot,
  		# 	:headers =>{'Content-Type' => 'application/json'}))  
  		# end
  	end
end
