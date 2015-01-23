class Stylist
  attr_reader(:stylist_name, :id)

  define_method(:initialize) do |attributes|
    @stylist_name = attributes[:stylist_name]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (stylist_name) VALUES ('#{@stylist_name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end
  
  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      stylist_name = stylist['stylist_name']
      id = stylist['id'].to_i()
      stylists.push(Stylist.new({:stylist_name => stylist_name, :id => id}))
    end
    stylists
  end

  define_method(:==) do |another_stylist|
    self.stylist_name() == another_stylist.stylist_name() && self.id() == another_stylist.id()
  end

  define_singleton_method(:find) do |id|
    Stylist.all().each do |stylist|
      if(stylist.id() == id)
        @found_stylist = stylist
      end
    end
    @found_stylist
  end

  define_method(:add_client_to_stylist) do |client|
    existing_client = DB.exec("SELECT * FROM clients_stylists WHERE stylists_id = #{self.id()} AND clients_id = #{client.id()};")
    if ! existing_client.first()
      DB.exec("INSERT INTO clients_stylists (clients_id, stylists_id) VALUES (#{expense.id()}, #{self.id()});")
    end
  end

  define_method(:clients) do
    clients = []
      returned_clients = DB.exec("SELECT clients.* FROM clients JOIN clients_stylists ON (clients.id = clients_stylists.clients_id) JOIN stylists ON (stylists.id = clients_stylists.stylists_id) WHERE stylists.id = #{self.id()};")
      returned_clients.each() do |client_hash|
        name = client_hash['name']
        date = client_hash['date']
        id = client_hash['id'].to_i()
        clients.push(Client.new({:name => name, :date => date, :id => id}))
      end
    clients

  end
end
