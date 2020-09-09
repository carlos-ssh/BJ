# frozen_string_literal: true

class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def the_value
    return 10 if %w[J Q K].include?(value)
    return 11 if @value == 'A'

    @value
  end

  def to_s
    "#{@value} - #{@suit}"
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    build_cards
  end

  def take!
    @cards.shift
  end

  private

  def build_cards
    %i[clubs diamonds spades hearts].each do |suit|
      (2..10).each do |number|
        @cards << Card.new(suit, number)
      end
      %w[J Q K A].each do |face|
        @cards << Card.new(suit, face)
      end
    end
    @cards.shuffle!
  end
end

class Hand
  attr_reader :cards

  def initialize(deck)
    @deck = deck
    @cards = []
  end

  def hit!
    @cards << @deck.take!
  end

  def value
    val = 0
    @cards.each do |card|
      val += card.value
    end
    val
  end

  def to_s
    str = ''
    @cards.each do |card|
      str += "#{card}       "
    end
    str.strip
  end
end

#  1.- Repartir las cartas
#
#  2.- Preguntar al usuario si desea carta o se planta
#         Si pide carta:
#             Si se pasa, ir al punto 4
#             De lo contrario volver al punto 2
#         Si se planta:
#             Ir al punto 3
#
#  3.- Determinar el valor que tiene el repartidor
#         Si ese valor < 17, entregarse otra carta
#             Si se pasa ir al punto 4
#             De lo contrario, volver al punto 3.
#         De lo contrario:
#             Ir al punto 4 .
#
#  4.- Determina el ganador
#         Si el usuario se paso, gana el repartidor.
#         Si el repartidor se paso, gana el usuario.
#         Si el repartidor tiene mas que el usuario, gana el repartidor.
#         De lo contrario gana el usuario.
#
#  5.- Volver al punto uno (Nuevo juego.)
#

deck = Deck.new
dealer = Hand.new(deck)
player = Hand.new(deck)

player.hit!
player.hit!
dealer.hit!

puts "Dealer: #{dealer}"
puts "Player: #{player}"

puts 'Your Turn: '

while player.value < 21
  print '  Card or Push ...press C or P   '
  option = gets.chomp
  if option == 'c'
    player.hit!
    puts "  #{player}"
  elsif option == 'p'
    break
  end
end

puts
puts 'Dealer Turn!'

if player.value <= 21
  dealer.hit!
  puts "  #{dealer}"

  while dealer.value < 17
    dealer.hit!
    puts "  #{dealer}"
  end
end

if player.value > 21
  puts 'You Loose! :('
elsif dealer.value > 21
  puts 'You Win!'
elsif dealer.value == player.value
  puts "It's a Draw"
elsif dealer.value > player.value
  puts 'You Loose! :('
else
  puts 'Winner Winner Chicken Dinner! :D'
end
