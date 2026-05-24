function TextView(text, style)
    style = style or { }
    return {
      state = {
        text = text,
        color = style.color or hexToColor(0xFFFFFF),
        font = style.font or cache.font({"assets/fonts/joystix.ttf", 120}),
        size = style.size or 30.0,
      },

      draw = function(self, w, h)
        local font_scale = (self.state.size or 30.0) / 60.0
        
        local maxWidth, wrappedtext = self.state.font:getWrap( self.state.text, w / font_scale )
        local textWidth = maxWidth
        local textHeight = self.state.font:getHeight(self.state.text) * #wrappedtext

        local align = style.align or "center" -- top, center, bottom
        local justify = style.justify or "center" -- left, center, right

        love.graphics.push("all")

        if DEBUG then
          love.graphics.setColor(0, 1, 0, 0.5)
          love.graphics.rectangle("fill", 0, 0, w, h)
        end

        -- using a large font and scaling it down to get better visual quality
        love.graphics.scale(font_scale, font_scale)
        love.graphics.setColor(self.state.color)
        love.graphics.setFont(self.state.font)

        if align == "center" then
          love.graphics.translate(0, -textHeight * 0.5 + h / font_scale * 0.5)
        elseif align == "bottom" then
          love.graphics.translate(0, h / font_scale - textHeight)
        end
        
        love.graphics.printf(self.state.text, 0, 0, w / font_scale, justify)

        love.graphics.pop()
      end,
    }
end

return TextView