module TDAmeritradeInstitution
  module Models
    class Owner < Base
      model(:phone, required: false, modeled_by: Phone)
      model(:mailing_address, required: false, modeled_by: Address)
      attribute(:first_name)
      attribute(:last_name)
      attribute(:birth_date)
      attribute(:email)
    end
  end
end
