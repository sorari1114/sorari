class FoodsController < ApplicationController
    before_action :authenticate_user!, except: [:top]
    def top
      @foods = Food.all
      
      @foods = Food.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
       
        # 1週間以内にいいねがついた映画を取得
     
                     
    end
    def index
        if params[:search] == nil
        @foods = Food.all
    elsif params[:search] == ''
        @foods= Food.all
      else
        @foods = Food.where("title LIKE ? OR ingredient LIKE ? OR body LIKE ?",
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    
     end
    end

      def new
        @food = Food.new
      end
    
      def create
        food = Food.new(food_params)
        food.user_id = current_user.id
        if food.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end

      def show
        @food = Food.find(params[:id])
        @comments = @food.comments
        @comment = Comment.new
      end

      def edit
        @food = Food.find(params[:id])
      end
    
      def update
        food = Food.find(params[:id])
        if food.update(food_params)
          redirect_to :action => "show", :id => food.id
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        food = Food.find(params[:id])
        food.destroy
        redirect_to action: :index
      end

      private
      def food_params
        params.require(:food).permit(:title, :ingredient, :body, :start_time, :cook, :image)
      end
end
