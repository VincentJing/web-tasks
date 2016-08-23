class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.string :content
      t.string :email
      t.boolean :status

      t.timestamps
    end
  end
end
