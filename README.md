# README

## Technology Stack

- Ruby Version: 3.1.0
- Database: PostgreSQL
- Image Hosting: Cloudinary
- Frontend: Bootstrap
- Javascript: Importmaps, Stimulus
- Tests: Rspec, FactoryBot, Capybara, Selenium

## Configuration
### Gems
- Run bundle install to install dependencies
### Database
- Create PostgreSQL database and run migrations with 'rails db:create' and 'rails db:migrate'
- Seed development data with 'rails db:seed'
### Images
- Add Cloudinary credentials to the environment variables
### Start Server
- run the command 'rails s' to start development server on localhost:3000

## Description
- The app lets you add a set of products as line items to a cart.
- The app has a product index page, root
- The app has a cart show page
- The app calculates pricing discounts and sets a total price for the cart
- The app creates a new cart and stores the id in sessions, unless one exists already

## Discounts
- Discounts are encapsulated in PricingRules service, and applied to the total price of the cart
- Make sure to update service tests when changing discounts
### Current Discounts Implemented
- Green Tea (GR1): Buy one, get one free.
- Strawberries (SR1): Buy 3 or more, and each costs 4.50€.
- Coffee (CF1): Buy 3 or more, and each costs 2/3 of the original price.


## Models
### Product
- Associations: has_many :line_items
- Attributes: product_code (string), name (string), price (float)

### Cart
- Associations: has_many :line_items, dependent: :destroy
- Behaviour: #total_price (calculates total price of line_items with discounts applied)

### LineItem
- Associations: belongs_to :cart, belongs_to :product
- Attributes: quantity (integer)

## Tests
Run tests with 'rspec'

Tests are using factories and made for:

- **Models**: Validations and Associations
- **Requests**: HTTP endpoints and reponses
- **Services**: Pricing Rules for discount logic
- **System**: Cart Flow for adding and removing items
