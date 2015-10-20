require "spec_helper"

describe FarMar::Vendor do
  before :each do
    @vendors = FarMar::Vendor.all
  end

  describe "#new" do
    it "create a new instance of Vendor" do
      sample_vendor_hash = {:id => 100, :name => "Test Testerson", :employees => 5000, :market_id => 4}
      sample_vendor = FarMar::Vendor.new(sample_vendor_hash)
      expect(sample_vendor).to be_an_instance_of FarMar::Vendor
    end
  end

  describe ".all" do
    it "creates a vendor object for every vendor listed in the datafile" do
      csv = CSV.read("support/vendors.csv")
      expect(@vendors.length).to eq csv.length
    end
  end

  describe ".find" do
    it "can find a vendor object with a given ID" do
      test_id = @vendors[2].vendor_id
      expect(FarMar::Vendor.find(test_id)).to eq @vendors[2]
    end
  end

end
