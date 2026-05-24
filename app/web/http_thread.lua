local https = require("https")

local request_channel = love.thread.getChannel("request")
local response_channel = love.thread.getChannel("response")

local rq = request_channel:demand()

while rq ~= "quit" do
    local url = rq.url
    local rq_headers = rq.headers or {}
    local rq_method = rq.method or "GET"
    local rq_body = rq.body or nil
    local rq_id = rq.id
    
    local code, body, headers = https.request(url, {
        method = rq_method,
        headers = rq_headers,
        data = rq_body,
    })

    -- print("HTTP request to: " .. url)
    -- print("HTTP request method: " .. rq_method)
    -- print("HTTP request body: " .. tostring(rq_body))
    
    -- print("HTTP response code: " .. tostring(code))
    -- print("HTTP response body: " .. tostring(body))
    response_channel:push({
        id = rq_id,
        code = code,
        response = body,
        url = url,
    })

    rq = request_channel:demand()
end

print("HTTP thread exiting")