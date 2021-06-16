# frozen_string_literal: true

RSpec.describe BankOcr::ScannedFile do
  let(:filename) { 'spec/fixtures/use_case_1.txt' }
  describe '.new' do
    it 'creates a ScannedFile object with parsed account numbers in it' do
      fr = BankOcr::ScannedFile.new(filename)
      expect(fr.account_numbers).to be_instance_of(Array)
      expect(fr.account_numbers.size).to eq(11)
    end
  end
end
