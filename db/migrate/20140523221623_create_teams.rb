class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
        t.string :first_name
        t.string :last_name
        t.string :team_name
        t.string :phone
        t.integer :clue, :default => 1
        t.integer :place
        t.datetime :time_finished
        t.string :email
        t.string :password
        t.timestamps
    end
  end
end
