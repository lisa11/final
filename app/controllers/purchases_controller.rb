class PurchasesController < ApplicationController
  before_action :current_user_must_be_purchase_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_purchase_user
    purchase = Purchase.find(params[:id])

    unless current_user == purchase.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def finish
    @q = current_user.purchases.ransack(params[:q])
    @purchases = @q.result(:distinct => true).includes(:product, :uses, :user).page(params[:page]).per(10)

    @empty = []
    @purchases.each do |purchase|
      if purchase.empty == true
        @empty.push(purchase)
      end
    end


    render("purchases/finish.html.erb")
  end

  def index
    @q = current_user.purchases.ransack(params[:q])
    @purchases = @q.result(:distinct => true).includes(:product, :uses, :user).page(params[:page]).per(10)

    @frequently = []
    @occasional = []
    @rarely = []
    @unopen = []

    @purchases.each do |purchase|
      if purchase.open_date = nil
        @unopen.push(purchase)
      else
        u = 0
        purchase.uses.each do |use|
          if use.date - Time.now < (30*24*60*60)
            u += 1
          end
        end
        if u > 20
          @frequently.push(purchase)
        elsif u > 4
          @occasional.push(purchase)
        else
          @rarely.push(purchase)
        end
      end
    end

    render("purchases/index.html.erb")
  end

  def show
    @use = Use.new
    @purchase = Purchase.find(params[:id])

    render("purchases/show.html.erb")
  end

  def new
    @purchase = Purchase.new

    render("purchases/new.html.erb")
  end

  def create
    @purchase = Purchase.new

    @purchase.product_id = params[:product_id]
    @purchase.user_id = params[:user_id]
    @purchase.rating = params[:rating]
    @purchase.note = params[:note]
    @purchase.open_date = params[:open_date]
    @purchase.empty = params[:empty]
    @purchase.estimated_number_of_uses = params[:estimated_number_of_uses]

    save_status = @purchase.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/purchases/new", "/create_purchase"
        redirect_to("/purchases")
      else
        redirect_back(:fallback_location => "/", :notice => "Purchase created successfully.")
      end
    else
      render("purchases/new.html.erb")
    end
  end

  def edit
    @purchase = Purchase.find(params[:id])

    render("purchases/edit.html.erb")
  end

  def update
    @purchase = Purchase.find(params[:id])

    @purchase.product_id = params[:product_id]
    # @purchase.user_id = params[:user_id]
    @purchase.rating = params[:rating]
    @purchase.note = params[:note]
    @purchase.open_date = params[:open_date]
    @purchase.empty = params[:empty]
    @purchase.estimated_number_of_uses = params[:estimated_number_of_uses]

    save_status = @purchase.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/purchases/#{@purchase.id}/edit", "/update_purchase"
        redirect_to("/purchases/#{@purchase.id}", :notice => "Purchase updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Purchase updated successfully.")
      end
    else
      render("purchases/edit.html.erb")
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])

    @purchase.destroy

    if URI(request.referer).path == "/purchases/#{@purchase.id}"
      redirect_to("/", :notice => "Purchase deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Purchase deleted.")
    end
  end
end
