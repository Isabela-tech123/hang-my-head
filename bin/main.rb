require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/word'

file_path = File.expand_path('../lib/saves/save.json', __dir__)

if File.exist?(file_path)
  json_content = File.read(file_path)
  game = Game.from_json(json_content)
else
  game = Game.new
end

game.game_loop