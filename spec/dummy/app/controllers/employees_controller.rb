class EmployeesController < ApplicationController
  def show
    @employee = params[:employee_lookup][:employee]
  end
end
