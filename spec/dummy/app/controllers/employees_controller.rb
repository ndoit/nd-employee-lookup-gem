class EmployeesController < ApplicationController
  def show
    @employee = params[:employee_lookup][:employee]
  end

  def select_example
  end
  
end
