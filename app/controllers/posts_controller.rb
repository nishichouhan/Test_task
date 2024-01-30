# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      share_on_twitter(@post.content)

      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def share_on_twitter(content)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'gaq6ueTgSyyU7d9RwgJoazdbg'
      config.consumer_secret     = 'LKiz4xCRhH2jeckWfoVlZahSGkCQAetm0Kux9XQHVj9Hx5fbEA'
      config.access_token        = '1752230110319513600-nY5kXq5vvPXpV5SXphUVbjQxTx56dS'
      config.access_token_secret = 'dtixmMckgcgWPAmy93NZmAGXv8XWsN6Ttsfzqtb4Q2ZJX'
    end

    tweet = "New post: #{content}"
    begin
      client.update(tweet)
    rescue Twitter::Error => e
      # Handle errors (e.g., log them, show a flash message, etc.)
      flash[:alert] = "Error sharing on Twitter: #{e.message}"
    end
  end
end
