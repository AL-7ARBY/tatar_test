require 'spec_helper'

describe FeedbacksController do
  let!(:valid_attributes) {FactoryGirl.attributes_for(:feedback)}
  let!(:invalid_attributes) {FactoryGirl.attributes_for(:feedback, name: nil)}

  describe "POST 'create.json'" do
    context "with valid params" do
      it "should be created" do
        expect {
          post :create, feedback: valid_attributes, format: :json
        }.to change(Feedback, :count).by(1)
      end

      it "should return status 201" do
        post :create, feedback: valid_attributes, format: :json
        response.status.should eq(201)
      end
    end

    context "with invalid attributes" do
      it 'should not be created' do
        expect {
          post :create, feedback: invalid_attributes, format: :json
        }.to_not change(Feedback, :count)
      end

      it "should return status 422" do
        post :create, feedback: invalid_attributes, format: :json
        response.status.should eq(422)
      end

      it "should render errors" do
        post :create, feedback: invalid_attributes, format: :json
        JSON.parse(response.body)['errors'].should_not be_nil
      end
    end
  end

end
