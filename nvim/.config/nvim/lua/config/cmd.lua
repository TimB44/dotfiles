vim.api.nvim_create_user_command("BloopSync", function(evt)
  -- asynchronously run `bazel run //:bloop-sync -- %`
  local filename = evt.args
  if filename and filename ~= "" then
    filename = vim.fn.expand(filename)
  else
    filename = vim.api.nvim_buf_get_name(0)
  end
  -- TODO: get this to work for workspaces
  local workspace = vim.fn.expand("~/lucid/main")

  -- ? filename = vim.fn.fnamemodify(filename, ':p:s?' .. workspace .. '??')
  -- This asumes you have the plenary plugin installed
  filename = require("plenary.path").new(filename):make_relative(workspace)

  vim.system(
    { "bazel", "run", "//:bloop-sync", "--", filename },
    {
      cwd = workspace,
      detach = true,
      stdout = false,
    },
    vim.schedule_wrap(function(resp)
      vim.notify("finished", vim.log.levels.INFO)
      if resp.code ~= 0 then
        vim.notify("Bloop sync failed: " .. resp.stderr, vim.log.levels.ERROR)
      else
        vim.cmd("MetalsRestartBuildServer")
        vim.notify("Bloop sync succeeded", vim.log.levels.INFO)
      end
    end)
  )
end, {
  desc = "Sync bloop for the current file",
  force = true,
  complete = "file",
  nargs = "?",
})
