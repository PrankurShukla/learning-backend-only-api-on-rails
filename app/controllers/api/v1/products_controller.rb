class Api::V1::ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]
    before_action :authorize_admin, only: [:create, :update, :destroy]

    #GET /api/v1/products
    def index
    products = Product.page(params[:page]).per(params[:per_page] || 10)
    render json: {
        current_page: products.current_page,
        total_pages: products.total_pages,
        total_count: products.total_count,
        products: products
    }
    end

    #GET /api/v1/products/:id
    def show
        product = Product.find(params[:id])
        render json: product
    end

    # POST /api/v1/products
    def create 
        product = Product.new(product_params)
        if product.save
            render json: product, status: :created
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
        params.require(:product).permit(:name,:price,:published,:category_id)
    end
end
