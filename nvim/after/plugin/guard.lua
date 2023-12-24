local ft = require('guard.filetype')
--
-- -- Assuming you have guard-collection
-- -- ft('lang'):fmt('format-tool-1')
-- --           :append('format-tool-2')
-- --           :env(env_table)
-- --           :lint('lint-tool-1')
-- --           :extra(extra_args)
--

ft('go'):fmt('gofmt')
        :fmt('golines')

ft('rust'):fmt('rustfmt')

require('guard').setup({
    -- the only options for the setup function
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = false,
})
