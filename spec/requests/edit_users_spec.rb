require "rails_helper"

RSpec.describe "EditUsers", type: :request do
  describe "GET /edit_users" do
    let :user {FactoryGirl.create :user}
    it do
      get edit_user_path user
      expect(response).to redirect_to login_path

      post login_path, params: {session: {email: user.email, password: user.password}}
      expect(response).to redirect_to edit_user_path user
    end
  end
end
