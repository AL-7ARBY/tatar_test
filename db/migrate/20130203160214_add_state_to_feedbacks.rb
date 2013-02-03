class AddStateToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :state, :string
  end
end
