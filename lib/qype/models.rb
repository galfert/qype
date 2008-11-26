module Qype

  class Link
    include HappyMapper

    tag 'link'

    attribute :href, String
    attribute :hreflang, String
    attribute :title, String
    attribute :rel, String
    attribute :count, Integer
  end

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
    has_many :links, Link

    def self.get(client, place_id)
      response = client.get("/places/#{place_id}")
      parse(response, :single => true)
    end

    def self.search(client, search_term, location_name)
      response = client.get('/places', :query => { :show => search_term, :in => location_name })
      Place.parse(response)
    end
  end

  class Review
    include HappyMapper

    tag 'review'

    element :rating, Integer
    element :language, String
  end

end