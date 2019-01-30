
urlsdesdepartements = []
1.upto(9) do |i|
urlsdesdepartements << "0#{i}"
end
10.upto(95) do |i|
urlsdesdepartements << i.to_s
end
urlsdesdepartements << "971"
urlsdesdepartements << '972'
urlsdesdepartements << '973'
urlsdesdepartements << '974'
urlsdesdepartements << '2A'
urlsdesdepartements << '2B'
urlsdesdepartements.map! { |url| "http://www.annuaire-des-mairies.com/" + url }
urlsdesdepartements.delete_if { |url| url.include?("20")}
 	puts urlsdesdepartements

def test(urlsdesdepartements) 

 	@urlsvilles = []
 	urlsdesdepartements.each do |depart|
		doc2 = Nokogiri::HTML(open(depart)) # recuperation des urls
		doc2.xpath('//html/body/pre/a').each.with_index { |node| @urlsvilles << node['href'] }  
		@urlsvilles.delete_if { |url| url.include?("css") || url.include?("images") || url.include?("js") || url.include?("/") || url.include?("?C=D;O=A") || url.include?("?C=S;O=A") || url.include?("?C=M;O=A") || url.include?("?C=N;O=D") } 
	end
	puts @urlsvilles
	return @urlsvilles
end

def save_urls(arrayvilles)
	File.open('db/urlsallvilles2.json', 'w') do |f|
		f.write(arrayvilles.to_json)
	end
	puts "\nVilles sauvegardees au format JSON dans 'db/urlsallvilles2.json'\n "
	puts " "
end

test(urlsdesdepartements)
save_urls(@urlsvilles)


  # def scrap_urls(dep_urls)

  # 	dep_urls.each.with_index do |ville, i|
 	#     puts "#{i+1}. Recuperation des adresses des mairies de #{ville}..."
  #     doc = Nokogiri::HTML(open(ville)) # recuperation des urls
  #     doc.xpath('//p/a[@class = "lientxt"]').each { |node| @urlsvilles << node['href'][1..-1]}
  #   end
  #   p @urlsvilles
  # 	@urlsvilles.map! {|url| "https://www.annuaire-des-mairies.com" + url }
  # 	p @urlsvilles
  # end

