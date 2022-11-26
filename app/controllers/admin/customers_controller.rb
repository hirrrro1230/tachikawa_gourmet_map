class Admin::CustomersController < ApplicationController
    def show
       @customer = Customer.find(params[:id])
    end
    
    def index
        @customers = Customer.all
    end
    
    def edit
        @customer = Customer.find(params[:id])
    end
    
    def update
        @customer = Customer.find(params[:id])
        if @customer.update(customer_params)
          redirect_to admin_customer_path(@customer.id), notice: "You have updated customer successfully."
        else
          render :edit
        end
    end
    
    private
    def if_not_admin
    redirect_to root_path unless current_admin
    end
    def customer_params
        params.require(:customer).permit(:name, :email, :is_deleted)
    end
    
end
