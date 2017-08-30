require "rails_helper"

RSpec.describe "SignupUsers", type: :request do
  describe "valid signup information with account activation" do

    it do
      get signup_path
      expect(response).to render_template "users/new"

      post signup_path, params: {user: {name: "Example User",
        email: "user@example.com",
        password: "foobar",
        password_confirmation: "foobar"}}

      expect(ActionMailer::Base.deliveries.size).to eq 1

      user = assigns :user
      expect(user.activated?).to eq false

      post login_path, params: {session: {email: user.email, password: user.password}}
      expect(response).to redirect_to root_url

      get edit_account_activation_path "invalid token", email: "wrong"
      expect(response).to redirect_to root_url

      get edit_account_activation_path user.activation_token, email: user.email
      expect(user.reload.activated?).to eq true

      follow_redirect!
      expect(response).to render_template "users/show"
      expect(session["user_id"]).not_to eq nil
    end
  end
end
