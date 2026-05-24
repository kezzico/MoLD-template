local generateMaze = require 'app.game_logic.maze_generator'

local function GameView(game_state) 
  local self = { }
  local next_move = 0
  self.state = game_state or {
    maze = generateMaze(24, 24),
    pause = true
  }

  self.update = function(self, dt)
    if self.state.pause then return end
    
    if next_move > 0 then
      next_move = next_move - dt
    else
      next_move = 0.5

      -- find the rat
      local rat_x, rat_y
      for i = 1, #self.state.maze do
        for j = 1, #self.state.maze[i] do
          if self.state.maze[i][j] == 3 then
            rat_x, rat_y = j, i
          end
        end
      end

      -- move the rat randomly
      local dirs = {
        { 0, -1 },
        { 1,  0 },
        { 0,  1 },
        { -1, 0 }
      }

      local d = dirs[math.random(1, #dirs)]
      local new_x = rat_x + d[1]
      local new_y = rat_y + d[2]

      if self.state.maze[new_y] and self.state.maze[new_y][new_x] and self.state.maze[new_y][new_x] ~= 0 then
        -- move the rat
        self.state.maze[rat_y][rat_x] = 1
        self.state.maze[new_y][new_x] = 3
      end
    end
    -- only called if subscribing to updateables on draw
  end

  self.draw = function(self, w, h)
    local cell_width = w / #self.state.maze[1]
    local cell_height = h / #self.state.maze

    for i = 1, #self.state.maze do
      for j = 1, #self.state.maze[i] do
        -- 0 == wall
        -- 1 == floor
        -- 2 == cheese
        -- 3 == rat

        if self.state.maze[i][j] == 0 then
          love.graphics.setColor(0.5, 0.5, 0.5)
        end

        if self.state.maze[i][j] == 1 then
          love.graphics.setColor(0, 0, 0)
        end

        if self.state.maze[i][j] == 2 then
          love.graphics.setColor(1, 1, 0)
        end

        if self.state.maze[i][j] == 3 then
          love.graphics.setColor(hexToColor(0xAA0000))
        end

        love.graphics.rectangle("fill", (j - 1) * cell_width, (i - 1) * cell_height, cell_width, cell_height)
      end

      table.insert(updateables, self)
    end
  end

  return self
end

return GameView