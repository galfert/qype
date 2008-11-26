require File.join(File.dirname(__FILE__), 'test_helper')

class ReviewMappingTest < Test::Unit::TestCase

  review_xml = File.read(File.dirname(__FILE__) + '/fixtures/review.xml')

  test 'should parse a single review' do
    review = Qype::Review.parse(review_xml, :single => true)
    assert_not_nil review
  end

end