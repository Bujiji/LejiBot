{
    #這個 hash 有兩個 key，分別是 events 和 kamigo，events 是一個陣列，而 kamigo 是一個 hash。
    #kamigo 是一個只有一個 key 的 hash，而這個 key 也叫作，events。更巧的是，這兩個 events 裡面包含的資料是相同的，
    #所以我們只要看其中一個 events 就好。
	"events"=>[
		{
				"replyToken"=>"00000000000000000000000000000000",
	 			"type"=>"message",
				"timestamp"=>1543563331403, 
				"source"=>{
						 "type"=>"user", 
	 	       			 "userId"=>"Udeadbeefdeadbeefdeadbeefdeadbeef"},
					   	 "message"=>{"id"=>"100001", "type"=>"text", "text"=>"Hello, world"
					   	  }
		}, 
		{
				"replyToken"=>"ffffffffffffffffffffffffffffffff", 
				"type"=>"message", 
				"timestamp"=>1543563331403, 
				"source"=>{
						"type"=>"user", 
		    			"userId"=>"Udeadbeefdeadbeefdeadbeefdeadbeef"
		    		      }, 
		    "message"=>{"id"=>"100002", "type"=>"sticker", "packageId"=>"1", "stickerId"=>"1"}
		}
		       ], 
	"kamigo"=>{
		"events"=>[
					{ "replyToken"=>"00000000000000000000000000000000", 
					  "type"=>"message", 
					  "timestamp"=>1543563331403, 
					  "source"=>{
					  				"type"=>"user",
					  				"userId"=>"Udeadbeefdeadbeefdeadbeefdeadbeef"
					  			},
					  "message"=>{"id"=>"100001", "type"=>"text", "text"=>"Hello, world"}
					}, 
					{
					 "replyToken"=>"ffffffffffffffffffffffffffffffff", 
					 "type"=>"message", 
					 "timestamp"=>1543563331403, 
					 "source"=>{
					 			"type"=>"user", 
					 			"userId"=>"Udeadbeefdeadbeefdeadbeefdeadbeef"
					 			}, 
					 "message"=>{"id"=>"100002", "type"=>"sticker", "packageId"=>"1", "stickerId"=>"1"}
					}
					]
				}
}