# encoding: UTF-8
module Factory 
  class << self

    def order(sepa_identifier_class, remittance_information = false)
      bank_account0 = Sepa::DirectDebitOrder::BankAccount.new "FRZIZIPAPARAZZI345789", "FRZZPPKOOKOO"
      debtor0 = Sepa::DirectDebitOrder::Party.new "DALTON/CONANMR", "64, Livva de Getamire", nil, "30005", "RENNES", "France", "Conan DALTON", "01234567890", "conan@dalton.sepa.i.hope.this.works"
      mandate0 = Sepa::DirectDebitOrder::MandateInformation.new("mandate-id-0", Date.parse("2010-11-18"), "RCUR")
      dd00 = Sepa::DirectDebitOrder::DirectDebit.new debtor0, bank_account0, "MONECOLE REG F13789 PVT 3", 1231.31, "EUR", mandate0, remittance_information ? "Transaction 3" : nil
      dd01 = Sepa::DirectDebitOrder::DirectDebit.new debtor0, bank_account0, "MONECOLE REG F13791 PVT 3", 1133.33, "EUR", mandate0, remittance_information ? "We take your money" : nil

      bank_account1 = Sepa::DirectDebitOrder::BankAccount.new "FRQUIQUIWIGWAM947551", "FRQQWIGGA"
      debtor1 = Sepa::DirectDebitOrder::Party.new "ADAMS/SAMUELMR", "256, Livva de Getamire", nil, "75048", "BERLIN", "Germany", "Samuel ADAMS", "09876543210", "samuel@adams.sepa.i.hope.this.works"
      mandate1 = Sepa::DirectDebitOrder::MandateInformation.new("mandate-id-1", Date.parse("2012-01-19"), "FRST")
      dd10 = Sepa::DirectDebitOrder::DirectDebit.new debtor1, bank_account1, "MONECOLE REG F13790 PVT 3", 1732.32, "EUR", mandate1, remittance_information ? "An important transaction" : nil
      dd11 = Sepa::DirectDebitOrder::DirectDebit.new debtor1, bank_account1, "MONECOLE REG F13792 PVT 3", 1034.34, "EUR", mandate1, remittance_information ? "Thank you, for the money" : nil

      bank_account2 = Sepa::DirectDebitOrder::BankAccount.new "  FR QU IQ UI WI GW\tAM   947 551  ", "FRQQWIGGA"
      debtor2 = Sepa::DirectDebitOrder::Party.new "Mr. James Joyce", "512, Livva de Meet Agir", nil, "75099", "LONDON", "Angleterre", "Johann S. BACH", "09876543210", "js@bach.sepa.i.hope.this.works"
      mandate2 = Sepa::DirectDebitOrder::MandateInformation.new("mandate-id-2", Date.parse("2013-06-08"), "RCUR")
      dd20 = Sepa::DirectDebitOrder::DirectDebit.new debtor2, bank_account2, "MONECOLE REG F13793 PVT 3", 1935.35, "EUR", mandate2, remittance_information ? "Another one" : nil
      dd21 = Sepa::DirectDebitOrder::DirectDebit.new debtor2, bank_account2, "MONECOLE REG F13794 PVT 3", 1236.36, "EUR", mandate2, remittance_information ? "Final transaction" : nil

      sepa_now = Time.local(1992, 2, 28, 18, 30, 0, 0, 0)
      Time.stub(:now).and_return sepa_now

      creditor = Sepa::DirectDebitOrder::Party.new "Mon École", "3, Livva de Getamire", nil, "75022", "Paris", "Frankreich", "M. le Directeur", "+33 999 999 999", "directeur@monecole.softify.com"
      creditor_account = Sepa::DirectDebitOrder::BankAccount.new "FRGOO GOOY ADDA 9999 999", "FRGGYELLOW99"
      sepa_identifier = sepa_identifier_class.new "FR123ZZZ010203"
      payment = Sepa::DirectDebitOrder::CreditorPayment.new creditor, creditor_account, "MONECOLE_PAYMENTS_20130703", Date.parse("2013-07-10"), sepa_identifier, [dd00, dd01, dd10, dd11, dd20, dd21]

      initiator = Sepa::DirectDebitOrder::Party.new "SOFTIFY SARL", "289, Livva de Getamire", nil, "75021", "Paris", "FR", "M. Le Gérant", "+33 111 111 111", "gerant@softify.bigbang"

      Sepa::DirectDebitOrder::Order.new "MSG0001", initiator, [payment]
    end

  end
end # Factory
