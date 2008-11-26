require File.join(File.dirname(__FILE__), 'test_helper')

class PlaceMappingTest < Test::Unit::TestCase

  place_xml = File.read(File.dirname(__FILE__) + '/fixtures/place.xml')

  test 'should parse a single place' do
    place = Qype::Place.parse(place_xml, :single => true)
    assert_not_nil place
  end

  test 'should have basic elements' do
    place = Qype::Place.parse(place_xml, :single => true)
    assert_equal 'Mr. Kebab', place.title
    assert_equal '040 437798', place.phone
    assert_equal 4.95, place.average_rating
    assert_equal '53.5564,9.96239', place.point
  end

  test 'should include a image element with three thumbnail sizes' do
    place = Qype::Place.parse(place_xml, :single => true)

    image = place.image
    assert_not_nil image
    assert_equal "http://assets1.qype.com/uploads/photos/0017/4291/IMG_2092_mini.JPG?1208428301", image.small
    assert_equal "http://assets2.qype.com/uploads/photos/0017/4291/IMG_2092_thumb.JPG?1208428303", image.medium
    assert_equal "http://assets3.qype.com/uploads/photos/0017/4291/IMG_2092_gallery.JPG?1208428300", image.large
  end

  test 'should include a address element' do
    place = Qype::Place.parse(place_xml, :single => true)

    address = place.address
    assert_not_nil address
    assert_equal 'Thadenstrasse', address.street
    assert_equal '22767', address.postcode
    assert_equal '1', address.housenumber
    assert_equal 'Hamburg', address.city
  end

  test 'should include multiple category elements' do
    place = Qype::Place.parse(place_xml, :single => true)

    categories = place.categories
    assert_equal 2, categories.size
    assert_equal "Döner und Griechischer Imbiss", categories[0].title
    assert_equal "Türkische Restaurants", categories[1].title
  end

  test 'should include links to reviews in multiple languages' do
    place = Qype::Place.parse(place_xml, :single => true)

    review_links = place.links.select { |link| link.rel == 'http://schemas.qype.com/reviews' }
    assert_equal 5, review_links.size

    german_link = review_links.find { |link| link.hreflang == 'de' }
    assert_equal 'http://api.qype.com/v1/places/7019/reviews/de', german_link.href
    assert_equal 40, german_link.count
  end

  test 'should include a link to the locator' do
    place = Qype::Place.parse(place_xml, :single => true)

    locator_link = place.links.find { |link| link.rel == 'http://schemas.qype.com/locator' }
    assert_not_nil locator_link
    assert_equal 'Hamburg', locator_link.title
  end

  test 'should include a link to assets for the place' do
    place = Qype::Place.parse(place_xml, :single => true)

    assets_link = place.links.find { |link| link.rel == 'http://schemas.qype.com/assets' }
    assert_not_nil assets_link
  end
end