class Sepa::PaymentsInitiation::Pain00800202::PostalAddress < Sepa::Base
  definition "Information that locates and identifies a specific address, as defined by postal services."
  attribute :country              , "Ctry"
  attribute :address_line         , "AdrLine"    , :[]
end
