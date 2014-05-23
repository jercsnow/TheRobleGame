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
            '655 Knight Way, Stanford, CA 94305',
            '1401 N Shoreline Blvd, Mountain View, CA 94043',
            'Across the street from the Hellman Tennis Center, Berkeley, CA, United States',
            'Battery Spencer, Conzelman Rd, Sausalito, CA 94965',
            'Civic Center Plaza, Polk Gulch, San Francisco, CA 94102',
            'Palace of Fine Arts Theatre, 3301 Lyon St, San Francisco, CA 94123',
            '599 Martin Luther King Jr Dr, San Francisco, CA 94118',
            'Half Moon Bay State Beach, 95 Kelly Ave, Half Moon Bay, CA 94019',
            'Pigeon Point Lighthouse, Pigeon Point Rd, Pescadero, CA 94060',
            'The Whispering Circle'
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
            ['What.'],
            ['Hrithik Roshan'],
            ['Decade'],
            ['Faulty'],
            ['Arrested Development', 'Arrested'],
            ['Augusto Boal'],
            ['Wiggles the Clown', 'Wiggles'],
            ['MorpheusNeo1'],
            ['Pirandello'],
            ['a shot', 'a shot put', 'shot put', 'shot']
        ]
        clue_num = get_cur_clue();
        answers[clue_num - 1].each do |word|
            if(word.downcase == params[:answer].downcase) then
                cur_team.update_clue()
            end
        end
        redirect_to(:action=> :index)
    end
end
