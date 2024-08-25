class Expression
  attr_reader :root, :left_child, :right_child

  def self.parse(value)
    new(value)
  end

  def initialize(value)
    @value = value

    if value.include?("/")
      @root = "/"
      @left_child, @right_child = split_on("/")
      return
    end

    if value.include?("*")
      @root = "*"
      @left_child, @right_child = split_on("*")
    end

    if value.to_i.to_s == value
      @root = value.to_i
      @left_child, @right_child = nil, nil
      return
    end

    @left_child, @right_child = split_on("")
    @root = "*"
  end

  def split_on(character)
    parts = @value.split(character)
    [make_numeric(parts.first), make_numeric(parts.last)]
  end

  def make_numeric(value)
    if value.to_i.to_s == value
      value.to_i
    else
      value
    end
  end
end
