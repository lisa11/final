class UsesController < ApplicationController
  before_action :current_user_must_be_use_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_use_user
    use = Use.find(params[:id])

    unless current_user == use.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @uses = current_user.uses.page(params[:page]).per(10)

    render("uses/index.html.erb")
  end

  def show
    @use = Use.find(params[:id])

    render("uses/show.html.erb")
  end

  def new
    @use = Use.new

    render("uses/new.html.erb")
  end

  def create
    @use = Use.new

    @use.purchase_id = params[:purchase_id]
    @use.user_id = params[:user_id]
    @use.date = params[:date]

    save_status = @use.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/uses/new", "/create_use"
        redirect_to("/uses")
      else
        redirect_back(:fallback_location => "/", :notice => "Use created successfully.")
      end
    else
      render("uses/new.html.erb")
    end
  end

  def edit
    @use = Use.find(params[:id])

    render("uses/edit.html.erb")
  end

  def update
    @use = Use.find(params[:id])

    @use.purchase_id = params[:purchase_id]
    @use.user_id = params[:user_id]
    @use.date = params[:date]

    save_status = @use.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/uses/#{@use.id}/edit", "/update_use"
        redirect_to("/uses/#{@use.id}", :notice => "Use updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Use updated successfully.")
      end
    else
      render("uses/edit.html.erb")
    end
  end

  def destroy
    @use = Use.find(params[:id])

    @use.destroy

    if URI(request.referer).path == "/uses/#{@use.id}"
      redirect_to("/", :notice => "Use deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Use deleted.")
    end
  end
end
