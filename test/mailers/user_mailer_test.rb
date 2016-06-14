require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:diego)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Activa tu Cuenta", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@papawolf.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Cambia tu Contraseña", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@papawolf.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
end
