class KamigoController < ApplicationController
	protect_from_forgery with: :null_session
	def eat
		 render plain: "eat!"
	end
	def r_h
		render plain: request.headers.to_h
		.reject{ |key,value| key.include? '.'}
		.map{ |key,value|"#{key}: #{value}"}
			.sort.join("\n")
	end
	def rb
		render plain: request.body
	end
	def rsh
		response.headers['5566qq?'] 
		render plain: response.headers.to_h.keys
		.sort
		.join("\n")
	end
	def rsb
		puts "===設定前的response.body:#{response.body}=="
		render plain: "S"
		puts "===設定後的response.body:#{response.body}==="
	end
	def sr
		require 'net/http'
		uri=URI('http://localhost:3000/kamigo/rsb')
		response = Net::HTTP.get(uri)
		render plain: response
	end
	def chinese_to_korean(message)
		"#{message}由~"
	end
	def webhook
		head :ok
	end
end
