return {
    settings = {
        texlab = {
            bibtexFormatter = "texlab",
            build = {
                -- args = { "-pdflua", "-pvc", "-bibtex", "-auxdir=./AUX", "-interaction=nonstopmode", "-synctex=1", "%f" },
                args = {
                    "-pdflua",
                    "-pvc",
                    "-bibtex",
                    "-auxdir=./AUX",
                    "-interaction=nonstopmode",
                    "%f",
                },
                executable = "latexmk",
                auxDirectory = "./AUX",
                logDirectory = "./AUX",
                forwardSearchAfter = false,
                onSave = false,
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false,
            },
            diagnosticsDelay = 200,
            formatterLineLength = 80,
            forwardSearch = {
                args = {},
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false,
            },
        },
    },
}
