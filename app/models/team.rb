class Team < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :team_name, :email, :phone, :password, :clue, :place, :time_finished, :password_confirmation
    attr_accessor :password_confirmation

    validates :first_name, :presence => true
    validates :last_name, :presence => true
    validates :password, :presence => true
    validates :team_name, :presence => true
    validates :email, :presence => true
    validates :phone, :presence => true
    validates_confirmation_of :password

    def password_valid?(attempted_password)
      if (self.password != attempted_password) then
        errors.add(:password, "Your password does not match.")
        return false
      else
        return true
      end
    end

    def update_clue()
        self.clue += 1
        self.time_finished = DateTime.now
        if(self.clue == 9) then
            last_place = 0
            Team.all.each do |team|
                puts "TEAM", "TEAM", team
                if team.place && team.place > last_place
                    last_place = team.place
                end
            end
            self.place = last_place + 1
            self.time_finished = DateTime.now
        end
        self.save
    end
end
