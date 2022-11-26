class Public::CustomersController < ApplicationController
    before_action :ensure_guest_customer, only: [:new, :edit, :update, :unsubscribe, :withdraw]
    
    def show
        @customer = current_customer
    end
    
    def edit
        @customer = current_customer
        if @customer != current_customer
            redirect_to customers_my_page_path
        end
    end
    
    def update
        @customer = current_customer
        if @customer.update(customer_params)
          redirect_to customers_my_page_path, notice: "You have updated customer successfully."
        else
          render :edit
        end
    end
    
    def unsubscribe
        @customer = current_customer
    end
    
    def withdraw
        @customer = current_customer
        @customer.update(is_deleted: true)
        reset_session
        flash[:notice] = "退会処理を実行いたしました"
        redirect_to root_path
    end
    
    def restaurants
       @customer = current_customer
       @restaurants = Restaurant.where(customer_id: @customer.id)
    end
    
    def reviews
        @customer = current_customer
        @reviews = Review.where(customer_id: @customer.id)
    end
    
    def customer_params
        params.require(:customer).permit(:name, :email)
    end
    
    
    
end
