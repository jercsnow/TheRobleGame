class Place < ActiveRecord::Migration
  def change
    add_column :teams, :place, :integer
    add_column :teams, :time_finished, :datetime
  end
end
