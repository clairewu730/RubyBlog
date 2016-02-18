class PostsController < ApplicationController
	before_action :find_post, only:[:show, :destroy, :update, :edit]

	def index
		@posts = Post.all.order('created_at DESC')
	end

	def new
		if user_signed_in?
			@post = current_user.posts.build
		else
			render '_loginalert'
		end
	end

	def create
		
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to posts_path(@post)
		else
			render 'new'
		end
		
	end

	def user
		if user_signed_in
			@posts = Post.where(:user_id => params[:id]).order('created_at DESC')
			if @posts.length == 0
				render '_emptypost'
			end
		else
			render '_loginalert'
		end
	end

	def show
		if !@post
			render "_postnotfound"
		end
	end

	def edit

	end

	def update
		if @post.update(post_params)
			redirect_to posts_path(@post)
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end
	private
		def post_params
			params.require(:post).permit(:title, :body, :image)
		end

		def find_post
			@post = Post.find_by_id(params[:id])
		end
end
