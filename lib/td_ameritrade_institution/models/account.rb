module TDAmeritradeInstitution
  module Models
    class Account < Base
      model(:primary_owner, required: true, modeled_by: Owner)
      attribute(:rep_code)
      attribute(:account_number)
      attribute(:account_statements_preference)
      attribute(:trade_confirmations_preference)
      attribute(:ieca_preference)
      attribute(:cash_sweep_option)
    end
  end
end
