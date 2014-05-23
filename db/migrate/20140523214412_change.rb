class Change < ActiveRecord::Migration
  def change
    change_column :teams, :phone, :integer
  end
end
