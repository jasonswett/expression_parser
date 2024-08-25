require_relative "./token"

class Expression
  attr_reader :root, :left_child, :right_child
  OPERATORS = %w(+ / *)

  def self.parse(value)
    new(value)
  end

  def initialize(value)
    @value = value

    OPERATORS.each do |operator|
      if value.include?(operator)
        @root = Token.new(operator)
        @left_child, @right_child = split_on(operator)
        return
      end
    end

    if Token.new(value).constant?
      @root = Token.new(value).clean!
      @left_child, @right_child = Token.new(nil), Token.new(nil)
      return
    end

    @root = Token.new("*")
    @left_child, @right_child = split_on("")
  end

  def split_on(character)
    parts = @value.split(character)
    children = [parts.first, parts.last]
    children.map { |c| Token.new(c).clean! }
  end
end
