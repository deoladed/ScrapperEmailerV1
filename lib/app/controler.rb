require 'app/scrapper'
require 'app/emailer'
require 'app/saver'
require 'views/views'

class Controler
	attr_accessor :scrap, :view, :saver

	def initialize
		@scrap = Scrapper.new
		@view = View.new
		@saver = Saver.new
		@emailer = Emailer.new
	end

	def get_departements
		@scrap.get_departements
		# @saver.get_departements(@scrap.urlsdep)
		@view.get_departements
	end

	def random_choose
		@scrap.random_choose
		@view.random_choose(@scrap.random_choices)
	end

	def scrap_urls
		@scrap.scrap_urls(@scrap.random_choices)
		@view.scrap_urls(@scrap.urlsvilles)
		@saver.scrap_urls(@scrap.urlsvilles)
		scrap_emails
	end

	def scrap_ALL_urls
		@scrap.scrap_urls(@scrap.urlsdep)
		@view.scrap_urls(@scrap.urlsvilles)
		@saver.scrap_urls(@scrap.urlsvilles)
		scrap_emails
	end

	def scrap_by_choice
		url_departements_choisi = @view.scrap_by_choice(@scrap.urlsdep)
		@scrap.scrap_urls(url_departements_choisi)
		@saver.scrap_urls(@scrap.urlsvilles)
		scrap_emails
	end

	def scrap_emails
		@scrap.scrap_emails
		@view.scrap_emails(@scrap.hash_emails)
		@saver.scrap_emails(@scrap.hash_emails)
	end

	def send_emails
		@emailer.send_emails
	end
end