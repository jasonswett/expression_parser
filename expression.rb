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
        @root = operator
        @left_child, @right_child = split_on(operator)
        return
      end
    end

    if constant?(value)
      @root = value.to_i
      @left_child, @right_child = nil, nil
      return
    end

    @root = "*"
    @left_child, @right_child = split_on("")
  end

  def constant?(value)
    value.to_i.to_s == value
  end

  def split_on(character)
    parts = @value.split(character)
    [make_numeric(parts.first), make_numeric(parts.last)]
  end

  def make_numeric(value)
    constant?(value) ? value.to_i : value
  end
end
