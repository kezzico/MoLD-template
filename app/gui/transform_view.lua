function TransformView(transformer, children)
  local self = { }

  self.draw = function(self, w, h)
    love.graphics.push("all")
    transformer(w, h)

    if children and children.draw then
      children:draw(w, h)
    else
      for _, child in ipairs(children) do
        child:draw(w, h)
      end
    end

    love.graphics.pop()
  end

  return self
end

