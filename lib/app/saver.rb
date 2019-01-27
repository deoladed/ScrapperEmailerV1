class Saver

	def get_departements(arraydep)
    File.open('db/urlsdep.json', 'w') do |f|
      f.write(arraydep.to_json)
    end
	end