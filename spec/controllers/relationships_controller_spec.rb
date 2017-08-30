require "rails_helper"

RSpec.describe RelationshipsController, type: :controller do
  let :user {FactoryGirl.create :user}
  let :other {FactoryGirl.create :user, name: "other",
    email: "other@gmail.com", password: "foobar",
    password_confirmation: "foobar"}

  describe "post #create" do
    before do
      FactoryGirl.create :relationship, follower_id: user.id,
        followed_id: other.id
      post :create
    end

    it {expect(Relationship.count).to eq 1}
    it {expect(response).to redirect_to login_url}
  end

  describe "delete #destroy" do
    before do
      relationship = FactoryGirl.create :relationship, follower_id: user.id,
        followed_id: other.id
      delete :destroy, params: {id: relationship.id}
    end
    it {expect(Relationship.count).to eq 1}
    it {expect(response).to redirect_to login_url}
  end
end
