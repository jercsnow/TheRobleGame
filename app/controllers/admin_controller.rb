class AdminController < ApplicationController
    def index
        @title = "Welcome to the Roble Game!!!"
        @team = Team.new
        if(session['cur_team'] != nil) then
            redirect_to(:controller => 'clues', :action => 'index') 
            return
        elsif (session['staff']) then
            redirect_to(:controller => 'admin', :action => 'admin') 
            return 
        end
    end

    def login_handler
        if(params[:email_login] && Team.find_by_email(params[:email_login]))
            @team = Team.find_by_email(params[:email_login])
            if(@team.password_valid?(params[:password_login])) then
                session['cur_team'] = @team
                redirect_to :controller => 'clues', :action => 'index'
                return
            end
        end
        flash[:notice] = "Either password or email are wrong. Try again. If you continue to have problems, contact Jeremy @ (916) 642-6530."
        redirect_to(:action => :index)
    end

    def signup_handler
        @team = Team.new(params[:team])
        puts "in create!!"
        if(session['cur_team'] != nil) then
            redirect_to(:controller => 'clues', :action => 'index') 
            return
        elsif @team.valid?   
            @team.save
            flash[:notice] = "Team successfully created!"
            session['cur_team'] = @team
            redirect_to(:controller => 'clues', :action => 'index') 
        else
            puts "did not validate"
            flash[:notice] = "Trouble creating team. Try Again Please."
            render(:action=> 'index')
        end    
    end

    def admin
        @title = "The Roble Game - Team Standings"
        if(session['staff'] == nil) then
            redirect_to(:controller => 'admin', :action => 'index') 
            return
        end
        @all_teams = Team.all(:order => 'clue DESC, place ASC, time_finished ASC')
        @cur_time = Time.now()
        @start_time = DateTime.new(2014, 5, 24, 1, 5, 0)
        puts @start_time
    end

    def staff
    end

    def staff_login_handler
        if(params[:password_login] and params[:password_login] == 'roblankets') then
            session['staff'] = true
            redirect_to :controller => 'admin', :action => 'admin'
        else
            # flash[:notice] = "Either password or email are wrong. Try again. If you continue to have problems, contact Jeremy @ (916) 642-6530."
            redirect_to(:action => :index)
        end
    end

    def contact
        @cur_team = true
        if(session['cur_team'] == nil) then
            redirect_to(:controller => 'admin', :action => 'index') 
            return
        end
        @title = "The Roble Game - Contact Staff"
    end

    def logout
        reset_session
        redirect_to(:action=> :index)
    end
end
