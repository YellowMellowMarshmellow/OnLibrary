class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.float :average_review_score
      t.string :edition
      t.string :categories
      t.string :description
      t.boolean :availability
      t.timestamps
    end
  end
end
