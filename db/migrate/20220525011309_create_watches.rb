class CreateWatches < ActiveRecord::Migration[6.1]
  def change
    create_table :watches do |t|
      t.integer :show_id
      t.integer :last_episode_id
      t.string :priority

      t.timestamps
    end
  end
end
