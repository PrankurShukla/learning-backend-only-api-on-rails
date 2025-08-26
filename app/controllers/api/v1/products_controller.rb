class Api::V1::ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]
    before_action :authorize_admin, only: [:create, :update, :destroy]
    #GET /api/v1/products
    def index
    products = Product.page(params[:page]).per(params[:per_page] || 10)
    render json: {
        data: products.map { |p| product_json(p) },
        pagination: {
        current_page: products.current_page,
        total_pages: products.total_pages,
        total_count: products.total_count
        }
    }
    end


    #GET /api/v1/products/:id
    def show
        product = Product.find(params[:id])
        render json: product_json(product)
    end

    # POST /api/v1/products
    def create 
        product = Product.new(product_params)
        if params[:image].present?
            product.image.attach(params[:image]) if params[:image].present?
        end

        if product.save
            render json: product_json(product), status: :created
        else
            render json: {errors: product.errors.full_messages}, status: :unprocessable_entity  
        end
    end

    # PATCH /api/v1/products/:id
    def update
        product = Product.find(params[:id])
        if product.update(product_params)
            render json: product
        else
            render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
        end
    end

    # DELETE /api/v1/products/:id
    def destroy
        product = Product.find(params[:id])
        product.destroy
        head :no_content
    end

    def set_product
        @product = Product.find(params[:id])
    end


    def product_params
        #strong params-> only allow whitelisted fiels
        params.permit(:name,:price,:published,:category_id,:image,:description)
    end

def product_json(product)
    {
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      category_id: product.category_id,
      image_url: product.image.attached? ? url_for(product.image) : nil
    }
  end

end
