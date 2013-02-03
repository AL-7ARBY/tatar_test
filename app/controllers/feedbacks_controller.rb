class FeedbacksController < ApplicationController
  respond_to :json

  def create
    @feedback = Feedback.create(params[:feedback])
    respond_with(@feedback, location: nil)
  end
end
