local cmd = "vls"

local config = {
    filetypes = { "vue" },
    cmd = {cmd},
    css = {},
    emmet = {},
    html = {
      suggest = {}
    },
    javascript = {
      format = {}
    },
    stylusSupremacy = {},
    typescript = {
      format = {}
    },
    vetur = {
      completion = {
        autoImport = false,
        tagCasing = "kebab",
        useScaffoldSnippets = false
      },
      format = {
        defaultFormatter = {
          js = "none",
          ts = "none"
        },
        defaultFormatterOptions = {},
        scriptInitialIndent = false,
        styleInitialIndent = false
      },
      useWorkspaceDependencies = false,
      validation = {
        script = true,
        style = true,
        template = true
      }
  }
}

return config