function View(style, children)
  style = style or {}
  children = children or style or {}
  local frame = { x = 0, y = 0, w = 0, h = 0 }

  return {
    draw = function(self, w, h)
      local padding = style.padding or { 0, 0 }
      local border_width = style.border and style.border.width or 0
      local total_padding_x = (type(padding) == "number" and padding or padding[2] or 0) + border_width
      local total_padding_y = (type(padding) == "number" and padding or padding[1] or 0) + border_width

      if style.backgroundColor then
        love.graphics.push("all")
        love.graphics.setColor(style.backgroundColor)
        love.graphics.rectangle("fill", 0, 0, w, h)
        love.graphics.pop()
      end
      
      if style.border then
        love.graphics.push("all")
        love.graphics.setColor(style.border.color)
        love.graphics.setLineWidth(style.border.width)
        love.graphics.rectangle("line", 0, 0, w, h)
        love.graphics.pop()
      end

      love.graphics.push()
      love.graphics.translate(total_padding_x, total_padding_y)

      -- for _, child in ipairs(children) do
      for i = 1, #children do
        local child = children[i]
        child:draw(w - total_padding_x * 2, h - total_padding_y * 2)
      end
      love.graphics.pop()

      return w, h
    end
  }
end

return View