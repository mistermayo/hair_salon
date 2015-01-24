class Client
  attr_reader(:name, :date, :stylist_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @date = attributes.fetch(:date)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, date, stylist_id) VALUES ('#{@name}', '#{@date}', '#{@stylist_id}') RETURNING id;")
  end

  define_singleton_method(:all) do
    expected_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    expected_clients.each() do |client|
      name = client["name"]
      date = client["date"]
      stylist_id = client["stylist_id"].to_i()
      clients.push(Client.new({:name => name, :date => date, :stylist_id => stylist_id}))
    end
    clients
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name()).&(self.stylist_id().==(another_client.stylist_id()))
  end
end
#   define_singleton_method(:find) do |id|
#     found_client = nil
#     Client.all().each do |client|
#       if(client.stylist_id() == stylist_id)
#         found_client = client
#       end
#     end
#     found_client
#   end
# end
  # define_method(:add_stylist_to_client) do |stylist|
  #   existing_stylist = DB.exec("SELECT * FROM stylists WHERE clients_id = #{self.id()} AND stylists_id = #{stylist.id()};")
  #   if ! existing_stylist.first()
  #     DB.exec("INSERT INTO clients_stylists (clients_id, stylists_id) VALUES (#{self.id()}, #{stylist.id()});")
  #   end
  # end
  #
  # define_method(:stylists) do
  #   stylists = []
  #     returned_stylists = DB.exec("SELECT stylists.* FROM stylists JOIN clients_stylists ON (stylists.id = clients_stylists.stylists_id) JOIN clients ON (clients.id = clients_stylists.clients_id) WHERE clients.id = #{self.id()};")
  #     returned_stylists.each() do |stylist_hash|
  #       stylist_name = stylist_hash['stylist_name']
  #       id = stylist_hash['id'].to_i()
  #       stylists.push(Stylist.new({:stylist_name => stylist_name, :id => id}))
  #     end
  #   stylists
  # end
