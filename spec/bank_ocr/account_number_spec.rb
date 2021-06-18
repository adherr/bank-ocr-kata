# frozen_string_literal: true

RSpec.describe BankOcr::AccountNumber do
  let(:use_case_1) { File.readlines('spec/fixtures/use_case_1.txt') }
  let(:use_case_3) { File.readlines('spec/fixtures/use_case_3.txt') }

  describe '#to_s' do
    it 'works correctly formatted lines' do
      zeros = use_case_1[0..3]

      expect(BankOcr::AccountNumber.new(zeros).to_s).to eq('000000000')
    end

    it "inserts '?' for chars that fail to parse" do
      unparseable = use_case_3[4..7]

      expect(BankOcr::AccountNumber.new(unparseable).to_s).to eq('49006771?')
    end
  end

  describe '#to_file' do
    it 'appends ILL to unparseable numbers' do
      unparseable = use_case_3[4..7]

      expect(BankOcr::AccountNumber.new(unparseable).to_file).to eq('49006771? ILL')
    end

    it 'appends ERR to numbers with invalid checksum' do
      invalid = use_case_3[8..11]

      expect(BankOcr::AccountNumber.new(invalid).to_file).to eq('123456788 ERR')
    end
  end
end
