class UsersController < ApplicationController
    def index
        @users = User.all
        render json: @users, adaptor: :json
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user,staus:200, adaptor: :json
        else
            render json: {error: "User cannot be added"}, status: 400
        end
    end

    def show
        @user = User.find_by_id(params[:id])
        if @user
            render json: @user, adaptor: :json
        else
            render json: {error: "User not present"}, status: 404
        end
    end

    def update
        @user = User.find_by_id(params[:id])
        if @user
            @user.update(user_params)
            render json: @user
        else
            render json: {error: "User not present"}, status: 404
        end
    end

    def destroy
        @user = User.find_by_id(params[:id])
        if @user
            @user.destroy
            render json: {success: "User deleted successfully"}, status:200
        else
            render json: {error: "User not present"}, status: 404
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name)
    end
end
