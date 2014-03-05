# -*- coding: utf-8 -*-

require "spec_helper"
require "time"

require "sepa/payments_initiation"

describe Sepa::DirectDebitOrder do
  describe Sepa::DirectDebitOrder::PrivateSepaIdentifier do
    it "should produce v02 xml corresponding to the given inputs" do
      o = Factory.order(Sepa::DirectDebitOrder::PrivateSepaIdentifier)
      xml = o.to_xml :pain_008_001_version => "02"
      xml = check_doc_header_02 xml
      expected = File.read(File.expand_path("../expected_customer_direct_debit_initiation_v02.xml", __FILE__))
      expected.force_encoding(Encoding::UTF_8) if expected.respond_to? :force_encoding
      xml.should == expected
    end

    it "should produce v02 xml corresponding to the given inputs with unstructured remittance information" do
      o = Factory.order(Sepa::DirectDebitOrder::PrivateSepaIdentifier, true)
      xml = o.to_xml :pain_008_001_version => "02"
      xml = check_doc_header_02 xml
      expected = File.read(File.expand_path("../expected_customer_direct_debit_initiation_v02_with_remittance_information.xml", __FILE__))
      expected.force_encoding(Encoding::UTF_8) if expected.respond_to? :force_encoding
      xml.should == expected
    end

    it "should produce v04 xml corresponding to the given inputs" do
      o = Factory.order(Sepa::DirectDebitOrder::PrivateSepaIdentifier)
      xml = o.to_xml :pain_008_001_version => "04"
      xml = check_doc_header_04 xml
      expected = File.read(File.expand_path("../expected_customer_direct_debit_initiation_v04.xml", __FILE__))
      expected.force_encoding(Encoding::UTF_8) if expected.respond_to? :force_encoding
      xml.should == expected
    end
  end # Sepa::DirectDebitOrder::PrivateSepaIdentifier

  describe Sepa::DirectDebitOrder::OrganisationSepaIdentifier do
  it "should produce v04 xml corresponding to the given inputs with an organisation identifier for the creditor" do
    o = Factory.order(Sepa::DirectDebitOrder::OrganisationSepaIdentifier)
    xml = o.to_xml :pain_008_001_version => "04"
    xml = check_doc_header_04 xml
    expected = File.read(File.expand_path("../expected_customer_direct_debit_initiation_v04_with_org_id.xml", __FILE__))
    expected.force_encoding(Encoding::UTF_8) if expected.respond_to? :force_encoding
    xml.should == expected
  end
  end # Sepa::DirectDebitOrder::OrganisationSepaIdentifier

  describe Sepa::DirectDebitOrder do
    describe Sepa::DirectDebitOrder::InitParty do
      context 'PAIN.008.002.02' do
        subject do
          Sepa::DirectDebitOrder::InitParty.new(
            'Homer Simpson',
            'Evergreen Terrace',
            nil,
            12345,
            'Springfield',
            'us',
            'Homer Simpson',
            '12334565778',
            'homer@comglobal.com'
          )
        end

        it 'should attent to PAIN.008.002.02 norm' do
          result_hash = subject.to_properties(:debitor, :pain_008_002_version => '02')
          result_hash.should have(1).keys
          result_hash.keys.should include('debitor.name') 
        end
      end # PAIN.008.002.02
    end # Sepa::DirectDebitOrder::InitParty

    describe Sepa::DirectDebitOrder::Party do
      it "should not produce empty address elements" do
        debtor = Sepa::DirectDebitOrder::Party.new "M Conan Dalton", "", nil, "", "", nil, nil, "", ""
        props = debtor.to_properties "x", { }
        props["x.name"].should == "M Conan Dalton"
        props.keys.length.should == 1
      end


      context 'PAIN.008.002.02' do
        subject do
          Sepa::DirectDebitOrder::Party.new(
            'Homer Simpson',
            'Evergreen Terrace',
            nil,
            '12345',
            'Springfield',
            'us',
            'Homer Simpson',
            '12334565778',
            'homer@comglobal.com'
          )
        end

        it 'should attent to PAIN.008.002.02 norm' do
          result_hash = subject.to_properties(:debitor, :pain_008_002_version => '02')
          result_hash.should have(3).keys
          result_hash.keys.should include('debitor.name') 
          result_hash.keys.should include('debitor.postal_address.address_line[0]') 
          result_hash.keys.should include('debitor.postal_address.address_line[1]') 
        end
      end # PAIN.008.002.02
    end # Sepa::DirectDebitOrder::Party

    describe Sepa::DirectDebitOrder::DirectDebit do
      let(:mandate_info) do
        Sepa::DirectDebitOrder::MandateInformation.new(
          'My Mandate',
          '2014-02-17',
          'OOFF'
        )
      end

      let(:direct_debit) do
        mocked_entity = stub(:to_properties => {})
        Sepa::DirectDebitOrder::DirectDebit.new(
          mocked_entity,
          mocked_entity,
          "1234",
          4.95,
          'EUR',
          mandate_info
        )
      end

      subject { direct_debit }

      describe '#to_properties' do
        it 'should include SeqTp for PAIN.008.001.04' do
          result_hash = subject.to_properties(:debit, :pain_008_001_version => '04')
          result_hash.keys.should include('debit.payment_type_information.sequence_type')
          result_hash['debit.payment_type_information.sequence_type'].should match('OOFF')
          
        end
      end # #to_properties
    end # Sepa::DirectDebitOrder::DirectDebit
  end # Sepa::DirectDebitOrder
end
