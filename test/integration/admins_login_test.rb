require "test_helper"

class AdminsLogin < ActionDispatch::IntegrationTest

  def setup
    @admin = admins(:testAdmin)
  end
end

class InvalidPasswordTest < AdminsLogin

  test "login path" do
    get login_path
    assert_template 'sessions/new'
  end

  test "login with valid email/invalid password" do
    post login_path, params: { session: { email:    @admin.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end

class ValidLogin < AdminsLogin

  def setup
    super
    post login_path, params: { session: { email:    @admin.email,
                                          password: 'password' } }
  end
end

class Logout < ValidLogin

  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout

  test "successful logout" do
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_path
  end

  test "redirect after logout" do
    follow_redirect!
    assert_select "a[href=?]", logout_path,      count: 0
  end
end