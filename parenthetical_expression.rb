class ParentheticalExpression
  #REGEX = /([a-zA-Z\d]+)\(([^)]+)\)/
  REGEX = /(.*?)\((.+)\)(.*)/

  def initialize(value)
    @value = value
  end

  def parse
    ExpressionTree.new(
      root: "*",
      left_child: Expression.new(value_before_parentheses).parse,
      right_child: Expression.new(value_inside_parentheses).parse
    )
  end

  def self.contains_parentheses?(value)
    value.include?("(")
  end

  def value_inside_parentheses
    match_data[2]
  end

  private

  def value_before_parentheses
    match_data[1]
  end

  def match_data
    @value.match(REGEX)
  end
end
