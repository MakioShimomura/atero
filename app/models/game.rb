class Game < ApplicationRecord
  default_scope -> {order(correct_quantities: :desc)}
  
  #def required_time
  #  @required_time = @game.end_at-@game.created_at
  #end
end
