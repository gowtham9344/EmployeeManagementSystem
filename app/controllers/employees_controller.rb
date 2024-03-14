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
                    @employee.team.manager.is_manager = false
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
        employee1 = Employee.find(params[:id])
        employee2 = employee1.team ? employee1.team.manager : nil

        if(@employee.team)
            @employee.team.manager_id = nil
            @employee.team.save
        end
       
        if @employee.update(employee_params)
            if(@employee.is_manager == true)
                if(employee2 && employee2.team_id == @employee.team_id)
                    employee2.is_manager = 0
                    employee2.save
                elsif(@employee.team.manager)
                    @employee.team.manager.is_manager = false
                    @employee.team.manager.save
                end
                @employee.team.manager_id = @employee.id
                @employee.team.save
            else
                if(employee2 && @employee.id != employee2.id)
                    employee1.team.manager_id = employee2.id
                    employee1.team.save
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
