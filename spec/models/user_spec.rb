require "rails_helper"

RSpec.describe User, type: :model do
  describe "#name" do
    subject {FactoryGirl.create :user}
    before do
      subject.name = ""
    end
    it {is_expected.not_to be_valid}
  end

  describe "#email" do
    context "email length" do
      subject {FactoryGirl.create :user}
      before do
        subject.email = "a" * 244 + "@example.com"
      end
      it {is_expected.not_to be_valid}
    end

    context "email regex" do
      subject {FactoryGirl.create :user}
      before do
        subject.email = "user@example,com"
      end
      it {is_expected.not_to be_valid}
    end

    context "email should be unique" do
      subject {FactoryGirl.create(:user).dup}
      before do
        subject.email.upcase!
      end
      it {is_expected.not_to be_valid}
    end

    context "email low-case" do
      subject {FactoryGirl.create :user}
      before do
        subject.email = "Foo@ExAMPle.CoM"
        subject.save
      end
      it {expect(subject.email.downcase).to eq(subject.reload.email)}
    end
  end

  describe "#password" do
    context "password nonblank" do
      subject {FactoryGirl.create :user}
      before do
        subject.password = subject.password_confirmation = "    "
      end
      it {is_expected.not_to be_valid}
    end

    context "password should have a minimum length" do
      subject {FactoryGirl.create :user}
      before do
        subject.password = subject.password_confirmation = "a" * 5
      end
      it {is_expected.not_to be_valid}
    end
  end

  describe "#following" do
    let :user {FactoryGirl.create :user}
    let :other {FactoryGirl.create :user, name: "other", email: "other@gmail.com",
      password: "foobar", password_confirmation: "foobar"}

    it do
      expect(user.following? other).not_to eq true

      user.follow other
      expect(user.following? other).to eq true

      user.unfollow other
      expect(user.following? other).not_to eq true
    end
  end
end
