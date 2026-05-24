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

function ShelfView(style, children)
  local self = { }
  style = style or { widths = { }, gap = 0 }
  children = children or style or {}

  self.draw = function(self, w, h)
    local gap = style.gap or 0
    local widths = style.widths or { }

    local total_gaps = gap * (#children - 1)
    local width_minus_gaps = w - total_gaps
    local width_budget = width_minus_gaps - reduce(widths, function(s, r, i) 
      return s + (eval_units(r, width_minus_gaps) or 0)
    end)

    local count_needy_children = reduce(children, function(s, r, index) 
      return s + ternary(widths[index] == nil, 1, 0) 
    end)

    love.graphics.push()
    for i=1,#children do
      local cell_width = eval_units(widths[i], width_minus_gaps) or (width_budget / count_needy_children)
      -- print(cell_width, widths[i], ternary(widths[i] ~= nil, "not nil", "is nil"))
      local child = children[i]
        -- local s = spread[i] or 1
      child:draw(cell_width, h)
      love.graphics.translate(cell_width, 0)
      love.graphics.translate(gap, 0)
    end
    love.graphics.pop()
  end

  return self
end

return ShelfView