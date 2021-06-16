# frozen_string_literal: true

RSpec.describe BankOcr::AccountNumber do
  let(:input) { File.readlines('spec/fixtures/use_case_1.txt') }
  describe '#to_s' do
    it 'works correctly formatted lines' do
      zeros = input[0..3]

      expect(BankOcr::AccountNumber.new(zeros).to_s).to eq('000000000')
    end
  end
end
