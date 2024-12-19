local M = {}

function M.setup(pkg)
	return function()
		require(pkg).setup()
	end
end

return M
