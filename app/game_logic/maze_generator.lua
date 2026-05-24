local function placeStartAndCheese(maze, width, height)
    local function randomFloor()
        while true do
            local x = math.random(2, width - 1)
            local y = math.random(2, height - 1)

            if maze[y][x] == 1 then
                return x, y
            end
        end
    end

    local sx, sy = randomFloor()
    local cx, cy = randomFloor()

    maze[sy][sx] = 3 -- start
    maze[cy][cx] = 2 -- cheese

    return sx, sy, cx, cy
end

local function generateMaze(width, height)
    local maze = {}

    -- fill with walls
    for y = 1, height do
        maze[y] = {}
        for x = 1, width do
            maze[y][x] = 0
        end
    end

    local dirs = {
        { 0, -1 },
        { 1,  0 },
        { 0,  1 },
        { -1, 0 }
    }

    local stack = {}

    -- start seed (temporary, will become real START later)
    local sx = 2
    local sy = 2

    maze[sy][sx] = 1
    table.insert(stack, { sx, sy })

    while #stack > 0 do
        local current = stack[#stack]
        local x, y = current[1], current[2]

        local neighbors = {}

        for _, d in ipairs(dirs) do
            local nx = x + d[1] * 2
            local ny = y + d[2] * 2

            if nx > 1 and nx < width and ny > 1 and ny < height then
                if maze[ny][nx] == 0 then
                    table.insert(neighbors, { nx, ny, d })
                end
            end
        end

        if #neighbors > 0 then
            local pick = neighbors[math.random(#neighbors)]

            local nx, ny, d = pick[1], pick[2], pick[3]

            -- carve wall between
            local wx = x + d[1]
            local wy = y + d[2]
            maze[wy][wx] = 1

            -- carve next cell
            maze[ny][nx] = 1

            table.insert(stack, { nx, ny })
        else
            table.remove(stack)
        end
    end

    placeStartAndCheese(maze, width, height)
    
    return maze
end
-- function generateMaze(width, height)
--     local maze = {}

--     -- true = wall
--     -- false = floor

--     for y = 1, height do
--         maze[y] = {}
--         for x = 1, width do
--             maze[y][x] = true
--         end
--     end

--     local dirs = {
--         { 0, -2 },
--         { 2,  0 },
--         { 0,  2 },
--         { -2, 0 }
--     }

--     local stack = {}

--     local startX = 2
--     local startY = 2

--     maze[startY][startX] = false
--     table.insert(stack, { startX, startY })

--     while #stack > 0 do
--         local current = stack[#stack]

--         local x = current[1]
--         local y = current[2]

--         local neighbors = {}

--         for _, d in ipairs(dirs) do
--             local nx = x + d[1]
--             local ny = y + d[2]

--             if nx > 1 and nx < width
--             and ny > 1 and ny < height
--             and maze[ny][nx] == true then
--                 table.insert(neighbors, { nx, ny, d })
--             end
--         end

--         if #neighbors > 0 then
--             local next = neighbors[math.random(#neighbors)]

--             local nx = next[1]
--             local ny = next[2]
--             local d  = next[3]

--             -- carve wall between
--             maze[y + math.floor(d[2] / 2)][x + math.floor(d[1] / 2)] = false

--             -- carve destination
--             maze[ny][nx] = false

--             table.insert(stack, { nx, ny })
--         else
--             table.remove(stack)
--         end
--     end

--     return maze
-- end

return generateMaze