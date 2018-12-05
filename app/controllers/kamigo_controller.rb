class KamigoController < ApplicationController
	require 'line/bot'
	protect_from_forgery with: :null_session
	def webhook
  			#學說話
  			reply_text = learn(receive_text)
  			# 設定回覆訊息(加入if使其優先低於學習)
 			reply_text = keyword_reply(receive_text) if reply_text.nil?

 			# 傳送訊息
  			response = reply_to_line(reply_text)
  			
  			# 回應 200
  			head :ok
	end 
	def receive_text
			message = params['events'][0]['message']
			message['text'] unless message.nil?
	end
	def learn(receive_text)
		return nil unless receive_text[0..2] == "設定:"

		receive_text = receive_text[3..-1]
		success_index = receive_text.index(':')

		return nil if success_index.nil?
		keyword = receive_text[0..success_index-1]
		message = receive_text[success_index+1 .. -1]

		KeywordMapping.create(keyword: keyword,message: message)
		'success!'
	end
	def keyword_reply(receive_text)
		#學習紀錄表
		#keyword_mapping = {
		#	'QQ' => 'ㄏㄏ' ,
		#	'barry' => 'lu'
		#}
		#查表
		#keyword_mapping[receive_text]
		mapping = KeywordMapping.where(keyword: receive_text).last
		if mapping.nil?
			nil
		else
			mapping.message
		end

	end	
	def reply_to_line(reply_text)
		 return nil if reply_text.nil?
		# 取得 reply token
  		reply_token = params['events'][0]['replyToken']
  		# set up the message
  		message = {
    		type: 'text',
    		text: reply_text
  		}
  		#send message
  		line.reply_message(reply_token,message)	

  	end		
	def line
				 # Line Bot API 物件初始化
			return @line unless @line.nil?
			@line = Line::Bot::Client.new { |config|
		    config.channel_secret = '85856371f291d9fc9c6013a0d0664fe6'
    		config.channel_token = 'lU4bS1RLsfyHC91MyKiMGDxgKu5bTtkoSd+dzoAGAuoePgWN7ecrMZ1SdojLgP3QFUWU7ufoplhcwM41L96uJgUIzh7OxVK1ddu+udNWnU1kH3CYC03p8NsLntbM0fBEOcp1cApdIJH29GjnqM6rhwdB04t89/1O/w1cDnyilFU='
  }
    end
	def test
		return 't'
	end

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

end
