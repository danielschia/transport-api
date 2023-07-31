require 'swagger_helper'

RSpec.describe 'api/v1/customers', type: :request do
  path '/api/v1/customers' do
    get('list customers') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create customer') do
      response(200, 'successful') do
        consumes 'application/json'        
        parameter name: :customer, in: :body, schema: {          
        type: :object,          
        properties: {            
          fantasy_name: { type: :string },
          customer_name: { type: :string },
          tax_id: { type: :string },
          status: { type: :boolean },
          state_registration: { type: :string }   
        },          
        required: %w[customer_name tax_id state_registration]  
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end


    post 'Create customer' do
      tags 'Customers'
      consumes 'application/json'
      parameter name: :customer, in: :body, schema: {
        type: :object,
        properties: {
          fantasy_name: { type: :string },
          customer_name: { type: :string },
          tax_id: { type: :string },
          status: { type: :string },
          state_registration: { type: :string }   
        },
        required: %w[customer_name tax_id state_registration] 
      }

      response '201', 'blog created' do
        let(:customer) { { customer_name: 'foo', tax_id: '123456789', state_registration: 'SP' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:customer) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/customers/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show customer') do
      response(200, 'successful') do
        let(:id) { Customer.create(customer_name: 'foo',
          tax_id: 'foo',
          status: true).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    get 'Retrieves a Customer' do
      tags 'Customers'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'customer found' do
        schema type: :object,
          properties: {
            fantasy_name: { type: :string },
            customer_name: { type: :string },
            tax_id: { type: :string },
            status: { type: :string },
            state_registration: { type: :string }   
          }

        let(:id) { Customer.create(customer_name: 'foo',
          tax_id: 'foo',
          status: true).id }
        run_test!
      end
    end

    patch('update customer') do
      response(200, 'successful') do
        let(:id)  { Customer.create(customer_name: 'foo',
          tax_id: 'foo',
          status: true).id }
        consumes 'application/json'        
        parameter name: :customer, in: :body, schema: {          
          type: :object,          
          properties: {            
            fantasy_name: { type: :string },
            customer_name: { type: :string },
            tax_id: { type: :string },
            status: { type: :boolean },
            state_registration: { type: :string }   
          }
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update customer') do
      response(200, 'successful') do
        let(:id)  { Customer.create(customer_name: 'foo',
          tax_id: 'foo',
          status: true).id }
        parameter name: :customer, in: :body, schema: {          
          type: :object,          
          properties: {            
            fantasy_name: { type: :string },
            customer_name: { type: :string },
            tax_id: { type: :string },
            status: { type: :boolean },
            state_registration: { type: :string }   
          }
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete customer') do
      response(200, 'successful') do
        let(:id)  { Customer.create(customer_name: 'foo',
          tax_id: 'foo',
          status: true).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
