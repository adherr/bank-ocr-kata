module BankOcr
  class AccountNumber
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

    DIGITS = [ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE]
    # expects an array of strings, each element is a line
    def self.parse(lines)
      chunked = lines[0..2].map do |l|
        l.scan(/.{1,3}/)
      end
      string_digits = (0..8).map do |d|
        assembled = "#{chunked[0][d]}\n#{chunked[1][d]}\n#{chunked[2][d]}\n"
        DIGITS.find_index(assembled).to_s
      end
      string_digits.join("")
    end
  end
end