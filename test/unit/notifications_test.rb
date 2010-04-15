require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "activation_instructions" do
    @expected.subject = 'Notifications#activation_instructions'
    @expected.body    = read_fixture('activation_instructions')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_activation_instructions(@expected.date).encoded
  end

end
