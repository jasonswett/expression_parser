class ParentheticalExpression
  def initialize(value)
    @value = value
  end

  def parse
    regex = /([a-zA-Z\d]+)\(([^)]+)\)/
    match_data = @value.match(regex)
    value_before_parentheses = Expression.new(match_data[1]).parse
    value_inside_parentheses = Expression.new(match_data[2]).parse

    ExpressionTree.new(
      root: "*",
      left_child: value_before_parentheses,
      right_child: value_inside_parentheses
    )
  end
end
