require 'httparty'
require 'graphlient'

class FilmsController < ApplicationController

	include HTTParty
	format :json


	def index

	response = @@client.query <<~GRAPHQL
	query{
		allFilms {
				films {
					id
					title
					episodeID
					director
					releaseDate
					producers
				}
			}
		}
	GRAPHQL
	@films = response.data.all_films.films
	@films.each do |film| 
		puts film.release_date
	end
	
  end

  	def show
  		dictionary = { "1" => "4", "2" => "5", "3" => "6", "4" => "1", "5" => "2", "6" => "3", "7" => "7", "8" => "8", "9" => "9" }
		puts dictionary[params[:id]]

		response = @@client.query <<~GRAPHQL
			query {
				film(id: "#{params[:id]}") {
					id
					episodeID
					title
					openingCrawl
					director
					producers
					releaseDate
					starshipConnection { edges { node { ...starshipFragment } } }
					characterConnection { edges { node { ...characterFragment } } }
					planetConnection { edges { node { ...planetFragment } } }
				}
			}
			fragment starshipFragment on Starship {
				id
				name
				model
				costInCredits
			}
			fragment characterFragment on Person {
				name
				id
				species { name }
			}
			fragment planetFragment on Planet {
				name
				id
			}
		GRAPHQL

		@film = response.data.film
		@characters ||= []
		@film.character_connection.edges.each do |character| 
			puts character.node.name
			@characters.push(character.node)
		end
		@starships ||= []
		@film.starship_connection.edges.each do |starship| 
			@starships.push(starship.node)
		end
		@planets ||= []
		@film.planet_connection.edges.each do |planet| 
			@planets.push(planet.node)
		end



		



  		# @film = HTTParty.get("https://swapi.co/api/films/#{dictionary[params[:id]]}",
  		# :headers =>{'Content-Type' => 'application/json'})
  		# @characters ||= []
  		# @film['characters'].each do |character|
  		# 	@characters.push(HTTParty.get(character,
  		# 	:headers =>{'Content-Type' => 'application/json'}))  		
  		# end
  		# @planets ||= []
  		# @film['planets'].each do |planet|
  		# 	@planets.push(HTTParty.get(planet,
  		# 	:headers =>{'Content-Type' => 'application/json'}))  		
  		# end
  		# @starships ||= []
  		# @film['starships'].each do |starship|
  		# 	@starships.push(HTTParty.get(starship,
  		# 	:headers =>{'Content-Type' => 'application/json'}))  		
  		# end
  	end
end
