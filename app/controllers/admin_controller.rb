class AdminController < ApplicationController
    def index
        @team = Team.new
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
        redirect_to(:action=> :index)
    end

    def signup_handler
        @team = Team.new(params[:team])
        puts "in create!!"
        if(session[:team] != nil) then
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
            render(:action=>"index")
        end    
    end

    def admin
        @all_teams = Team.all
        @cur_time = Time.now()
        @start_time = DateTime.new(2014, 5, 23, 18, 15, 0)
        puts @start_time
    end

    def logout
        reset_session
        redirect_to(:action=> :index)
    end
end
