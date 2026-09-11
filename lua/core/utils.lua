-- ~/.config/nvim/lua/core/utils.lua

local M = {}

local has_android = vim.env.TERMUX_VERSION ~= nil

-- Define boolean flags on the M table
M.is_android = has_android
M.is_linux = vim.fn.has 'linux' == 1 and not has_android
M.is_windows = vim.fn.has 'win32' == 1

-- Lookup table used by on_platform() below
local platform_flags = {
  android = M.is_android,
  linux = M.is_linux,
  mac = M.is_mac,
  windows = M.is_windows,
}

---Conditional runner utility
---@param platform 'android' | 'linux' | 'mac' | 'windows'
---@param callback function Code block to run if platform matches
function M.on_platform(platform, callback)
  local matches = platform_flags[platform]
  if matches == nil then error(("on_platform: unknown platform '%s'"):format(platform), 2) end
  if matches then callback() end
end

return M
--  vim: set ts=2 sts=2 sw=2 et :
