require "spec_helper"

describe FeedbackMailer do
  describe "feedback" do
    let(:feedback) { FactoryGirl.build(:feedback) }
    let(:mail) { FeedbackMailer.feedback(feedback) }

    it "renders the headers" do
      mail.subject.should eq("Feedback from #{feedback.name}")
      mail.to.should eq(["admin@tatar-test.com"])
      mail.from.should eq(["feedback@tatar-test.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match(feedback.content)
    end
  end

end
