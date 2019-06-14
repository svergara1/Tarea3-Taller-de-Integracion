require 'httparty'


class WelcomeController < ApplicationController

	include HTTParty
	format :json


	def index
    @films = HTTParty.get('https://swapi.co/api/films',
    :headers =>{'Content-Type' => 'application/json'} )['results']
  end


end
