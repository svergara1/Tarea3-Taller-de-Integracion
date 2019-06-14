class SearchbarController < ApplicationController

	def index
	end

	def create 
		@planet = HTTParty.get("https://swapi.co/api/planets/?search=#{params[:store]}",
  		:headers =>{'Content-Type' => 'application/json'})['results']
  		if @planet == []
  			@person = HTTParty.get("https://swapi.co/api/people/?search=#{params[:store]}",
  			:headers =>{'Content-Type' => 'application/json'})['results']
  			if @person == []
  				@starship = HTTParty.get("https://swapi.co/api/starships/?search=#{params[:store]}",
  				:headers =>{'Content-Type' => 'application/json'})['results']
  				if @starship == []
  					@film = HTTParty.get("https://swapi.co/api/films/?search=#{params[:store]}",
  					:headers =>{'Content-Type' => 'application/json'})['results']
  					if @film == []
  						@planet = nil
  						@film = nil
  						@person = nil
  						@starship = nil
  					end
  				end	
  			end
  		end

	end

	def show
		@search_result = HTTParty.get("https://swapi.co/api/planets/?search=#{params[:store]}",
  		:headers =>{'Content-Type' => 'application/json'})
  		puts @search_result['results']
	end

end
