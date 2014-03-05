require "sepa/payments_initiation/party_choice_identification"

class Sepa::PaymentsInitiation::Pain00800202::InitiatingPartyIdentification < Sepa::Base
  definition "Set of elements used to identify a person or an organisation."
  attribute :name                , "Nm"
  attribute :identification      , "Id"       , Sepa::PaymentsInitiation::PartyChoiceIdentification


end
