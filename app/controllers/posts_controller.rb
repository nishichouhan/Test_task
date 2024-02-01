class PostsController < ApplicationController
    before_action :authenticate_user!

    def create
	    @post = current_user.posts.new(content: params[:content])

	    if @post.save
	      TwitterService.post_tweet(params[:content], current_user)

	      redirect_to root_path, notice: 'Post was successfully created.'
	    else
	      render :new
	    end
    end
 end







