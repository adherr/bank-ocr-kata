# frozen_string_literal: true

module BankOcr
  class AccountNumber
    require 'matrix'

    ZERO = <<-ZERO
 _ 
| |
|_|
ZERO
    ONE = <<-ONE
   
  |
  |
ONE
    TWO = <<-TWO
 _ 
 _|
|_ 
TWO
    THREE = <<-THREE
 _ 
 _|
 _|
THREE
    FOUR = <<-FOUR
   
|_|
  |
FOUR
    FIVE = <<-FIVE
 _ 
|_ 
 _|
FIVE
    SIX = <<-SIX
 _ 
|_ 
|_|
SIX
    SEVEN = <<-SEVEN
 _ 
  |
  |
SEVEN
    EIGHT = <<-EIGHT
 _ 
|_|
|_|
EIGHT
    NINE = <<-NINE
 _ 
|_|
 _|
NINE

    DIGITS = [ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE].freeze

    STATUS_MAPPING = {
      parse_error: ' ILL',
      invalid_checksum: ' ERR',
      valid: ''
    }

    private_constant :ZERO, :ONE, :TWO, :THREE, :FOUR, :FIVE, :SIX, :SEVEN, :EIGHT, :NINE, :DIGITS, :STATUS_MAPPING

    # Create a new AccountNumber object, parsing the given lines on the way in
    #
    # @param lines [Array] from the scanned file, first 3 elements
    # must include numbers, further elements are ignored
    # @return [AccountNumber]
    def initialize(lines)
      @parsed_array = parse_to_array(lines)
      @valid = verify_checksum
    end

    # String representation of the account number
    def to_s
      parsed_array.map { |digit| digit.nil? ? '?' : digit }
                  .map(&:to_s)
                  .join('')
    end

    # String representation with status appended
    def to_file
      to_s + STATUS_MAPPING[valid]
    end

    private

    attr_reader :parsed_array, :valid

    # @private
    # Parses 4 lines from the scanned file into an account number string
    #
    # @param lines [Array] from the scanned file, first 3 elements
    # must include numbers, further elements are ignored
    # @return [Array] containing the digits of the account number parsed
    def parse_to_array(lines)
      chunked = lines[0..2].map do |l|
        l.scan(/.{1,3}/)
      end
      (0..8).map do |d|
        assembled = "#{chunked[0][d]}\n#{chunked[1][d]}\n#{chunked[2][d]}\n"
        DIGITS.find_index(assembled)
      end
    end

    def verify_checksum
      return :parse_error if parsed_array.any?(&:nil?)

      valid_checksum = Vector.elements(parsed_array.reverse)
                             .inner_product((1..9).to_a)
                             .modulo(11)
                             .zero?

      valid_checksum ? :valid : :invalid_checksum
    end
  end
end
