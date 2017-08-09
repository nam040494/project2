require "rails_helper"

RSpec.describe Micropost, type: :model do
  let :user {FactoryGirl.create :user}

  describe "#user_id" do
    context "valid user_id" do
      subject {user.microposts.build content: "dkjfl"}

      it {is_expected.to be_valid}
    end

    context "invalid user_id" do
      subject {user.microposts.build content: "dkjfl"}

      before do
        subject.user_id = nil
        subject.save
      end

      it {is_expected.to be_valid}
    end
  end

  describe "#content" do
    context "present content" do
      subject {user.microposts.build content: "dflk"}

      before do
        subject.update_attribute :content, "   "
      end
      it {is_expected.not_to be_valid}
    end

    context "at most 140 characters" do
      subject {user.microposts.build content: "kdjlk"}

      before do
        subject.update_attribute :content, "a" * 141
      end
      it {is_expected.not_to be_valid}
    end
  end

  describe "default order" do
    let :user {FactoryGirl.create :user}
    let :micropost {user.microposts.create content: "dkfl"}

    before do
      3.times do |n|
        user.microposts.create content: Faker::Name.name
      end
    end

    it {expect(micropost).to eq user.microposts.first}
  end

  describe "dependent destroy" do
    let :user {FactoryGirl.create :user}

    it do
      user.microposts.create content: "jflkd"
      expect(Micropost.count).to eq 1

      user.destroy
      expect(Micropost.count).to eq 0
    end
  end
end
