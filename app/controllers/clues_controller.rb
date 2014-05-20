class CluesController < ApplicationController
    def index
        if(session['cur_team'] == nil) then
            redirect_to(:controller => 'admin', :action => 'index') 
            return
        end
        @title = "The Roble Game - Current Clue"
        @clue_num = get_cur_clue();
        @cur_team = cur_team
        addresses = [
            'Address 1',
            'Address 2',
            'Address 3',
            'Address 4',
            'Address 5',
            'Address 6',
            'Address 7',
            'Address 8'
        ]
        @cur_address = addresses[@clue_num - 1]
        if(@cur_team.time_finished) then
            time = @cur_team.time_finished.localtime()
            @time_finished_str = time.strftime("%A at %I:%M %p")
        else
            @time_finished_str = nil
        end
        # puts "clue num", @clue_num, @clue_num.class
    end

    def question_handler
        answers = [
            'Answer 1',
            'Answer 2',
            'Answer 3',
            'Answer 4',
            'Answer 5',
            'Answer 6',
            'Answer 7',
            'Answer 8'
        ]
        clue_num = get_cur_clue();
        if(answers[clue_num-1] == params[:answer]) then
            cur_team.update_clue()
            redirect_to(:action=> :index)
        else
            redirect_to(:action=> :index)
        end
    end
end
