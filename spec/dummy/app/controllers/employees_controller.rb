class EmployeesController < ApplicationController
  def show
    @employee = params
  end
end
