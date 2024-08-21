class Expression
  attr_reader :root, :left_child, :right_child

  def self.parse(value)
    new(value)
  end

  def initialize(value)
    if value.length == 1
      @root = value.to_i
    else
      parts = value.split("*")
      @left_child = parts.first.to_i
      @right_child = parts.last
      @root = "*"
    end
  end
end
