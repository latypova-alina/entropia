require "httparty"
require "pry-rails"

class PublicPost
  VK_URL = "https://api.vk.com/method/wall.get"
  TOKEN = "563c26e54a18ce121785225d6b4171ee8fff5ea38a079982837d0b551dc9c5cc1dc2acbf4dd0c25cf5327"

  attr_accessor :posts_texts

  def initialize
    @posts_texts = ""
  end

  def posts(group_id)
    posts = JSON.parse(HTTParty.get("#{VK_URL}?owner_id=#{group_id}&count=100&access_token=#{TOKEN}").body)
    posts["response"].each_with_index do |post, index|
      @posts_texts << "\n #{post["text"]}" unless index == 0
    end
  end
end
