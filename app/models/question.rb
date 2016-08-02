class Question < ActiveRecord::Base

  belongs_to :user

  # Validation of title for questions
  validates :title, :presence => true 

  # Method for validation of empty question.
  def self.title?(question)
    question.empty?
  end

end
