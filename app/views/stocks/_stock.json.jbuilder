json.extract! stock, %i[id name unit_price interest duration created_at updated_at]
json.url stock_url(stock, format: :json)
