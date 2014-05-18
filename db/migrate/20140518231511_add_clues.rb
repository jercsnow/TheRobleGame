class AddClues < ActiveRecord::Migration
  def change
    add_column :teams, :clue, :integer, :default => 1
  end
end
