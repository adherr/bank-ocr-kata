# frozen_string_literal: true

RSpec.describe BankOcr::AccountNumber do
  let(:input) { File.readlines('spec/fixtures/use_case_1.txt') }
  describe '.parse' do
    it 'parses correctly formatted number' do
      zeros = input[0..3]

      expect(BankOcr::AccountNumber.parse(zeros)).to eq('000000000')
    end
  end
end
