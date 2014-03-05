require "sepa/payments_initiation/contact_details"
require "sepa/payments_initiation/pain00800202/postal_address"
require "sepa/payments_initiation/party_choice_identification"

class Sepa::PaymentsInitiation::Pain00800202::PartyIdentification < Sepa::Base
  definition "Set of elements used to identify a person or an organisation."
  attribute :name                , "Nm"
  attribute :postal_address      , "PstlAdr"  , Sepa::PaymentsInitiation::Pain00800202::PostalAddress
  attribute :identification      , "Id"       , Sepa::PaymentsInitiation::PartyChoiceIdentification


end
