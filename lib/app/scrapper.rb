class Scrapper
		attr_accessor :@urlsdep
	def initialize
		@urlsdep
	end

	def get_departements
		doc2 = Nokogiri::HTML(open('http://annuaire-des-mairies.com/')) # recuperation des urls
    doc2.xpath('//p/map/area').each.with_index { |node| @urlsdep << node['href'] }
    @urlsdep.map! { |url| "http://www.annuaire-des-mairies.com/" + url } && @urlsdep.pop(5) && @urlsdep.delete_if { |url| url.include?("#") } # restructuration des urls
    return @urlsdep
   end
