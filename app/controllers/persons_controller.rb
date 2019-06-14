require 'httparty'

class PersonsController < ApplicationController

	include HTTParty
	format :json

	def index
		
	end

	  def show

		response = @@client.query <<~GRAPHQL
		query {
			person(id: "#{params[:id]}" ) {
			  id
			  name
			  birthYear
			  eyeColor
			  gender
			  hairColor
			  height
			  mass
			  skinColor
			  species {
				name
			  }
			  homeworld{
				name
				id
			  }
			  starshipConnection { edges { node { ...starshipFragment } } }
				  filmConnection { edges { node { ...filmFragment } } }
						  }
					  }
					  fragment starshipFragment on Starship {
						  id
						  name
						  model
						  costInCredits
					  }
					  fragment filmFragment on Film {
						  title
						  id
					  }
		GRAPHQL

		@person = response.data.person
		@planet = response.data.person.homeworld
		@species = response.data.person.species.name
		@starships ||= []
		@person.starship_connection.edges.each do |starship| 
			@starships.push(starship.node)
		end
		@films ||= []
		@person.film_connection.edges.each do |film| 
			@films.push(film.node)
		end
		
		



  		# @person = HTTParty.get("https://swapi.co/api/people/#{params[:id]}",
  		# :headers =>{'Content-Type' => 'application/json'} )
  		# @planet = HTTParty.get(@person['homeworld'],
  		# :headers =>{'Content-Type' => 'application/json'} )
  		# @films ||= []
  		# @person['films'].each do |film|
  		# 	@films.push(HTTParty.get(film,
  		# 	:headers =>{'Content-Type' => 'application/json'}))  		
  		# end

  	end

end
