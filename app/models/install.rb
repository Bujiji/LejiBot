class Install < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
#一直出現methodmissing devise以至於不能用install 則在install.rb和route.rb中有關devise註解起來再跑一次rails generate devise:install