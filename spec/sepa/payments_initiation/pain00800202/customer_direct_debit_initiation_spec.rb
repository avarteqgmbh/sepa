# -*- coding: utf-8 -*-

require "spec_helper"

describe Sepa::PaymentsInitiation::Pain00800202::CustomerDirectDebitInitiation do

  let(:props) {
    { "group_header.message_identification"                                    => "MSG0001",
      "group_header.creation_date_time"                                        => "1992-02-28T18:30:00Z",
      "group_header.number_of_transactions"                                    => "2",
      "group_header.control_sum"                                               => "2963.63",
      "group_header.initiating_party.name"                                     => "SOFTIFY SARL",
      "payment_information[0].payment_information_identification"              => "MONECOLE_PAYMENTS_20130703",
      "payment_information[0].payment_method"                                  => "DD",
      "payment_information[0].payment_type_information.service_level.code"     => "SEPA",
      "payment_information[0].payment_type_information.local_instrument.code"  => "CORE",
      "payment_information[0].payment_type_information.sequence_type"          => "OOFF",
      "payment_information[0].requested_collection_date"                       => "2013-07-10",
      "payment_information[0].number_of_transactions"                          => "2",
      "payment_information[0].control_sum"                                     => "2963.63",
      "payment_information[0].creditor.name"                                   => "Mon École",
      "payment_information[0].creditor.postal_address.address_line[0]"         => "3, Livva de Getamire",
      "payment_information[0].creditor.postal_address.country"                 => "FR",
      "payment_information[0].creditor_account.identification.iban"            => "FRGOOGOOYADDA9999999",
      "payment_information[0].creditor_agent.financial_institution_identification.bic_fi"                                                          => "FRGGYELLOW99",
      "payment_information[0].direct_debit_transaction_information[0].payment_identification.end_to_end_identification"                            => "MONECOLE REG F13789 PVT 3",
      "payment_information[0].direct_debit_transaction_information[0].instructed_amount"                                                           => "1231.31",
      "payment_information[0].direct_debit_transaction_information[0].instructed_amount_currency"                                                  => "EUR",
      "payment_information[0].direct_debit_transaction_information[0].direct_debit_transaction.mandate_related_information.mandate_identification" => "mandate-id-0",
      "payment_information[0].direct_debit_transaction_information[0].debtor_agent.financial_institution_identification.bic_fi"                    => "FRZZPPKOOKOO",
      "payment_information[0].direct_debit_transaction_information[0].debtor.name"                                                                 => "DALTON/CONANMR",
      "payment_information[0].direct_debit_transaction_information[0].debtor.postal_address.address_line[0]"                                       => "64, Livva de Getamire",
      "payment_information[0].direct_debit_transaction_information[0].debtor.postal_address.country"                                               => "FR",
      "payment_information[0].direct_debit_transaction_information[0].debtor_account.identification.iban"                                          => "FRZIZIPAPARAZZI345789",
      "payment_information[0].direct_debit_transaction_information[1].payment_identification.end_to_end_identification"                            => "MONECOLE REG F13790 PVT 3",
      "payment_information[0].direct_debit_transaction_information[1].payment_type_information.sequence_type"                                      => "FRST",
      "payment_information[0].direct_debit_transaction_information[1].instructed_amount"                                                           => "1732.32",
      "payment_information[0].direct_debit_transaction_information[1].instructed_amount_currency"                                                  => "EUR",
      "payment_information[0].direct_debit_transaction_information[1].direct_debit_transaction.mandate_related_information.mandate_identification" => "mandate-id-1",
      "payment_information[0].direct_debit_transaction_information[1].debtor_agent.financial_institution_identification.bic_fi"                    => "FRQQWIGGA",
      "payment_information[0].direct_debit_transaction_information[1].debtor.name"                                                                 => "ADAMS/SAMUELMR",
      "payment_information[0].direct_debit_transaction_information[1].debtor.postal_address.address_line[0]"                                       => "256, Livva de Getamire",
      "payment_information[0].direct_debit_transaction_information[1].debtor.postal_address.country"                                               => "FR",
      "payment_information[0].direct_debit_transaction_information[1].debtor_account.identification.iban"                                          => "FRQUIQUIWIGWAM947551",
    }
  }

  it "should raise an error unless the version is '02'" do
    pain = Sepa::PaymentsInitiation::Pain00800202::CustomerDirectDebitInitiation.new(props)
    expect { pain.generate_xml(:pain_008_002_version => '2') }.to raise_error
    expect { pain.generate_xml(:pain_008_002_version => 2) }.to raise_error
    expect { pain.generate_xml(:pain_008_002_version => "") }.to raise_error
    expect { pain.generate_xml({ }) }.to raise_error
  end

  it "should produce xml corresponding to the given inputs" do
    xml = Sepa::PaymentsInitiation::Pain00800202::CustomerDirectDebitInitiation.new(props).generate_xml(:pain_008_002_version => '02')
    xml = check_doc_header_002_02 xml
    expected = File.read(File.expand_path("../../../../support/expected-simple-002-02.xml", __FILE__))
    expected.force_encoding(Encoding::UTF_8) if expected.respond_to? :force_encoding
    xml.should == expected
  end
end
