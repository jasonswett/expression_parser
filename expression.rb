require_relative "./token"

class Expression
  attr_reader :root, :left_child, :right_child
  OPERATORS = %w(+ / *)

  def self.parse(value)
    new(value)
  end

  def initialize(value)
    @value = value.strip

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

    if @value.length == 1
      @root = Token.new(@value).clean!
      return
    end

    @root = Token.new("*")
    @left_child, @right_child = split_on("")
  end

  def split_on(operator)
    @value.split(operator).map do |child_expression_value|
      Expression.new(child_expression_value)
    end
  end

  def value
    @root.value
  end
end
