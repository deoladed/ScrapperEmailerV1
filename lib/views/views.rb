class View

	def get_departements
		system "clear"
		puts "Voici la liste de tous les departements de France"
		file = File.read('db/urlsdep.json')
		urlsdep = JSON.parse(file)
		urlsdep.each.with_index do |departements, i|
			puts "#{i+1} : #{departements[36..-6].capitalize}"
		end
	end

	def random_choose(ramdom_choices)
		puts "\nCibles du jour :"
    ramdom_choices.each.with_index do |mairie, i|
      puts "> #{i+1} : #{mairie[36..-6].capitalize}"
    end
  end

  def scrap_urls(urls_villes)
   	puts "\n#{urls_villes.size} adresses de ville recuperees\n"
  end

  def scrap_by_choice(all_dep)
  	arr_choix = []
  	puts "Rentre le numero du departements"
  	choix = all_dep[gets.chomp.to_i - 1]
  	puts "#{choix[36..-6].capitalize} est ton choix"
  	puts "Tu confirmes ?"
  	case gets.chomp.downcase
  		when "oui"
  			puts "Parfait"
  			return arr_choix << choix
  		when "non"
  			scrap_by_choice(all_dep)
  		else
  			puts "Je n'ai pas compris"
  			scrap_by_choice(all_dep)
  		end
  end

  def scrap_emails(emails)
  	puts "\n#{emails.size} emails recuperes\n"
  end

  def send_emails
		puts "Mme, Mr le Maire de VILLE,\nVendredi dernier, notre president a renonce a sa promesse d'interdiction du Glyphosate (https://www.lemonde.fr/politique/article/2019/01/25/le-president-renonce-a-sa-promesse-d-interdire-le-glyphosate-en-2021_5414363_823448.html).\nSi cela vous revolte, je vous encourage a donner votre avis en tant qu'insitution Francaise.\nS'il-vous-plait, faites un geste.\nMerci, cordialement,\nLeo ROBERT"
		print ">"
	end
end