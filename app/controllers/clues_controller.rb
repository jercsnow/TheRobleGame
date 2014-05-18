class CluesController < ApplicationController
    def index
        @clue_num = get_cur_clue();
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
