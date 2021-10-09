class Team
  attr_accessor :name, :win, :lose, :draw
  
  def initialize(name, win, lose, draw)
    @name = name
    @win = win
    @lose = lose
    @draw = draw
  end
end

team1 = Team.new('Llanerchymedd', 3, 2, 0)
team2 = Team.new('FC International', 4, 1, 1)
team3 = Team.new('FC Gunners', 5, 5, 3)
team4 = Team.new('Bangkok United', 10, 4, 2)
team5 = Team.new('FC.J-Bulls', 7, 1, 5)
team6 = Team.new('FC NIPPON', 0, 5, 1)

summarize_team_name = [team1, team2, team3, team4, team5, team6]

summarize_team_name.each.with_index(1) do |team, index|
  puts <<~EOS
  #{index}
  チーム名: #{team.name}
  勝ち数：#{team.win}
  負け数: #{team.lose}
  引き分け: #{team.draw}
  EOS
end
