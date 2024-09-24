# README

**Ruby 3.1.0**

**Configuration:**
- PostgreSQL
- Importmap
- Bootstrap
- Rspec
- FactoryBot

**Description:**
- The app lets you add a set of products as line items to a cart.
- The app has a product index page, root
- The app has a cart show page
- The app calculates pricing discounts and sets a total price for the cart
- The app creates a new cart and stores the id in sessions, unless one exists already

**Models**
  *Product*
    - has many LineItems
    - product_code (string)
    - name (string)
    - price (float)

  *Cart*
    - has many LineItems, dependent destroy
    - total_price (float)

  *LineItem*
    - belongs to Cart
    - belongs to Product
    - quantity (integer)
