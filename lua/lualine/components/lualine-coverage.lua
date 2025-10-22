local lualine_require = require("lualine_require")
local M = lualine_require.require("lualine.component"):extend()
local highlight = require("lualine.highlight")

local default_options = {
  hl = {
		bad = "#FF0000",
		ok  = "#00FFFF",
		good  = "#00FF00",
	},
  icon = " ",
	percent_icon = " ",
	scope = "file", -- Either "file" or "total"
}

local function get_total_coverage()
	local is_ok, report = pcall(require, "coverage.report")

	if not is_ok then
		return ""
	end

  local json_data = report.get()

	if not json_data or not json_data.files then
		return ""
	end

	if not json_data.totals then
		return ""
	end

	return math.ceil(json_data.totals.percent_covered)
end

local function get_file_coverage(filename)
	local is_ok, report = pcall(require, "coverage.report")

	if not is_ok then
		return ""
	end

  local json_data = report.get()

	if not json_data or not json_data.files then
		return ""
	end

	if not json_data.files[filename] then
		return ""
	end

	return math.ceil(json_data.files[filename].summary.percent_covered)
end

function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)
	self.highlights = { "bad", "ok", "good"}

	self.highlights.bad = highlight.create_component_highlight_group(
        { fg = self.options.hl.bad },
        'coverage_bad', self.options)

	self.highlights.ok = highlight.create_component_highlight_group(
        { fg = self.options.hl.ok },
        'coverage_ok', self.options)

	self.highlights.good = highlight.create_component_highlight_group(
        { fg = self.options.hl.good },
        'coverage_good', self.options)

	local is_ok, config = pcall(require, "coverage.config")

	if is_ok then
		self.min_coverage = config.opts.summary.min_coverage
	else
		self.min_coverage = 80
	end
end

function M:update_status()
  local coverage = ""

	if self.options.scope == "total" then
		coverage = get_total_coverage()
	else
		local current_filename = vim.fn.expand("%:. ")
		coverage = get_file_coverage(current_filename)
	end

	if coverage == "" then
		return ""
	end

	if coverage == 100 then
	  return highlight.component_format_highlight(self.highlights.good) ..
			coverage .. self.options.percent_icon
	end

	if coverage > self.min_coverage then
	  return highlight.component_format_highlight(self.highlights.ok) ..
			coverage .. self.options.percent_icon
	end

	return highlight.component_format_highlight(self.highlights.bad) ..
		coverage .. self.options.percent_icon
end

return M
