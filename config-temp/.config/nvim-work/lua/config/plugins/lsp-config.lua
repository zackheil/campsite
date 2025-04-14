local graph_capabilities = {
  general = {
    positionEncodings = { "utf-16" },
    staleRequestSupport = {                      -- from vscode cypher lsp config
      cancel = true,                             -- from vscode cypher lsp config
      retryOnContentModified = {                 -- from vscode cypher lsp config
        "textDocument/semanticTokens/full",      -- from vscode cypher lsp config
        "textDocument/semanticTokens/range",     -- from vscode cypher lsp config
        "textDocument/semanticTokens/full/delta" -- from vscode cypher lsp config
      }                                          -- from vscode cypher lsp config
    },                                           -- from vscode cypher lsp config
    regularExpressions = {                       -- from vscode cypher lsp config
      engine = "ECMAScript",                     -- from vscode cypher lsp config
      version = "ES2020"                         -- from vscode cypher lsp config
    },                                           -- from vscode cypher lsp config
    markdown = {                                 -- from vscode cypher lsp config
      parser = "marked",                         -- from vscode cypher lsp config
      version = "1.1.0"                          -- from vscode cypher lsp config
    },                                           -- from vscode cypher lsp config
  },
  notebookDocument = {                           -- from vscode cypher lsp config
    synchronization = {                          -- from vscode cypher lsp config
      dynamicRegistration = true,                -- from vscode cypher lsp config
      executionSummarySupport = true             -- from vscode cypher lsp config
    }                                            -- from vscode cypher lsp config
  },                                             -- from vscode cypher lsp config
  window = {
    showDocument = {
      support = true
    },
    showMessage = {
      messageActionItem = {
        additionalPropertiesSupport = true -- from vscode cypher lsp config, default was false
      }
    },
    workDoneProgress = true
  },
  workspace = {
    applyEdit = true,
    configuration = true,
    diagnostics = {
      refreshSupport = true
    },
    didChangeConfiguration = {
      dynamicRegistration = true
    },
    didChangeWatchedFiles = {
      dynamicRegistration = true,
      relativePatternSupport = true
    },
    codeLens = {                  -- from vscode cypher lsp config
      refreshSupport = true       -- from vscode cypher lsp config
    },                            -- from vscode cypher lsp config
    executeCommand = {            -- from vscode cypher lsp config
      dynamicRegistration = true  -- from vscode cypher lsp config
    },                            -- from vscode cypher lsp config
    fileOperations = {            -- from vscode cypher lsp config
      dynamicRegistration = true, -- from vscode cypher lsp config
      didCreate = true,           -- from vscode cypher lsp config
      didRename = true,           -- from vscode cypher lsp config
      didDelete = true,           -- from vscode cypher lsp config
      willCreate = true,          -- from vscode cypher lsp config
      willRename = true,          -- from vscode cypher lsp config
      willDelete = true           -- from vscode cypher lsp config
    },                            -- from vscode cypher lsp config
    inlayHint = {
      refreshSupport = true
    },
    inlineValue = {         -- from vscode cypher lsp config
      refreshSupport = true -- from vscode cypher lsp config
    },                      -- from vscode cypher lsp config
    semanticTokens = {
      refreshSupport = true
    },
    symbol = {
      dynamicRegistration = true, -- this was false originally
      symbolKind = {
        valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
      },
      tagSupport = {                      -- from vscode cypher lsp config
        valueSet = { 1 }                  -- from vscode cypher lsp config
      },                                  -- from vscode cypher lsp config
      resolveSupport = {                  -- from vscode cypher lsp config
        properties = { "location.range" } -- from vscode cypher lsp config
      }                                   -- from vscode cypher lsp config
    },
    workspaceEdit = {
      documentChanges = true,                    -- not in original config
      resourceOperations = { "create", "rename", "delete" },
      failureHandling = "textOnlyTransactional", -- not in original config
      normalizesLineEndings = true,              -- not in original config
      changeAnnotationSupport = {                -- not in original config
        groupsOnLabel = true                     -- not in original config
      }                                          -- not in original config
    },
    workspaceFolders = true,
  },
  textDocument = {
    callHierarchy = {
      dynamicRegistration = true -- false in original config
    },
    codeLens = {                 -- from vscode cypher lsp config
      dynamicRegistration = true -- from vscode cypher lsp config
    },                           -- from vscode cypher lsp config
    codeAction = {
      codeActionLiteralSupport = {
        codeActionKind = {
          valueSet = { "", "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
        }
      },
      dataSupport = true,
      dynamicRegistration = true,
      isPreferredSupport = true,
      resolveSupport = {
        properties = { "edit" }
      }
    },
    colorProvider = {            -- from vscode cypher lsp config
      dynamicRegistration = true -- from vscode cypher lsp config
    },                           -- from vscode cypher lsp config
    completion = {
      completionItem = {
        commitCharactersSupport = true,
        deprecatedSupport = true,
        documentationFormat = { "markdown", "plaintext" },
        insertReplaceSupport = true,
        insertTextModeSupport = {
          valueSet = { 1, 2 } -- originally { 1 }
        },
        labelDetailsSupport = true,
        preselectSupport = true,                                                               -- originally false
        resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits", "command", "data" } -- originally { "documentation", "detail", "additionalTextEdits" }
        },
        snippetSupport = true,
        tagSupport = {
          valueSet = { 1 }
        },
      },
      completionItemKind = {
        valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
      },
      completionList = {
        itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" } -- originally lacking "data"
      },
      contextSupport = true,
      dynamicRegistration = true, -- originally false
      insertTextMode = 2,         -- originally 1
    },
    declaration = {
      dynamicRegistration = true, -- from vscode cypher lsp config
      linkSupport = true
    },
    definition = {
      dynamicRegistration = true,
      linkSupport = true
    },
    diagnostic = {
      dynamicRegistration = true,
      -- relatedDocumentSupport = false -- originally omitted
    },
    documentHighlight = {
      dynamicRegistration = true  -- originally false
    },
    documentLink = {              -- from vscode cypher lsp config
      dynamicRegistration = true, -- from vscode cypher lsp config
      tooltipSupport = true       -- from vscode cypher lsp config
    },                            -- from vscode cypher lsp config
    documentSymbol = {
      dynamicRegistration = true, -- originally false
      symbolKind = {
        valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
      },
      hierarchicalDocumentSymbolSupport = true,
      tagSupport = { valueSet = { 1 } }, -- from vscode cypher lsp config
      labelSupport = true                -- from vscode cypher lsp config
    },
    foldingRange = {
      dynamicRegistration = true,
      rangeLimit = 5000,
      lineFoldingOnly = true,
      foldingRangeKind = {
        valueSet = { "comment", "imports", "region" }
      },
      foldingRange = {
        collapsedText = false
      }
    },
    formatting = {
      dynamicRegistration = true
    },
    hover = {
      dynamicRegistration = true,
      contentFormat = { "markdown", "plaintext" }
    },
    implementation = {
      -- dynamicRegistration = true, -- from vscode cypher lsp config
      linkSupport = true
    },
    inlayHint = {
      dynamicRegistration = true,
      resolveSupport = {
        properties = { "tooltip", "textEdits", "label.tooltip", "label.location", "label.command" } -- adds "label.tooltip"
      }
    },
    inlineValue = {              -- from vscode cypher lsp config
      dynamicRegistration = true -- from vscode cypher lsp config
    },                           -- from vscode cypher lsp config
    linkedEditingRange = {       -- from vscode cypher lsp config
      dynamicRegistration = true -- from vscode cypher lsp config
    },                           -- from vscode cypher lsp config
    onTypeFormatting = {         -- from vscode cypher lsp config
      dynamicRegistration = true -- from vscode cypher lsp config
    },                           -- from vscode cypher lsp config
    publishDiagnostics = {
      relatedInformation = true,
      versionSupport = false, -- from vscode cypher lsp config
      tagSupport = {
        valueSet = { 1, 2 }
      },
      codeDescriptionSupport = true,
      dataSupport = true,
      dynamicRegistration = true
    },
    rangeFormatting = {
      dynamicRegistration = true
    },
    references = {
      dynamicRegistration = true -- originally false
    },
    rename = {
      dynamicRegistration = true,
      prepareSupport = true,
      prepareSupportDefaultBehavior = 1, -- from vscode cypher lsp config
      honorsChangeAnnotations = true     -- from vscode cypher lsp config
    },
    semanticTokens = {
      augmentsSyntaxTokens = true,
      dynamicRegistration = true,
      formats = { "relative" },
      multilineTokenSupport = false,
      overlappingTokenSupport = true,
      requests = {
        range = true,
        full = {
          delta = true
        }
      },
      serverCancelSupport = true, -- originally false
      tokenModifiers = {
        "declaration", "definition", "readonly", "static",
        "deprecated", "abstract", "async", "modification",
        "documentation", "defaultLibrary"
      },
      tokenTypes = {
        "namespace", "type", "class",
        "enum", "interface", "struct", "typeParameter",
        "parameter", "variable", "property", "enumMember",
        "event", "function", "method", "macro", "keyword",
        "modifier", "comment", "string", "number", "regexp",
        "operator", "decorator"
      },
    },
    signatureHelp = {
      dynamicRegistration = true, -- originally false
      signatureInformation = {
        documentationFormat = { "markdown", "plaintext" },
        parameterInformation = {
          labelOffsetSupport = true
        },
        activeParameterSupport = true
      },
      contextSupport = true -- from vscode cypher lsp config
    },
    synchronization = {
      dynamicRegistration = true, -- originally false
      willSave = true,
      willSaveWaitUntil = true,
      didSave = true
    },
    selectionRange = {            -- from vscode cypher lsp config
      dynamicRegistration = true  -- from vscode cypher lsp config
    },                            -- from vscode cypher lsp config
    typeDefinition = {
      dynamicRegistration = true, -- from vscode cypher lsp config
      linkSupport = true
    },
    typeHierarchy = {            -- from vscode cypher lsp config
      dynamicRegistration = true -- from vscode cypher lsp config
    },                           -- from vscode cypher lsp config
  },
}


return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      'williamboman/mason-lspconfig.nvim',
      "j-hui/fidget.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local blink = require("blink.cmp")
      local mason = require("mason")
      local masonlsp = require("mason-lspconfig")
      local fidget = require("fidget")

      -- setup auto-completion
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities()
      )

      -- nvim ufo fold capabilites
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      -- mason setup
      mason.setup()

      -- mason lsp setup
      masonlsp.setup({
        ensure_installed = { "lua_ls", "vimls", "biome", "ts_ls", "cypher_ls" },
        handlers = {
          -- default lsp settings for all servers
          function(server)
            lspconfig[server].setup({
              capabilities = capabilities
            })
          end,


          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim', 'hs' }
                  },
                  workspace = {
                    library = {
                      [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                      [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                      ['$XDG_CONFIG_HOME/hammerspoon/Spoons/EmmyLua.spoon/annotations'] = true,
                    },
                  },
                }
              }
            })
          end,

          ["ts_ls"] = function()
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
              end,
            })
          end,

          ["cypher_ls"] = function()
            lspconfig.cypher_ls.setup({
              filetypes = { "cypher" },
              capabilities = graph_capabilities, -- use the custom capabilities defined above
              -- capabilities = vim.tbl_deep_extend("force", capabilities, {
              --   textDocument = {
              --     semanticTokens = { dynamicRegistration = true },
              --     publishDiagnostics = { dynamicRegistration = true },
              --   },
              --   workspace = {
              --     didChangeConfiguration = { dynamicRegistration = true },
              --   },
              -- }),
            })
          end
        }
      })

      -- fidget setup
      fidget.setup({})

      -- Add filetype detection for .cyp files
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.cyp",
        callback = function()
          vim.bo.filetype = "cypher"
        end,
      })

      -- modify the cypher_ls setup to be explicit about filetypes
      -- lspconfig.cypher_ls.setup({
      --   filetypes = { "cypher" }, -- No need to add 'cyp' here as we're setting the filetype to 'cypher'
      --   capabilities = require('blink.cmp').get_lsp_capabilities(),
      -- })

      -- keybindings
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- format on save action

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or not client.supports_method("textDocument/formatting") then return end

          -- Only set up once per buffer
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({
                bufnr = args.buf,
                filter = function(fmt_client)
                  -- Prefer null-ls if it's available
                  if vim.lsp.get_active_clients({ bufnr = args.buf, name = "null-ls" })[1] then
                    return fmt_client.name == "null-ls"
                  end
                  -- Otherwise use whatever client this is
                  return true
                end,
              })
            end,
            desc = "Auto format before save",
          })
        end,
      })
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not client then return end
      --
      --     if client.name == "null-ls" and client.supports_method('textDocument/formatting') then
      --       vim.api.nvim_create_autocmd('BufWritePre', {
      --         buffer = args.buf,
      --         callback = function()
      --           vim.lsp.buf.format({
      --             bufnr = args.buf,
      --             filter = function(fmt_client)
      --               return fmt_client.name == "null-ls"
      --             end,
      --           })
      --         end,
      --       })
      --     end
      --   end,
      -- })
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not client then return end
      --
      --     -- if client.supports_method('textDocument/completion') then
      --     --   -- enable auto-completion
      --     --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      --     -- end
      --
      --     if client.supports_method('textDocument/formatting') then
      --       -- format the current buffer on save
      --       vim.api.nvim_create_autocmd('BufWritePre', {
      --         buffer = args.buf,
      --         callback = function()
      --           vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
      --         end,
      --       })
      --     end
      --   end,
      -- })
    end
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = { "mason.nvim", "davidmh/cspell.nvim" },
    opts = function(_, opts)
      local builtins = require('null-ls').builtins
      local cspell = require("cspell")

      -- local biome = builtins.formatting.rome.with({
      --   command = "biome",
      -- })
      opts.sources = vim.list_extend(opts.sources or {}, {
        builtins.formatting.biome,
      })

      -- opts.sources = opts.sources or {}
      --
      -- opts.sources[#opts.sources + 1] = builtins.formatting.biome.with({
      --   args = {
      --     'format',
      --     '--apply-unsafe',
      --     '--formatter-enabled=true',
      --     '--organize-imports-enabled=true',
      --     '--skip-errors',
      --     '$FILENAME',
      --   },
      -- })

      -- Check if there's a cspell.json in the project tree or global config
      local function find_cspell_config()
        local current_dir = vim.fn.expand('%:p:h')            -- Start from the current file's directory
        local global_config = vim.fn.expand('~/.cspell.json') -- Global cspell.json in home directory

        -- Check for global cspell.json first
        if vim.fn.filereadable(global_config) == 1 then
          return global_config
        end

        -- Search up the file tree for cspell.json
        while current_dir ~= '/' do
          local config_path = current_dir .. '/cspell.json'
          if vim.fn.filereadable(config_path) == 1 then
            return config_path
          end
          current_dir = vim.fn.fnamemodify(current_dir, ':h') -- Go up one level
        end

        return nil -- No config found
      end

      -- Find the cspell.json file
      local cspell_config = find_cspell_config()

      -- If there's a cspell.json file, enable cspell diagnostics and code actions
      if cspell_config then
        table.insert(
          opts.sources,
          cspell.diagnostics.with({
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity.HINT
            end,
          })
        )
        table.insert(opts.sources, cspell.code_actions)
      end
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  }
  -- {
  --   {
  --     "nvimtools/none-ls.nvim",
  --     event = "VeryLazy",
  --     dependencies = { "mason.nvim", "davidmh/cspell.nvim" },
  --     opts = function(_, opts)
  --       local builtins = require('null-ls').builtins
  --
  --       local cspell = require("cspell")
  --       opts.sources = opts.sources or {}
  --       opts.sources[#opts.sources + 1] = builtins.formatting.biome.with({
  --         args = {
  --           'format',
  --           '--apply-unsafe',
  --           '--formatter-enabled=true',
  --           '--organize-imports-enabled=true',
  --           '--skip-errors',
  --           '$FILENAME',
  --         },
  --       })
  --
  --       table.insert(
  --         opts.sources,
  --         cspell.diagnostics.with({
  --           diagnostics_postprocess = function(diagnostic)
  --             diagnostic.severity = vim.diagnostic.severity.HINT
  --           end,
  --         })
  --       )
  --       table.insert(opts.sources, cspell.code_actions)
  --     end,
  --   },
  -- }
}
