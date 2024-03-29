class Api::V1::CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_customer, only: %i[show update destroy]

  # GET /customers
  def index
    per_page = params[:per_page] || 10
    @customers = Customer.all.page(params[:page])

    if @customers.length >= 1
      render_index_json(per_page)
    else
      per_page = 0
      total_pages = 0
      render_empty_index_json(per_page)
    end
  end

  # GET /customers/1
  def show
    render json: {
             status: 'Success',
             message: 'Loaded successfully',
             data: @customer

           },
           include: [
             { facilities: { except: %i[created_at updated_at] } },
             { operations: { except: %i[created_at updated_at] } },
             { contacts: { except: %i[created_at updated_at] } }
           ]
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      render_create_customer_json
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      render json: @customer,
             include: [
               { operations: { except: %i[created_at updated_at] } }
             ]
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def customer_params
    params.require(:customer).permit(
      :fantasy_name,
      :customer_name,
      :tax_id, :status,
      :state_registration,
      :facility_id,
      :contact_id,
      operation_ids: []
    )
  end

  def render_index_json(per_page)
    render json: {
             status: 'Success',
             message: 'Loaded successfully',
             data: @customers,
             per_page: per_page.to_i,
             total_data: @customers.count,
             current_page: params[:page].to_i || 0,
             total_pages: @customers.total_pages
           },
           include: [
             { facilities: { except: %i[created_at updated_at] } },
             { operations: { except: %i[created_at updated_at] } },
             { contacts: { except: %i[created_at updated_at] } }
           ],
           except: :operation_ids
  end

  def render_empty_index_json(per_page)
    render json: {
      status: 'Success',
      message: 'There are no customers registered on this page',
      data: [],
      per_page:,
      total_data: @customers.count,
      current_page: params[:page].to_i || 0,
      total_pages: @customers.total_pages
    }
  end

  def render_create_customer_json
    render json: {
             data: @customer,
             status: 'Success',
             message: 'Saved successfully',
             location: api_v1_customer_url(@customer)
           },
           include: [
             { operations: { except: %i[created_at updated_at] } }
           ]
  end
end
