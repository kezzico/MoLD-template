function Navigator(rootView)
  local stack = {}
    
  return {
    reset = function(self)
      local current = stack[#stack]

      if current ~= nil and current.suspend then
        current:suspend()
      end

      while #stack > 1 do
        table.remove(stack)
      end

      local new_top = stack[1]
      if new_top ~= nil and new_top.activate then
        new_top:activate()
      end

      -- controllers[1].delegate = new_top
      -- controllers[2].delegate = new_top
    end,

    push = function(self, destination)
      local current = stack[#stack]

      if current ~= nil and current.suspend then
        current:suspend()
      end

      table.insert(stack, destination)

      if destination.activate then
        destination:activate()
      end

      -- for i = 1, #controllers do
        -- controllers[i].delegate = destination
      -- end
    end,
    
    pop = function(self)
      local current = stack[#stack] 

      if current ~= nil and current.suspend then
        current:suspend()
      end

      table.remove(stack)

      local new_top = stack[#stack]
      if new_top ~= nil and new_top.activate then
        new_top:activate()
      end

      -- controllers[1].delegate = new_top
      -- controllers[2].delegate = new_top
    end,
    
    draw = function(self, w, h)
      if #stack > 0 then
        stack[#stack]:draw(w, h)
      end
      -- for i=1,#stack do
      --   stack[i]:draw(w, h)
      -- end
    end
  }
end

return Navigator