class Expression
  def self.parse(value)
    new(value)
  end

  def initialize(value)
    if value.length == 1
      @root = value.to_i
    else
      @root = "*"
    end
  end

  def root
    @root
  end

  def left_child
  end

  def right_child
  end
end
