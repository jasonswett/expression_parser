class Expression
  def self.parse(value)
    new(value)
  end

  def initialize(value)
    if value.length == 1
      @root = value.to_i
    else
      parts = value.split("*")
      @left_child = parts.first.to_i
      @root = "*"
    end
  end

  def root
    @root
  end

  def left_child
    @left_child
  end

  def right_child
  end
end
