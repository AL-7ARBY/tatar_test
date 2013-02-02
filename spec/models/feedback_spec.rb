require 'spec_helper'

describe Feedback do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:content) }

  context "email validation:" do
    it { should_not allow_value("blah").for(:email) }
    it { should_not allow_value("@blah.com").for(:email) }
    it { should allow_value("a@b.com").for(:email) }
  end

  context "phone validation" do
    it { should_not allow_value("blah").for(:phone) }
    it { should allow_value("+7 985 129 76 74").for(:phone) }
  end

  context "email/phone presence tests:" do
    let!(:feedback) {FactoryGirl.build(:feedback)}

    it 'should ok when only email presents' do
      feedback.phone = nil
      feedback.should be_valid
    end

    it 'should ok when only phone presents' do
      feedback.email = nil
      feedback.should be_valid
    end

    it 'should ok when both presents' do
      feedback.should be_valid
    end

    it 'should fail when no phone end mail present' do
      feedback.phone = nil
      feedback.email = nil
      feedback.shoud_not be_valid
    end
  end

  it "should send mail to admin after create" do
    model = FactoryGirl.build(:feedback)
    FeedbackMailer.should_recieve(:feedback).with(model)
    model.save
  end
end
