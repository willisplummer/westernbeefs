class AddIndexToPages < ActiveRecord::Migration
  def change
  	change_table :pages do |t|
  		t.belongs_to :paginable, polymorphic: true
  	end
  	add_index :pages, [:paginable_id, :paginable_type]
  end
end
