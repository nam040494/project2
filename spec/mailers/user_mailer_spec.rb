require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let :user {FactoryGirl.create :user}
    let(:mail) { UserMailer.account_activation user}

    before do
      user.activation_token = User.new_token
    end

    it "renders the headers" do
      expect(mail.subject).to eq "Account activation"
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["from@example.com"]
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "password reset" do
    let :user {FactoryGirl.create :user}
    let :mail {UserMailer.password_reset user}

    before do
      user.reset_token = User.new_token
    end

    it {expect(mail.subject).to eq "Password reset"}
    it {expect(mail.to).to eq [user.email]}
    it {expect(mail.from).to eq ["from@example.com"]}
  end
end
