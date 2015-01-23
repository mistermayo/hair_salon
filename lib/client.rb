class Client
  attr_reader(:name, :date, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @date = attributes[:date]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    expected_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    expected_clients.each() do |client|
      name = client["name"]
      date = client["date"]
      id = client["id"].to_i()
      clients.push(Client.new({:name => "sasha", :date => "2014-01-01", :id => nil})
    end
    clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, date) VALUES ('#{name}', '#{date}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  define_method(:==) do |another_client|
    self.name() == another_client.name() && self.id() == another_client.id() && self.date() == another_client.date()
  end

  define_singleton_method(:find) do |id|
    Client.all().each do |client|
      if(client.id() == id)
        @found_client = client
      end
    end
    @found_client
  end
end
#
#     define_method(:categories) do
#     categories = []
#       returned_categories = DB.exec("SELECT categories.* FROM categories JOIN expenses_categories ON (categories.id = expenses_categories.categories_id) JOIN expenses ON (expenses.id = expenses_categories.expenses_id) WHERE expenses.id = #{self.id()};")
#       returned_categories.each() do |category_hash|
#         category_name = category_hash['category_name']
#         id = category_hash['id'].to_i()
#         categories.push(Category.new({:category_name => category_name, :id => id}))
#       end
#     categories
#   end
#
# end
