function ScrollView(items, viewForIndex) 
  viewForIndex = viewForIndex
  items = items or {}
  local scroll_offset = 0
  local children = { }
  local frame = { x = 0, y = 0, w = 0, h = 0 }
  local dragging = false

  local scroll_velocity = 0
  -- number of pixels to scroll before the page
  local scroll_height = 0

  return {
    id = "somestring",
    hit = function(self, x, y)
      return x >= frame.x and x <= frame.x + frame.w and y >= frame.y and y <= frame.y + frame.h
    end,

    onpress = function(self, p)
      dragging = true
    end,

    ondrag = function(self, dx, dy)
      scroll_velocity = dy 
    end,

    onrelease = function(self)
      dragging = false
    end,

    update = function(self, dt)
      local inertia = 0.1
      local min_velocity = 2
      -- local overscroll = scroll_height - scroll_offset
      
      if scroll_offset > scroll_height then
        scroll_offset = scroll_height
      elseif scroll_offset < 0 then
        scroll_velocity = scroll_velocity - (500  * dt)
      end

     -- print(scroll_velocity)
      if math.abs(scroll_velocity) > min_velocity then
        scroll_velocity = scroll_velocity * inertia ^ dt
      else
        scroll_velocity = 0
      end

      scroll_offset = scroll_offset - scroll_velocity
    end,

    reload = function(self, data)
      items = data or {}
      children = { }
    end,

    draw = function(self, w, h)
      local lx, ly = love.graphics.transformPoint(0, 0)
      frame = { x = lx, y = ly, w = w, h = h}

      local child_height = h * 0.45
      scroll_height = math.max(child_height * #items - h, 0) + 200

      local start_index = math.max(1, math.floor(scroll_offset / child_height) + 1)
      local end_index = math.min(math.ceil((scroll_offset + h) / child_height), #items)

      love.graphics.setScissor(0, 0, w, h)
      for i=start_index,end_index do
        local child_view = children[i] or viewForIndex(items[i], i)
        children[i] = child_view

        love.graphics.push()
        love.graphics.translate(0, (i - 1) * child_height - scroll_offset)
        child_view:draw(w, child_height)
        love.graphics.pop()
      end

      love.graphics.setScissor()

      table.insert(clickables, self)
      table.insert(draggables, self)
      table.insert(updateables, self)

      if dragging ~= true then
        scroll_offset = math.max(0, math.min(#children * child_height - h, scroll_offset))
      end
    end
  }

end

