class Answer < ActiveRecord::Base

  belongs_to :questions
  belongs_to :authored_by, class_name: "User", foreign_key: "user_id"

  validates :body, :presence => true

  def self.body?(answer)
    answer.empty?
  end

end
