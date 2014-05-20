class ApplicationController < ActionController::Base
    protect_from_forgery

    def cur_team
        return session['cur_team']
    end


    def get_cur_clue
        puts "cur", cur_team()
        if(cur_team() && cur_team().clue) then
            return cur_team().clue
        else
            return nil
        end 
    end
end
