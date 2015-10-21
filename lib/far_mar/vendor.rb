module FarMar
  class Vendor

      attr_accessor :vendors, :vendor_id, :market_id, :vendor_name
      def initialize(vendor_hash)
        @vendor_id        = vendor_hash[:id].to_i
        @vendor_name      = vendor_hash[:name]
        @num_of_employees = vendor_hash[:employees]
        @market_id        = vendor_hash[:market_id].to_i
      end

      # Returns a collection of Vendor instances, representing all the vendors described in the CSV
      def self.all
        @vendors = []
        vendors_csv = CSV.read("support/vendors.csv")

        vendors_csv.each do |id, name, num_employees, market_id|
          hash = {:id => id, :name => name, :employees => num_employees, :market_id => market_id}
          vendor = FarMar::Vendor.new(hash)
          @vendors.push(vendor)
        end
        return @vendors
      end

      # Returns an instance of Vendor that matches the search ID
      def self.find(id)
        @vendors.find do |vendor|
          vendor.vendor_id == id
        end
      end

      # Returns the FarMar::Market instance that is associated with the vendor
      def market
        FarMar::Market.find(self.market_id)
      end

      # Returns a collection of FarMar::Product instances that are associated with the vendor
      def products
        ## COME BACK TO THIS METHOD ONCE PRODUCT HAS BEEN BUILT OUT
      end

      # Returns a collection of FarMar::Sale instances that are associated with the vendor
      def sales
        sales = FarMar::Sale.all
        matched_sales = sales.find_all { |sale| sale.vendor_id == self.vendor_id}
        return matched_sales
      end

      # Returns the sum of all the vendor's sale (in cents)
      def revenue
      end

      # Returns all of the vendors with the given market ID
      def self.by_market(market_id)
        vendors = FarMar::Vendor.all
        matched_vendors = vendors.find_all { |vendor| vendor.market_id == market_id}
        return matched_vendors
      end
  end
end
