# frozen_string_literal: true

RSpec.describe BankOcr::ScannedFile do
  let(:filename) { 'spec/fixtures/use_case_1.txt' }
  describe '#account_numbers' do
    it 'returns parsed account numbers' do
      fr = BankOcr::ScannedFile.new(filename)
      expect(fr.account_numbers).to be_instance_of(Array)
      expect(fr.account_numbers.size).to eq(11)
    end
  end
end
