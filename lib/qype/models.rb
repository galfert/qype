module Qype

  class Category
    include HappyMapper

    tag 'category'

    element :title, String
  end

  class Image
    include HappyMapper

    tag 'image'

    attribute :small, String
    attribute :medium, String
    attribute :large, String
  end

  class Address
    include HappyMapper

    tag 'address'

    element :street, String
    element :postcode, String
    element :housenumber, String
    element :city, String
  end

  class Place
    include HappyMapper

    tag 'place'

    element :title, String
    element :phone, String
    element :average_rating, Float
    element :point, String

    has_one :image, Image
    has_one :address, Address
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