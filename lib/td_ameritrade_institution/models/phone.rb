module TDAmeritradeInstitution
  module Models
    class Phone < Base
      attribute(:number)
      attribute(:extension)
      attribute(:is_mobile) { false }
      attribute(:is_non_us) { false }
    end
  end
end
