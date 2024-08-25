class Token
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def clean!
    @value = constant? ? @value.to_i : @value.strip
    self
  end

  def constant?
    @value.to_i.to_s == @value.strip
  end
end
