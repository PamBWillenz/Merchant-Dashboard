# README

# Merchant-Dashboard

## Ruby and Rails version

- 3.3.0
- 7.1.4

## System dependencies

- PostgreSQL
- Node.js
- Yarn

## Configuration

Clone the repository:
git clone https://github.com/PamBWillenz/Merchant-Dashboard

## Database create

rails db:create
rails db:migrate

## Database initialization

rails db:seed

## How to run the test suite

bundle exec rspec

## Run Application Locally

- Start the Rails server
  rails server
- Start the React development server
  yarn start
- open browser to
  http://localhost:3000

# API Endpoints

## Merchants

## Get All Merchants

- URL: /api/v1/merchants
- Method: GET
- Response:

```
[
  {
    "id": 1,
    "name": "Merchant 1",
    "created_at": "2024-10-01T00:00:00.000Z",
    "updated_at": "2024-10-01T00:00:00.000Z"
  },
  {
    "id": 2,
    "name": "Merchant 2",
    "created_at": "2024-10-01T00:00:00.000Z",
    "updated_at": "2024-10-01T00:00:00.000Z"
  }
]
```

## Customer Returns

## Get All Customer Returns

- URL: /api/v1/customer_returns
- Method: GET
- Response:

```
  [
      {
      "id": 1,
      "order_date": "2024-10-01T00:00:00.000Z",
      "registered_date": "2024-10-10T00:00:00.000Z",
      "status": "pending",
      "merchant_id": 1,
      "items": [
        {
        "id": 1,
        "name": "Shirt",
        "price": 25.0
        },
        {
        "id": 2,
        "name": "Pants",
        "price": 40.0
        }
      ]
    }
  ]
```

## Update Customer Return Status

- URL: /api/v1/customer_returns/:id
- Method: PUT
- Request Body:

```
{
  "customer_return": {
    "status": "approved"
  }
}
```

- Response:

```
{
  "id": 1,
  "order_date": "2024-10-01T00:00:00.000Z",
  "registered_date": "2024-10-10T00:00:00.000Z",
  "status": "approved",
  "merchant_id": 1
}
```

## Refund Customer Return

- URL: /api/v1/customer_returns/:id/refund
- Method: POST
- Response

```
{
  "id": 1,
  "order_date": "2024-10-01T00:00:00.000Z",
  "registered_date": "2024-10-10T00:00:00.000Z",
  "status": "refunded",
  "merchant_id": 1
}
```
