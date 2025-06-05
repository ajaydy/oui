
local uci  = require 'uci'.cursor()
local json = require 'jsonc'

local M = {}

local function export_config()
  local cfg = {config={}, nodes={}}
  uci:foreach("homeproxy", "config", function(s) cfg.config[#cfg.config+1] = s end)
  uci:foreach("homeproxy", "node",   function(s) cfg.nodes[#cfg.nodes+1]   = s end)
  return cfg
end

function M.get()
  return { cfg = export_config() }
end

function M.set(params)
  if params.config then
    for k,v in pairs(params.config) do
      uci:set("homeproxy", "config", k, v)
    end
  end

  uci:delete_all("homeproxy", "node")
  if params.nodes then
    for _, n in ipairs(params.nodes) do
      local s = uci:add("homeproxy", "node")
      for k,v in pairs(n) do
        if k ~= ".name" then
          uci:set("homeproxy", s, k, v)
        end
      end
    end
  end

  uci:commit("homeproxy")

  if params.apply then
    os.execute("/etc/init.d/homeproxy reload &")
  end
  return { ok = true }
end

return M
