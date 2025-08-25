class Api::V1::CategoriesController < ApplicationController

    before_action :set_category, only: [:show, :update, :destroy]

      # GET /api/v1/categories
      def index
        @categories = Category.all
        render json: @categories
      end

      # GET /api/v1/categories/:id
      def show
        render json: @category.as_json(include: :products)
      end

      # POST /api/v1/categories
      def create
        @category = Category.new(category_params)
        if @category.save
          render json: @category, status: :created
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /api/v1/categories/:id
      def update
        if @category.update(category_params)
          render json: @category
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/categories/:id
      def destroy
        @category.destroy
        head :no_content
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end