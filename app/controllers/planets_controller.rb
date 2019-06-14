require 'httparty'

class PlanetsController < ApplicationController

	include HTTParty
	format :json

	def index
		
	end

  	def show
		  
		response = @@client.query <<~GRAPHQL
		query {
  		planet(id: "#{params[:id]}" ) {
    		id
    		name
    		diameter
    		rotationPeriod
    		orbitalPeriod
    		gravity
    		population
    		climates
    		terrains
    		surfaceWater
    		residentConnection { edges { node { ...residentFragment } } }
				filmConnection { edges { node { ...filmFragment } } }
						}
					}
					fragment residentFragment on Person {
						id
						name
					}
					fragment filmFragment on Film {
						title
						id
					}
		GRAPHQL


		@planet = response.data.planet
		@persons ||= []
		@planet.resident_connection.edges.each do |resident| 
			@persons.push(resident.node)
		end
		@films ||= []
		@planet.film_connection.edges.each do |film| 
			@films.push(film.node)
		end


  		# @planet = HTTParty.get("https://swapi.co/api/planets/#{params[:id]}",
  		# :headers =>{'Content-Type' => 'application/json'} )
  		# @residents ||= []
  		# @planet['residents'].each do |resident|
  		# 	@residents.push(HTTParty.get(resident,
  		# 	:headers =>{'Content-Type' => 'application/json'}))  
  		# end
  		# @films ||= []
  		# @planet['films'].each do |film|
  		# 	@films.push(HTTParty.get(film,
  		# 	:headers =>{'Content-Type' => 'application/json'}))  		
  		# end
  	end

end
