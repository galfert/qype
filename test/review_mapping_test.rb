require File.join(File.dirname(__FILE__), 'test_helper')

class ReviewMappingTest < Test::Unit::TestCase

  review_xml = File.read(File.dirname(__FILE__) + '/fixtures/review.xml')

  context 'A single review' do
    before do
      @review = Qype::Review.parse(review_xml, :single => true)
    end

    test 'should have basic review elements' do
      assert_equal 'de', @review.language
      assert_equal 4, @review.rating

      paragraph = /<p>/
      assert_no_match paragraph, @review.content

      assert_match paragraph, @review.formatted_content
    end

    test 'should include tag elements' do
      tags = @review.tags
      assert_equal 8, tags.size
      assert_equal "günstig", tags.first.term
    end

    test 'should include a link to the locator' do
      locator_link = @review.links.find { |link| link.rel == 'http://schemas.qype.com/locator' }
      assert_not_nil locator_link
      assert_equal 'Hamburg', locator_link.title
    end

    test 'should include a link to the place' do
      place_link = @review.links.find { |link| link.rel == 'http://schemas.qype.com/place' }
      assert_not_nil place_link
      assert_equal 'Mr. Kebab', place_link.title
    end

    test 'should include a link to the user' do
      user_link = @review.links.find { |link| link.rel == 'http://schemas.qype.com/user' }
      assert_not_nil user_link
      assert_equal 'Grobi', user_link.title
    end
    
    test 'should fetch the place' do
      client = mock_client(File.dirname(__FILE__) + '/fixtures/place.xml')
      place = @review.place(client)
      assert_equal 'Mr. Kebab', place.title
    end

    test 'should fetch the user' do
      client = mock_client(File.dirname(__FILE__) + '/fixtures/user.xml')
      user = @review.user(client)
      assert_equal 'Grobi', user.title
    end
  end

end