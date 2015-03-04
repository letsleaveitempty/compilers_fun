class Assembler

  def initialize
    @instructions = []
    @register = 0
  end

  def instructions
    @instructions
  end

  def add_instructions(text)
    @instructions << text
    text
  end

  def next_register
    @register += 1
  end
end
