class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
        t.string :first_name
        t.string :last_name
        t.string :team_name
        t.number :phone
        t.string :email
        t.string :password
        t.timestamps
    end
  end
end
