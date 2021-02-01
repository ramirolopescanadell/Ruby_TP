class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name, null:false, unique: true
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
