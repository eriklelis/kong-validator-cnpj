local _M = {}
local cjson = require "cjson"

local function isTableEmpty(t)
    return t == nil or next(t) == nil
end

local function request_validator(conf)
    local result = {}
    local cnpj = kong.request.get_query_arg("cnpj") or kong.request.get_body_arg("cnpj")

    if not cnpj then
        table.insert(result, "CNPJ is required")
    elseif string.len(cnpj) ~= 14 or not tonumber(cnpj) then
        table.insert(result, "Invalid CNPJ format")
    end

    if not isTableEmpty(result) then
        return kong.response.exit(400, { message = result })
    end
end

function _M.execute(conf)
    request_validator(conf)
end

return _M
