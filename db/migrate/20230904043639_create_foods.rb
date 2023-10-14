class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :title
      t.string :ingredient
      t.string :body
      t.string :image
      t.datetime :start_time
      t.text :cook
      t.integer :user_id

      t.timestamps
    end
  end
end
