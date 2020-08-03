##
# class ApplicationController < ActionController::Base
# 	protect_from_forgery with: :exception
# end
##  
class ArticlesController < ApplicationController
# Place standard CRUD actions in each controller in the following order:
# index, show, new, edit, create, update and destroy. 
http_basic_authenticate_with name: "root", password: "", except: [:index, :show]
	def index
		@articles = Article.all
	# otherwise @article would be nil in our view
	end
	def show
		@article = Article.find(params[:id])
	end	
	def new
		@article = Article.new
	end	
	def create
		@article = Article.new(article_params)
	 
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end
# Every Rails model can be initialized with 
# its respective attributes, which are automatically mapped to 
# the respective database columns. In the first line we do just 
# that (remember that params[:article] contains the attributes 
# we're interested in). Then, @article.save is responsible for saving the model in the database. Finally, we redirect the user to the show action, which we'll define later.z

def edit
  @article = Article.find(params[:id])
end
 
# def create
# 	# render plain: params[:article].inspect
# 	# @article = Article.new(params[:article] )
# 	@article = Article.new(article_params)
# # Model Attr init map to DB column- Article is class in models/article.rb
# 	if @article.save
# 		redirect_to @article
# 	else
# 		render 'new'
# 		#rendering is done within the same request as the form submission, whereas the redirect_to will tell the browser to issue another request.
# 	end
# end
def update
  @article = Article.find(params[:id])
 
  if @article.update(article_params)
    redirect_to @article
  else
    render 'edit'
  end
end

def destroy
  @article = Article.find(params[:id])
  @article.destroy
 
  redirect_to articles_path
end

private
#actored out into its own method so it can be reused by multiple actions in the same controller, for example create and update
  def article_params
# Strong parameters security feature- which parameters allowed into controller actions
# The ability to grab and automatically assign all controller parameters to your model in one shot makes the programmer's job easier, but this convenience also allows malicious use
    params.require(:article).permit(:title, :text)
  end
end

# Prefix Verb   URI Pattern                  Controller#Action
# welcome_index GET    /welcome/index(.:format)     welcome#index
#      articles GET    /articles(.:format)          articles#index
#               POST   /articles(.:format)          articles#create
#   new_article GET    /articles/new(.:format)      articles#new
#  edit_article GET    /articles/:id/edit(.:format) articles#edit
#       article GET    /articles/:id(.:format)      articles#show
#               PATCH  /articles/:id(.:format)      articles#update
#               PUT    /articles/:id(.:format)      articles#update
#               DELETE /articles/:id(.:format)      articles#destroy
#          root GET    /                            welcome#index