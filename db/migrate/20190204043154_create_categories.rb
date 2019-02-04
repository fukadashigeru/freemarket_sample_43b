class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :name, null: false
      t.integer :parent_id
      t.timestamps
    end
  end
end
