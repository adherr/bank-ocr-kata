# frozen_string_literal: true

require 'tempfile'

RSpec.describe BankOcr::ScannedFile do
  let(:use_case_1) { 'spec/fixtures/use_case_1.txt' }
  let(:use_case_3) { 'spec/fixtures/use_case_3.txt' }

  describe '#report' do
    it 'writes the correct file' do
      sf = BankOcr::ScannedFile.new(use_case_3)
      report_filename = Tempfile.new('bank_ocr_test').path
      sf.report(report_filename)

      expect(File.readlines(report_filename, chomp: true)).to eq(expected_use_case_3)
    end
  end
end

def expected_use_case_1
  [
    '000000000',
    '111111111',
    '222222222',
    '333333333',
    '444444444',
    '555555555',
    '666666666',
    '777777777',
    '888888888',
    '999999999',
    '123456789'
  ]
end

def expected_use_case_3
  [
    '000000051',
    '49006771? ILL',
    '123456788 ERR'
  ]
end
