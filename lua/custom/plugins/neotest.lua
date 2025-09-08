return {
  {
    'nvim-neotest/neotest',
    commit = '52fca6717ef972113ddd6ca223e30ad0abb2800c',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'jfpedroza/neotest-elixir',
      'nsidorenco/neotest-vstest',
      'marilari88/neotest-vitest',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-elixir',
          require 'neotest-vstest' {
            dap_settings = {
              type = 'netcoredbg',
            },
            solution_selector = function()
              return nil
            end,
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
