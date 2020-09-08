=begin
 1.- Repartir las cartas

 2.- Preguntar al usuario si desea carta o se planta
        Si pide carta:
            Si se pasa, ir al punto 4
            De lo contrario volver al punto 2        
        Si se planta:
            Ir al punto 3

 3.- Determinar el valor que tiene el repartidor
        Si ese valor < 17, entregarse otra carta
            Si se pasa ir al punto 4
            De lo contrario, volver al punto 3.
        De lo contrario:
            Ir al punto 4 .

 4.- Determina el ganador
        Sí el usuario se pasó, gana el repartidor.
        Sí el repartidor se pasó, gana el usuario.
        Sí el repartidor tiene mas que el usuario, gana el repartidor.
        De lo contrario gana el usuario.

 5.- Volver al punto uno (Nuevo juego.)   

=end

#Como representamos una carta (Figura y valor)
#Como representamos una baraja compuesta de 52 cartas
#Como representamos las cartas que tiene el jugador y el repartidor

class Card
    attr_reader :suit, :value

    def initialize(suit, value)
        @suit = suit
        @value = value
    end

    def value
        return 10 if ["J", "Q", "K"].include?(value)
        return 11 if @value == "A"
        return @value
    end

end

class Deck
    attr_writer :cards

    def initialize
        @cards = []
        build_cards
    end

    private
    def build_cards
        [:clubs, :diamonds, :spades, :hearts].each do |suit|
            (2..10).each do |number|
                @cards << Card.new(suit, number)
            end
            ["J", "Q", "K", "A"].each do |face|
                @cards << Card.new(suit, face)
            end
        end
        @cards.shuffle!
    end
end
