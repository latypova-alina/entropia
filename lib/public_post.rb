require "httparty"
require "pry-rails"

class PublicPost
  VK_URL = "https://api.vk.com/method/wall.get"
  TOKEN = "563c26e54a18ce121785225d6b4171ee8fff5ea38a079982837d0b551dc9c5cc1dc2acbf4dd0c25cf5327"
  TI_NA_PONTAH = "-36166073"
  NE_MY_TAKIE = "-34378420"
  OBNULYAY = "-33339790"
  BRAT_TOLKO_DERJIS = "-32194500"
  THIN_QUEEN = "-64403009"
  U_NAS_SVOY_RAY = "-49272117"
  DIANA_SHURIGINA = "-140892492"
  LENTACH = "-29534144"
  ART_OR_BULLSHIT = "-33334108"
  MMMM_VKUSNYATINA = "-72133851"
  PERESKAZANO = "-79419972"
  GOOGLE_ZAPROSY = "-91421416"
  PODSLUSHANO = "-34215577"
  PIKABU = "-31480508"

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
