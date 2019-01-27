class View

	def gets_departements
		system('clear')
		puts "Voici la liste de tous les departements de France"
		file = File.read('db/urlsdep.json')
			urlsdep = JSON.parse(file)
      urlsdep.each.with_index do |departements, i|
      	puts "#{i+1} : #{departements[35..-6]}"
      end
  end