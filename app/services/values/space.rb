class Space
  attr_reader :coordinates, :status, :contents

  def initialize(coordinates)
    @coordinates = coordinates
    @contents    = nil
    @status      = "Not Attacked"
  end

  def attack!
    if contents && not_attacked?
      contents.attack!
      output = "Hit"
      if contents.is_sunk?
        output += ". Battleship sunk."
      end
    else
      output = "Miss"
    end
    @status = output
  end

  def occupy!(ship)
    @contents = ship
  end

  def occupied?
    !!@contents
  end

  def not_attacked?
    status == "Not Attacked"
  end
end
