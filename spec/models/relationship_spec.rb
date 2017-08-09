require "rails_helper"

RSpec.describe Relationship, type: :model do
  let :user {FactoryGirl.create :user}
  let :other {FactoryGirl.create :user, name: "other", email: "other@gmail.com",
    password: "foobar", password_confirmation: "foobar"}
  let :relationship {FactoryGirl.create :relationship, follower_id: user.id,
    followed_id: other.id}

  describe "#follower_id" do
    before do
      relationship.followed_id = nil
    end

    it {expect(relationship).not_to be_valid}
  end

  describe "#followed_id" do
    before do
      relationship.followed_id = nil
    end

    it {expect(relationship).not_to be_valid}
  end
end
