class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
def show
  item = Item.find(params[:id])
  render json: item
end

  def index
    if params[:user_id]
     user = User.find(params[:user_id])
     items = user.items
    else
    items = Item.all
    end
    render json: items, include: :user
  end


  # def create
  #   user = User.find(params[:user_id])
  #   item = user.items.create!(item_params)
  #   render json: item, :status :created
  # end

  def create
  user = User.find(params[:user_id])
  item = user.items.create!(item_params)
  render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name,:description,:price)
  end

  def render_not_found_response
    render json: {error: "Not Found"}, status: :not_found
  end
  
  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end


# item = Item.first returns the first item
# item.user  returns user's username and city.
# user = User.first
# user.items =returns all of the items under that user. 
end
