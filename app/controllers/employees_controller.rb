class EmployeesController < ApplicationController
    def new
        @employee = Employee.new
    end

    def edit
        @employee = Employee.find(params[:id])
    end

    def create 
        @employee = Employee.new(employee_params)
       
        
        if @employee.save
            if(@employee.is_manager)
                if(@employee.team.manager)
                    @employee.team.manager.is_manager = 0
                    @employee.team.manager.save
                end
                @employee.team.manager_id = @employee.id
                @employee.team.save
            end
            redirect_to @employee
        else
            render 'new'
        end
    end

    def update
        @employee = Employee.find(params[:id])
       
        if @employee.update(employee_params)
            if(@employee.is_manager == 1)
                if(@employee.team.manager)
                    @employee.team.manager.is_manager = 0
                    @employee.team.manager.save
                end
                @employee.team.manager_id = @employee.id
                @employee.team.save
            else
                if(@employee.team && @employee.team.manager && @employee.team.manager_id == @employee.id)
                    @employee.team.manager_id = nil
                    @employee.team.save
                end
            end
            redirect_to @employee
        else
           render 'edit'
        end
    end

    def destroy
        @employee = Employee.find(params[:id])

        if @employee.is_manager?
            @employee.team.manager_id = nil
            @employee.team.save
        end

        @employee.destroy
       
        redirect_to employees_path
    end

    def show
        @employee = Employee.find(params[:id])
    end

    def index
        @employees = Employee.all
    end

    private

    def employee_params
        params.require(:employee).permit(:name,:email,:address,:mobile, :team_id,:is_manager)
    end

end
