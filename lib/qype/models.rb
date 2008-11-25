module Qype

  class Category
    include HappyMapper

    tag 'category'

    element :title, String
  end

  class Place
    include HappyMapper

    tag 'place'

    element :title, String
    element :phone, String

    has_many :categories, Category

    def self.get(client, place_id)
      response = client.get("/places/#{place_id}")
      parse(response, :single => true)
    end

    def self.search(client, search_term, location_name)
      response = client.get('/places', :query => { :show => search_term, :in => location_name })
      Place.parse(response)
    end
  end

end