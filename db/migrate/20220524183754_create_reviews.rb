class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :author
      t.string :content
      t.integer :stars
      t.references :show

      t.timestamps
    end
  end
end
