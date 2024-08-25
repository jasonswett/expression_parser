class Expression
  attr_reader :root, :left_child, :right_child

  def self.parse(value)
    new(value)
  end

  def initialize(value)
    if value.include?("/")
      @root = "/"
      parts = value.split("/")
      @left_child = parts.first
      @right_child = parts.last.to_i
      return
    end

    if value.include?("x")
      parts = value.split("")
      @left_child = parts.first.to_i
      @right_child = parts.last
      @root = "*"
    else
      @root = value.to_i
    end
  end
end
