local function eval_units(value_plus_unit, relative_to)
  local r = value_plus_unit

  if type(r) == "string" and r:sub(-1) == "%" then
    r = tonumber(r:sub(1, -2)) * relative_to / 100
  elseif type(r) == "string" and r:sub(-2) == "px" then
    r = tonumber(r:sub(1, -3))
  elseif type(r) == "string" then
    r = tonumber(r)
  end

  return r
end

local function StackView(style, children)
  local self = { }
  style = style or { heights = { }, gap = 0 }
  children = children or style or {}

  self.draw = function(self, w, h)
    local gap = style.gap or 0
    local heights = style.heights or { }

    local total_gaps = gap * (#children - 1)

    local height_minus_gaps = h - total_gaps

    local height_budget = height_minus_gaps - reduce(heights, function(s, r, i) 
      return s + (eval_units(r, height_minus_gaps) or 0)
    end)

    local count_needy_children = reduce(children, function(s, r, index) 
      return s + ternary(heights[index] == nil, 1, 0) 
    end)
      
    love.graphics.push()
    for i=1,#children do
      local cell_height = eval_units(heights[i], height_minus_gaps) or (height_budget / count_needy_children)
      local child = children[i]

      child:draw(w, cell_height)
      love.graphics.translate(0, cell_height)
      love.graphics.translate(0, gap)
    end
    love.graphics.pop()
  end

  return self
end

return StackView