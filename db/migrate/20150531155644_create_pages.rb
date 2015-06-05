class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :page_number
      t.string :slug
      t.text :body
      t.references :article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
