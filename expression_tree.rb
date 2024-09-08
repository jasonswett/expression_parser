require_relative "./token"

class ExpressionTree
  attr_reader :root, :left_child, :right_child
  OPERATORS = %w(+ / *)

  def self.parse(value)
    new(value)
  end

  def initialize(value)
    value.strip!

    if constant?(value)
      @root = Token.new(value.to_i)
      @left_child, @right_child = Token.new(nil), Token.new(nil)
      return
    end

    if value.length == 1
      @root = Token.new(value)
      return
    end

    OPERATORS.each do |operator|
      if value.include?(operator)
        @root = Token.new(operator)
        @left_child, @right_child = split_on(value, operator)
        return
      end
    end

    @root = Token.new("*")
    @left_child, @right_child = split_on(value, "")
  end

  def split_on(value, operator)
    value.split(operator).map do |child_expression_value|
      ExpressionTree.new(child_expression_value)
    end
  end

  def value
    @root.value
  end

  def constant?(value)
    value.to_i.to_s == value.strip
  end
end
