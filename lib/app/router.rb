require 'app/controler'

class Router
	attr_accessor :controler

		def initialize
			@controler = Controler.new
			say_hello
		end

		def say_hello
			puts "Hello!\nBienvenue dans el scrappppper"
			puts "On commence par recuperer la liste des departements de France\n C'est parti"
			@controler.get_departements
		end
