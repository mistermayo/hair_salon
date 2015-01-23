require('rspec')
require('client')
# require('spec_helper')

describe(Client) do

  describe("#name") do
    it("returns the name of the client") do
      client_1 = Client.new({:name => "sasha", :date => "2014-01-01", :id => nil})
      expect(client_1.name()).to(eq("sasha"))
    end
  end

  describe("#date") do
    it("returns the date of the appointment") do
      client_1 = Client.new({:name => "sasha", :date => "2014-01-01", :id => nil})
      expect(client_1.date()).to(eq("2014-01-01"))
    end
  end

  describe("#id") do
    it("returns the id number of the client")
      client_1 = Client.new({:name => "sasha", :date => "2014-01-01", :id => nil})
      client_1.save()
      expect(client_1.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".all") do
    it("the list of clients is empty at first") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("returns true if the name and the id are the same") do
      client_1 = Client.new({:name => "sasha", :date => "2014-01-01", :id => nil})
      client_2 = Client.new({:name => "sasha", :date => "2014-01-01", :id => nil})
      expect(client_1).to(eq(client_2))
    end
  end

  describe(".find") do
    it("returns a client by its id number") do
      client_1 = Client.new({:name => "sasha", :date => "2014-01-01", :id => nil})
      client_1.save()
      client_2 = Client.new({:name => "bill", :date => "2014-03-05", :id => nil})
      client_2.save()
      expect(Client.find(client_1.id())).to(eq(client_1))
    end
  end
end
