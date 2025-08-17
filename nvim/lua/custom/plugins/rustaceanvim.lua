return {
  {
    'mrcjkb/rustaceanvim',
    dependencies = {
      'artemave/workspace-diagnostics.nvim',
    },
    version = '^4', -- Recommended
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          enable_clippy = false,
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              rust = {
                -- Use a separate target dir for Rust Analyzer. Helpful if you want to use Rust
                -- Analyzer and cargo on the command line at the same time.
                analyzerTargetDir = 'target/nvim-rust-analyzer',
              },
              server = {
                --  Improve stability
                extraEnv = {
                  ['CHALK_OVERFLOW_DEPTH'] = '100000000',
                  ['CHALK_SOLVER_MAX_SIZE'] = '100000000',
                },
              },
              files = {
                excludeDirs = { 'target' },
              },
              cargo = {
                -- Check feature-gated code
                features = 'all',
                extraEnv = {
                  -- Skip building WASM, there is never need for it here
                  ['SKIP_WASM_BUILD'] = '1',
                },
              },
              procMacro = {
                -- Don't expand some problematic proc_macros
                ignored = {
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                  ['async-std'] = { 'async_std' },
                },
              },
              rustfmt = {
                -- Use nightly formatting.
                -- See the polkadot-sdk CI job that checks formatting for the current version used in
                -- polkadot-sdk.
                extraArgs = { '+nightly-2024-04-10' },
              },
            },
          },
        },
      }
    end,
  },
}
