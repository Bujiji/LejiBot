class KamigoController < ApplicationController
	require 'line/bot'
	protect_from_forgery with: :null_session
	def webhook
  			#學說話
  			reply_text = learn(receive_text)
  			# 關鍵字回復(加入if使其優先低於學習)
 			reply_text = keyword_reply(receive_text) if reply_text.nil?
 			#推齊
 			reply_text = echo2(channel_id,receive_text) if reply_text.nil?
 			#記錄對話
 			save_to_receive(channel_id,receive_text)
 			save_to_reply(channel_id,reply_text)
 			# 傳送訊息
  			response = reply_to_line(reply_text)
  			
  			# 回應 200
  			head :ok
	end 
	def channel_id
		#來源會在params底下的source，若在群組groupid就有值，在聊天室則room有
		source = params['events'][0]['source']
		return source['groupId'] unless source['groupId'].nil?
    	return source['roomId'] unless source['roomId'].nil?
    	source['userId'] 
	end	
	def save_to_receive(channel_id,receive_text)
		#因為receive_text不一定有值(有可能傳送貼圖)
		return if receive_text.nil?
		Receive.create(channel_id: channel_id,text: receive_text)
	end
	def save_to_reply(channel_id,reply_text)
		return if reply_text.nil?
		Reply.create(channel_id: channel_id,text: reply_text)
	end
	def echo2(channel_id,receive_text)
		#如果在channel_id 最近沒人講過receive_text，卡米狗就不回應
		recent_receive_texts = Receive.where(channel_id:channel_id).last(5)&.pluck(:text)
		return nil unless receive_text.in? recent_receive_texts
		#如果在channel_id卡米狗上一句回應是receive_text，卡米狗就不回應
		last_reply_text = Reply.where(channel_id:channel_id).last&.text
		return nil if last_reply_text == receive_text
		receive_text	
	end	
	#取得對方所說的話
	def receive_text
			message = params['events'][0]['message']
			message['text'] unless message.nil?
	end
	def learn(receive_text)
		return nil unless receive_text[0..2] == '設定:'

		receive_text = receive_text[3..-1]
		success_index = receive_text.index(':')

		return nil if success_index.nil?
		keyword = receive_text[0..success_index-1]
		message = receive_text[success_index+1..-1]

		KeywordMapping.create(keyword: keyword,message: message)
		'success!'
	end
	def keyword_reply(receive_text)
		
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
