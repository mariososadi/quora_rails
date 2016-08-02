class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :body
      t.datetime :quest_date
      t.timestamps null: false
    end
  end
end
