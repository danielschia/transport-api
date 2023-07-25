# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end
ESTADOS = %w[
  AC
  AL
  AM
  AP
  BA
  CE
  DF
  ES
  GO
  MA
  MG
  MS
  MT
  PA
  PB
  PE
  PI
  PR
  RJ
  RN
  RO
  RS
  RR
  SC
  SE
  SP
  TO
]
puts 'Seeding Customers'

Customer.create!([{
                   fantasy_name: Faker::Movie.title,
                   customer_name: Faker::Fantasy::Tolkien.character,
                   tax_id: Faker::Company.brazilian_company_number,
                   status: true,
                   state_registration: ESTADOS.sample
                 },
                  {
                    fantasy_name: Faker::Movie.title,
                    customer_name: Faker::Fantasy::Tolkien.character,
                    tax_id: Faker::Company.brazilian_company_number,
                    status: true,
                    state_registration: ESTADOS.sample
                  },
                  {
                    fantasy_name: Faker::Movie.title,
                    customer_name: Faker::Fantasy::Tolkien.character,
                    tax_id: Faker::Company.brazilian_company_number,
                    status: true,
                    state_registration: ESTADOS.sample
                  }])
