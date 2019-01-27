class Scrapper
	attr_accessor :urlsdep, :random_choices, :urlsvilles, :hash_emails

	def initialize
		@urlsdep = []
		@urlsvilles = []		
		@hash_emails = []
	end

	def get_departements
		doc2 = Nokogiri::HTML(open('http://annuaire-des-mairies.com/')) # recuperation des urls
		doc2.xpath('//p/map/area').each.with_index { |node| @urlsdep << node['href'] }
    @urlsdep.map! { |url| "http://www.annuaire-des-mairies.com/" + url } && @urlsdep.pop(5) && @urlsdep.delete_if { |url| url.include?("#") } # restructuration des urls
    return @urlsdep
  end

  def random_choose
  	@random_choices = []
  	puts "Choix en cours..."
  	3.times do |i|
      @random_choices << @urlsdep[rand(100)]
    end
    @random_choices
  end

  def scrap_urls(dep_urls)
  	dep_urls.each.with_index do |ville, i|
 	    puts "#{i+1}. Recuperation des adresses des mairies de #{ville[36..-6].capitalize}..."
      doc = Nokogiri::HTML(open(ville)) # recuperation des urls
      doc.xpath('//p/a[@class = "lientxt"]').each { |node| @urlsvilles << node['href'][1..-1]}
    end
  	@urlsvilles.map! {|url| "https://www.annuaire-des-mairies.com" + url }
  end

  def scrap_emails
  	email = []
  	ville = []
  	compteur = @urlsvilles.count # creation d'un compteur
    @urlsvilles.each.with_index do |townhall_url, i| # recuperation nom de ville et emails
      break if i == 2
      doc = Nokogiri::HTML(open(townhall_url))
      doc.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each { |node| email << node.text }
      puts "Collection des emails en cours.. Numero : #{compteur -= 1}\n> #{townhall_url[40..-6].capitalize}"
      doc.xpath('//strong/a[@class = "lientxt4"]').each { |node| ville << node.text.capitalize }
    end
    ville.size.times { |i| @hash_emails << { ville[i] => email[i] } } # creation du hash
    @hash_emails
  end
end