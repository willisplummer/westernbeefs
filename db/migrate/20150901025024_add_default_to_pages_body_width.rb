class AddDefaultToPagesBodyWidth < ActiveRecord::Migration
  def change
  	change_column_default :articles, :body_width, 600
  end
end
