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
      clients.push(Client.new({:name => name, :date => date, :id => id}))
    end
    clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, date) VALUES ('#{@name}', '#{@date}') RETURNING id;")
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

  define_method(:add_stylist_to_client) do |stylist|
    existing_stylist = DB.exec("SELECT * FROM clients_stylists WHERE clients_id = #{self.id()} AND stylists_id = #{stylist.id()};")
    if ! existing_stylist.first()
      DB.exec("INSERT INTO clients_stylists (clients_id, stylists_id) VALUES (#{self.id()}, #{stylist.id()});")
    end
  end

  define_method(:stylists) do
    stylists = []
      returned_stylists = DB.exec("SELECT stylists.* FROM stylists JOIN clients_stylists ON (stylists.id = clients_stylists.stylists_id) JOIN clients ON (clients.id = clients_stylists.clients_id) WHERE clients.id = #{self.id()};")
      returned_stylists.each() do |stylist_hash|
        stylist_name = stylist_hash['stylist_name']
        id = stylist_hash['id'].to_i()
        stylistss.push(Stylist.new({:stylist_name => stylist_name, :id => id}))
      end
    stylists
  end

end
