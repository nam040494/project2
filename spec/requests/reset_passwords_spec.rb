require "rails_helper"

RSpec.describe "Reset password", type: :request do
  describe "password reset" do
    let :user {FactoryGirl.create :user, activated: true}

    it do
      get new_password_reset_path
      expect(response).to render_template "password_resets/new"

      post password_resets_path, params: {password_reset: {email: ""}}
      expect(response).to render_template "password_resets/new"

      post password_resets_path, params: {password_reset: {email: user.email}}
      expect(user.reset_digest).not_to eq user.reload.reset_digest
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(response).to redirect_to root_url

      user = assigns :user

      get edit_password_reset_path user.reset_token, email: ""
      expect(response).to redirect_to root_url

      get edit_password_reset_path "wrong token", email: user.email
      expect(response).to redirect_to root_url

      get edit_password_reset_path user.reset_token, email: user.email
      expect(response).to render_template "password_resets/edit"

      patch password_reset_path user.reset_token, params: {email: user.email,
        user: {password: "dkjfl", password_confirmation: "ldkf"}}
      allow(controller).to receive(:user_params) {{password: "dkjfl",
        password_confirmation: "ldkf"}}
      expect(response).to render_template "password_resets/edit"

      patch password_reset_path user.reset_token, params: {email: user.email,
        user: {password: "foobar", password_confirmation: "foobar"}}
      allow(controller).to receive(:user_params) {{password: "foobar",
        password_confirmation: "foobar"}}
      expect(session[:user_id]).not_to eq nil
      expect(response).to redirect_to user
    end
  end
end
