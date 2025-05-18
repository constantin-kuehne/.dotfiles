return {
    settings = {
        python = {
            pythonPath = "python",
        },
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
                autoSearchPaths = true,
                autoImportCompletions = true,
                inlayHints = {
                    variableTypes = true,
                    callArgumentNames = true,
                    functionReturnTypes = true,
                    genericTypes = true,
                },
                diagnosticSeverityOverrides = {
                    reportUnusedExpression = "none",
                },
            },
        },
    }
}
