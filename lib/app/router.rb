require 'app/controler'

class Router
	attr_accessor :controler

	def initialize
		@controler = Controler.new
		say_hello
	end

	def say_hello
		puts "Hello!\nBienvenue dans El Scrappppper"
		puts "On commence par recuperer la liste des departements de France\n C'est parti"
		@controler.get_departements
		scrap_emails
	end

	def scrap_emails
	while true
		# puts "\nCa te va (dit OUI) ou on en choisi trois autres (dit NON)?"
		puts "\nOn en choisi TROIS au hasard ?"
		puts "Si tu veux TOUTES les mairies de france, dit ALL"
		puts "Si tu n'en veux qu'une, dit CHOIX"
		puts "Si tu veux quitter dit BYE"
		print ">"
		case gets.chomp.downcase
		when "trois"
			@controler.random_choose
			@controler.scrap_urls
			@controler.send_emails
		# when "oui"
		# 	@controler.scrap_urls
		# 	send_emails
		# when "non"
		# 	random_choose
		when "all"
			@controler.scrap_ALL_urls
			@controler.send_emails
		when 'choix'
			@controler.scrap_by_choice
			@controler.send_emails
		when 'bye'
			puts "Tchaaaaaooo"
			false
			break
		else
			puts "Je n'ai pas compris votre reponse"
			scrap_emails
		end
	end
	end	

