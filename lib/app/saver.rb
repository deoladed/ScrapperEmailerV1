class Saver

	def get_departements(arraydep)
		File.open('db/urlsdep.json', 'w') do |f|
			f.write(arraydep.to_json)
		end
		puts "\nDepartements sauvegardes au format JSON dans 'db/urlsdep.json'\n "
	end

	def scrap_urls(arrayvilles)
		File.open('db/urlsvilles.json', 'w') do |f|
			f.write(arrayvilles.to_json)
		end
	puts "\nVilles sauvegardees au format JSON dans 'db/urlsvilles.json'\n "
	puts " "
	end

	def scrap_emails(hashemails)
		File.open('db/hash_emails.json', 'w') do |f|
			f.write(hashemails.to_json)
		end
		puts "\nEmails et villes correspondantes sauvegardees au format JSON dans 'db/hash_emails.json'\n "

    CSV.open('db/hash_emails.csv', 'w') do |csv| # On ouvre le fichier csv
      hashemails.each.with_index { |haash, i| csv << [i + 1, haash.keys.to_s[2..-3], haash.values.to_s[2..-3]] } # Et on stock nos valeurs sans leurs guillemets, avec un numero de ligne devant
    end
    puts "\nEmails et villes correspondantes sauvegardees au format CSV dans 'db/hash_emails.csv'\n "
  end
end