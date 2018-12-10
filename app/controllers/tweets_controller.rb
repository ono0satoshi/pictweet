class TweetsController < ApplicationController

  #before_action :move_to_index, except: :index

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new

  end

  def create

    Tweet.create(image: tweet_params[:image],text: tweet_params[:text],user_id: current_user.id)

  end


def destroy
  tweet =Tweet.find(params[:id])
  tweet.destroy if tweet.user_id == current_user.id
  # if tweet.user_id == current_user.id
  #   tweet.destroy
  # end
end

def edit
  @tweet = Tweet.find(params[:id])
end

def update
  tweet = Tweet.find(params[:id])
  tweet.update(tweet_params) if tweet.user_id == current_user.id
end

def show
  @tweet = Tweet.find(params[:id])
  @comments = @tweet.comments.includes(:user)
end

  private
  def tweet_params
    params.permit(:image, :text)

  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
