class Feedback < ActiveRecord::Base
  attr_accessible :content, :email, :name, :phone

  after_create :send_mail_to_admin

  validates :content, :name, presence: true
  validate :email_or_phone_presence
  validates_format_of :email, 
    with: /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+$/,
    allow_blank: true
  validate :phone_validation

  # STATE MACHINE
  state_machine initial: :open do
    event :decline do
      transition :open => :declined
    end
    event :start do
      transition :open => :in_progress
    end
    event :resolve do
      transition :in_progress => :resolved
    end
    event :reopen do
      transition [:declined, :resolved] => :open
    end
  end

private
  def email_or_phone_presence
    if (email.blank? and phone.blank?)
      errors.add :email,
        I18n.t("activerecord.errors.models.feedback.phone_or_email_blank")
    end
  end

  # stupid validation >_<
  def phone_validation
    return if phone.blank?
    unless phone.gsub(/\D/, '').length >= 6
      errors.add :phone,
        I18n.t("activerecord.errors.models.feedback.attributes.phone.invalid")
    end
  end

  def send_mail_to_admin
    FeedbackMailer.feedback(self).deliver
  end
end
