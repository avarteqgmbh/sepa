require 'sepa/payments_initiation/branch_and_financial_institution_identification'
require 'sepa/payments_initiation/authorisation'
require 'sepa/payments_initiation/pain00800202/party_identification'
require 'sepa/payments_initiation/pain00800202/initiating_party_identification'

class Sepa::PaymentsInitiation::Pain00800202::GroupHeader < Sepa::Base
  definition "Set of characteristics shared by all individual transactions included in the message."
  attribute :message_identification, "MsgId"
  attribute :creation_date_time    , "CreDtTm", Time
  attribute :number_of_transactions, "NbOfTxs"
  attribute :control_sum           , "CtrlSum"
  attribute :initiating_party      , "InitgPty", Sepa::PaymentsInitiation::Pain00800202::InitiatingPartyIdentification
  attribute :authorisation         , "Authstn", Sepa::PaymentsInitiation::Authorisation
  attribute :forwarding_agent      , "FwdgAgt", Sepa::PaymentsInitiation::BranchAndFinancialInstitutionIdentification
end
