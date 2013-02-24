require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    mail = Notifier.order_received orders(:one)
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match /1 x Programming Ruby 1.9 - \$49.50/, mail.body.encoded
  end

  test "order_shipped" do
    mail = Notifier.order_shipped orders(:one)
    assert_equal 'Pragmatic Store Order Shipped', mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match /1 x Programming Ruby 1.9 - \$49.50/, mail.body.encoded
  end

end
