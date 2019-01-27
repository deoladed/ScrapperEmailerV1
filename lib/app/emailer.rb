require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'mime'
include MIME
require 'json'

class Emailer

	OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
	APPLICATION_NAME = 'Gmail API Ruby Quickstart'.freeze
	CREDENTIALS_PATH = 'credentials.json'.freeze
	TOKEN_PATH = 'token.yaml'.freeze
	SCOPE = Google::Apis::GmailV1::AUTH_SCOPE

	def authorize
		client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
		token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
		authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
		user_id = 'default'
		credentials = authorizer.get_credentials(user_id)
		if credentials.nil?
			url = authorizer.get_authorization_url(base_url: OOB_URI)
			puts 'Open the following URL in the browser and enter the ' \
			"resulting code after authorization:\n" + url
			code = gets
			credentials = authorizer.get_and_store_credentials_from_code(
			user_id: user_id, code: code, base_url: OOB_URI
			)
		end
		credentials
	end

	def send_emails
		service = Google::Apis::GmailV1::GmailService.new
		service.client_options.application_name = APPLICATION_NAME
		service.authorization = authorize

		file = File.read('db/hash_emails.json')
			hash_emails = JSON.parse(file)
      hash_emails.each.with_index do |hash, i|
      	hash.each do |ville, email|
					# Création du contenu du message
					msg = Mail.new #msg est une instance de la classe « Mail ». On va définir ses variables d’instance
					msg.date = Time.now
					msg.subject = "A la mairie de #{ville}"
					msg.body = Text.new("Mme, Mr le Maire de #{ville},\nVendredi dernier, notre president a renonce a sa promesse d'interdiction du Glyphosate (https://www.lemonde.fr/politique/article/2019/01/25/le-president-renonce-a-sa-promesse-d-interdire-le-glyphosate-en-2021_5414363_823448.html).\nSi cela vous revolte, je vous encourage a donner votre avis en tant qu'insitution Francaise.\nS'il-vous-plait, faites un geste.\nMerci, cordialement,\nLeo ROBERT", 'plain', 'charset' => 'us-ascii')
					msg.from = {'leo.robert.mk@gmail.com' => 'Leo ROBERT'}
					msg.to   = {'deo3@yopmail.com' => nil} #email

					# Création de la requête, insertion du contenu dans la propriété `raw`
					#(https://developers.google.com/gmail/api/v1/reference/users/messages/send)
					message = Google::Apis::GmailV1::Message.new(raw: msg.to_s)

					service.send_user_message('me', message)
					puts "#{i+1} email sur #{hash_emails.count} envoye  : #{ville}"
				end
			end
		end
end