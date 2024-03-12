class TeamsController < ApplicationController
    def new
        @team = Team.new
    end

    def edit
        @team = Team.find(params[:id])
    end

    def create 
        @team = Team.new(team_params)
    

        if @team.save
            if(@team.manager)
                @team.manager.team_id = @team.id
                @team.manager.is_manager = true
                @team.manager.save
            end
            redirect_to @team
        else
            render 'new'
        end
    end

    def update
        @team = Team.find(params[:id])
        puts @team.inspect
        if(@team.manager)
            @team.manager.team_id = nil
            @team.manager.is_manager = false
            @team.manager.save
        end

        if @team.update(team_params)
            if(@team.manager)
                @team.manager.team_id = @team.id
                @team.manager.is_manager = true
                @team.manager.save
            end
            
            redirect_to @team
        else
          render 'edit'
        end
    end

    def show
        @team = Team.find(params[:id])
    end

    def index
        @teams = Team.all
    end

    def destroy
        @team = Team.find(params[:id])
        if(@team.manager)
            @team.manager.is_manager = false
            @team.manager.save
        end

        @team.destroy
        redirect_to teams_path
    end

    

    private

    def team_params
        params.require(:team).permit(:name,:manager_id,employee_ids: [])
    end
end
