require File.join(File.dirname(__FILE__), 'test_helper')

class UserMappingTest < Test::Unit::TestCase

  user_xml = File.read(File.dirname(__FILE__) + '/fixtures/user.xml')

  context 'A single user' do
    before do
      @user = Qype::User.parse(user_xml, :single => true)
    end

    test 'should have basic elements' do
      assert_equal 'Grobi', @user.title
      assert_equal 6860, @user.points
      assert_equal 'de', @user.language
      assert_equal 'Advanced Insider', @user.level
    end

    test 'should include a link to the locator' do
      locator_link = @user.links.find { |link| link.rel == 'http://schemas.qype.com/locator' }
      assert_not_nil locator_link
      assert_equal 'Hamburg', locator_link.title
    end

    test 'should include a link to the reviews of the user' do
      reviews_link = @user.links.find { |link| link.rel == 'http://schemas.qype.com/reviews' }
      assert_not_nil reviews_link
      assert_equal 'http://api.qype.com/v1/users/Grobi/reviews', reviews_link.href
    end
    
    test 'should fetch reviews' do
      client = mock_client(File.dirname(__FILE__) + '/fixtures/reviews.xml')

      reviews = @user.reviews(client)
      assert_equal 10, reviews.size
    end
  end

end