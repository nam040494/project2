require "rails_helper"

RSpec.describe "Users Login", type: :request do
  describe "GET /login" do
    before do
      get login_path
    end

    it {expect(response).to render_template "sessions/new"}
  end

  describe "POST /login" do
    let :user {FactoryGirl.create :user}

    it do
      post login_path, params: {session: {email: user.email, password: user.password}}

      expect(response).to redirect_to user
      follow_redirect!

      expect(response).to render_template "users/show"
      expect(response.body).to include logout_path
      expect(response.body).not_to include login_path
      expect(response.body).to include user_path user

      delete logout_path

      expect(response).to redirect_to root_url
      follow_redirect!

      expect(response.body).to include login_path
    end

    context "login with remembering" do
      before do
        post login_path, params: {session: {email: user.email, password: user.password, remember_me: "1"}}
      end

      it {expect(response.cookies["remember_token"]).not_to eq nil}
    end

    context "login without remembering" do
      before do
        post login_path, params: {session: {email: user.email, password: user.password, remember_me: "1"}}
        post login_path, params: {session: {email: user.email, password: user.password, remember_me: "0"}}
      end

      it {expect(response.cookies["remember_token"]).to eq nil}
    end
  end
end
