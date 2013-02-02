class FeedbackMailer < ActionMailer::Base
  default from: "feedback@tatar-test.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.feedback.subject
  #
  def feedback(model)
    @content = model.content

    mail to: "admin@tatar-test.com", subject: "Feedback from #{model.name}"
  end
end
