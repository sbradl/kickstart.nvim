return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'jfpedroza/neotest-elixir',
      'Issafalcon/neotest-dotnet',
      'marilari88/neotest-vitest',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-elixir',
          require 'neotest-dotnet' {
            dap = {
              args = { justMyCode = false },
              adapter_name = 'netcoredbg',
              discovery_root = 'solution',
            },
          },
          require 'neotest-vitest' {
            filter_dir = function(name, rel_path, root)
              return name ~= 'node_modules'
            end,
          },
        },
      }

      vim.keymap.set('n', '<leader>tt', function()
        require('neotest').run.run(vim.fn.expand '%')
      end, { desc = 'Run tests in current file' })

      vim.keymap.set('n', '<leader>tr', function()
        require('neotest').run.run()
      end)

      vim.keymap.set('n', '<leader>to', function()
        require('neotest').output.open { enter = true }
      end)

      vim.keymap.set('n', '<leader>ts', function()
        require('neotest').summary.toggle()
      end)
    end,
  },
}
