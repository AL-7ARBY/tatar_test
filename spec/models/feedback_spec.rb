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
    let(:feedback) {FactoryGirl.build(:feedback)}

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

    it 'should fail when no phone and mail present' do
      feedback.phone = nil
      feedback.email = nil
      feedback.should_not be_valid
    end
  end

  it "should send mail to admin after create" do
    mailer = mock
    mailer.should_receive(:deliver)

    model = FactoryGirl.build(:feedback)
    FeedbackMailer.should_receive(:feedback).with(model).and_return(mailer)
    model.save
  end

  context "state machine" do
    let(:feedback) {FactoryGirl.create(:feedback)}

    it 'should have :open initial state' do
      feedback.state_name.should eq(:open)
    end

    it 'can be declined' do
      feedback.decline!
      feedback.state.should eq('declined')
    end

    it 'can be set in progress' do
      feedback.start!
      feedback.state.should eq('in_progress')
    end

    it "can be resolved after started" do
      feedback.start!
      feedback.resolve!
      feedback.state.should eq('resolved')
    end

    it "can't be resolved right from open state" do
      expect {
        feedback.resolve!
      }.to raise_error
    end
  end
end
