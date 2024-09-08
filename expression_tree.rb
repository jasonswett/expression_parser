class ExpressionTree
  attr_reader :root, :left_child, :right_child

  def initialize(root:, left_child: nil, right_child: nil)
    @root = root
    @left_child = left_child
    @right_child = right_child
  end

  def value
    @root
  end
end
