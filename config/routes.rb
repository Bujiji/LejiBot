Rails.application.routes.draw do
  get '/kamigo/eat' , to: 'kamigo#eat'
  get '/kamigo/rh' , to: 'kamigo#r_h'	 #request head
  get '/kamigo/rb' , to: 'kamigo#rb'	 #request body
  get '/kamigo/rsh' , to: 'kamigo#rsh'	 #response headers
  get '/kamigo/rsb' , to: 'kamigo#rsb'   #response body
  get '/kamigo/sr' , to: 'kamigo#sr'     #send request
end
