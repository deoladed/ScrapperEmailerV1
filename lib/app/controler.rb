require 'app/scrapper'
require 'app/emailer'
require 'app/saver'
require 'views/views'

class Controler
	attr_accesor :scrap, :view, :saver

	def initialize
		@scrap = Scrapper.new
		@view = Viewer.new
		@saver = Saver.new
	end

	def get_departements
		@scrap.get_departements
		@saver.get_departements(@scrap.urlsdep)
		@view.get_departements
	end