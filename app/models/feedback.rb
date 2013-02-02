class Feedback < ActiveRecord::Base
  attr_accessible :content, :email, :name, :phone

  after_create :send_mail_to_admin

  validates :content, :name, presence: true
  validate :email_or_phone_presence
  validates_format_of :email, with: /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+$/, allow_nil: true
  validate :phone_validation, allow_nil: true

private
  def email_or_phone_presence
    unless (email or phone)
      errors.add (email ? :phone : :email),
        I18n.t("activerecord.errors.models.feedback.phone_or_email_blank")
    end
  end

  # stupid validation >_<
  def phone_validation
    return unless phone
    unless phone.gsub(/\D/, '').length >= 6
      errors.add :phone,
        I18n.t("activerecord.errors.models.feedback.attributes.phone.invalid")
    end
  end

  def send_mail_to_admin
    FeedbackMailer.feedback(self).deliver
  end
end
