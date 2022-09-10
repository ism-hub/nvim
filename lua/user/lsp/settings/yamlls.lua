-- local lspconfig = require'lspconfig'
-- lspconfig.yamlls.setup{
--     settings = {
--         yaml = {
--            schemas = {
--                 ["https://kubernetesjsonschema.dev/v1.14.0/deployment-apps-v1.json"] = "*.yaml",
--                 ["https://kubernetesjsonschema.dev/v1.10.3-standalone/service-v1.json"] = "*.yaml"
--             },
--       }
--     }
-- }



-- require('lspconfig').yamlls.setup {
--     on_attach = on_attach,
--     settings = {
--         yaml = {
--             schemas = {
--                 ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.0/deployment-apps-v1.json"] = "/*"
--             }
--         }
--     },
-- }
--

return {
    settings = {
      yaml = {
        trace = {
          server = "verbose"
        },
        schemas = {
          kubernetes = "*.yaml"
        },
        schemaDownload = {  enable = true },
      	validate = true,
      }
    },
}
-- require('lspconfig').yamlls.setup {
--     --cmd = cmd,
--     on_attach = on_attach,
--     settings = {
--       yaml = {
--         trace = {
--           server = "verbose"
--         },
--         schemas = {
--           kubernetes = "/*.yaml"
--         },
--         schemaDownload = {  enable = true },
--       	validate = true,
--       }
--     },
--   }
