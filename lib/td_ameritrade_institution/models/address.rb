module TDAmeritradeInstitution
  module Models
    class Address < Base
      attribute(:address_line_1)
      attribute(:address_line_2)
      attribute(:state_code)
      attribute(:city)
      attribute(:zip)
      attribute(:country_code) { "United States Of America" }
    end
  end
end
