require('spec_helper')

describe(Stylist) do

  describe(".all") do
    it("returns empty at first") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe("#stylist_name") do
    it("returns the name of the stylist") do
      test_stylist = Stylist.new({:stylist_name => "wanda", :id => nil})
      expect(test_stylist.stylist_name()).to(eq("wanda"))
    end
  end

  describe("#id") do
    it("returns the id of a stylist") do
      test_stylist = Stylist.new({:stylist_name => "wanda", :id => nil})
      test_stylist.save()
      expect(test_stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

   describe("#save") do
    it("lets you save stylists to the database") do
      stylist = Stylist.new({:stylist_name => "wanda", :id => nil})
      stylist.save()
      expect(Stylist.all()).to(eq([stylist]))
    end
  end

  describe(":==") do
    it("returns true if stylist_name and id are the same") do
      test_stylist = Stylist.new({:stylist_name => "wanda", :id => nil})
      test_stylist2 = Stylist.new({:stylist_name => "wanda", :id => nil})
      expect(test_stylist).to(eq(test_stylist2))
    end
  end

  describe(".find") do
    it("returns a stylist by their id number") do
      test_stylist = Stylist.new({:stylist_name => "wanda", :id => nil})
      test_stylist.save()
      test_stylist2 = Stylist.new({:stylist_name => "billy", :id => nil})
      test_stylist2.save()
      expect(Stylist.find(test_stylist.id())).to(eq(test_stylist))
    end
  end

  describe("#clients") do
    it("returns an array of clients that belong to the specific stylist") do
      test_stylist = Stylist.new({:stylist_name => "wanda", :id => nil})
      test_stylist.save()
      client_1 = Client.new({:name => "sasha", :date => "2014-01-01 00:00:00", :stylist_id => test_stylist.id()})
      client_1.save()
      client_2 = Client.new({:name => "bobby", :date => "2014-01-01 00:00:00", :stylist_id => test_stylist.id()})
      client_2.save()
      expect(test_stylist.clients()).to(eq([client_1, client_2]))
    end
  end
end
