class BrandsController < ApplicationController
  def index
    @q = Brand.ransack(params[:q])
    @brands = @q.result(:distinct => true).includes(:products).page(params[:page]).per(10)

    render("brands/index.html.erb")
  end

  def show
    @product = Product.new
    @brand = Brand.find(params[:id])

    render("brands/show.html.erb")
  end

  def new
    @brand = Brand.new

    render("brands/new.html.erb")
  end

  def create
    @brand = Brand.new


    save_status = @brand.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/brands/new", "/create_brand"
        redirect_to("/brands")
      else
        redirect_back(:fallback_location => "/", :notice => "Brand created successfully.")
      end
    else
      render("brands/new.html.erb")
    end
  end

  def edit
    @brand = Brand.find(params[:id])

    render("brands/edit.html.erb")
  end

  def update
    @brand = Brand.find(params[:id])


    save_status = @brand.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/brands/#{@brand.id}/edit", "/update_brand"
        redirect_to("/brands/#{@brand.id}", :notice => "Brand updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Brand updated successfully.")
      end
    else
      render("brands/edit.html.erb")
    end
  end

  def destroy
    @brand = Brand.find(params[:id])

    @brand.destroy

    if URI(request.referer).path == "/brands/#{@brand.id}"
      redirect_to("/", :notice => "Brand deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Brand deleted.")
    end
  end
end
