return {
    settings = {
        ltex = {
            language = "en-GB",
        },
    },
    autostart = false,
    on_attach = function(client, bufnr)
        local function on_attach(client, bufnr)
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
        end

        on_attach(client, bufnr)

        require("ltex_extra").setup({
            load_langs = { "en-GB", "de-DE" },
            init_check = true,
            path = vim.fn.expand("~") .. "/.local/share/ltex",
        })
    end,
}
