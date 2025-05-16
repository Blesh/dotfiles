return {
  {
    url = "ibhagwan/fzf-lua",
    event = "VeryLazy",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    dependencies = { "echasnovski/mini.icons" },
    -- config is executed when the plugin loads. Either `fun(LazyPlugin, opts:table)` or `true`
    -- the default implementation will automatically run `require(MAIN).setup(opts)` if `opts` or
    -- or `config = true`
    -- NOTE opts should be preferred over config

    -- opts should return a table or change a table, which will be merged with parent spec
    -- the table will be passed `Plugin.config()`
    -- opts = {
    --   keymap = {
    --     builtin = {
    --       ["ctrl-h"] = "hide",
    --       ["ctrl-f"] = "preview-page-down",
    --       ["ctrl-b"] = "preview-page-up",
    --     },
    --     fzf = {
    --       ["ctrl-d"] = "half-page-down",
    --       ["ctrl-u"] = "half-page-up",
    --       ["ctrl-f"] = "preview-page-down", -- TODO preview scrolling not working
    --       ["ctrl-b"] = "preview-page-up",
    --     }
    --   }
    -- },

    -- Fzf-lua provides multiple different commands to recursively search for different types of information in some directory
    -- using the `fzf` binary on the system that can be executed in neovim and have the result displayed in neovim as well.

    -- These commands inherently are what exactly will provide us with the desired information, which is why they are referred
    -- to as pickers (from looking at the telescope code a `picker` is more of a term for the entire UI element which we see
    -- and interact with our results in, which consists of multiple individual elements including `window`, `layout`, `highlights`,
    -- `scroller`, and `entry display`) or in the fzf-lua repository those are called `providers`. For most use cases the following
    -- providers are probably the most useful
    --
    --    - files
    --    - grep
    --    - git

    -- Their implementation can be found in the `fzf-lua/providers/` directory. Looking in their implementation we can see which utility
    -- those finders are using, for example, `files` will use in order of prioriry `fd`, `rg`, or `find` to query for files. Each provider
    -- has roughly the following execution steps

    --    1. Get called with optional `opts` which can contain all possibl fzf-lua settings, i.e., `prompt`, `winopts`, `fzf_opts`, etc. These
    --    are collected and merged into one using `normalize_opts()` in `fzf-lua/config.lua`.
    --    2. Construct `opt.cmd` using the `get_<provider_specific>_cmd()` function in each provider, which is determining which utility will be used
    --    to fetch the desired information, e.g., `rg` for the `grep` provider.
    --    3. Use `local contents = core.mt_cmd_wrapper(opts)` which will contain the contents of the fzf interface based on the command on opts, which can be
    --    a piped shell command, function with callback, or a table, i.e., array of string / lines.
    --    4. Execute `core.fzf_exec(contents, opts)`

    -- Example: When using `files` the contents and opts might look something like this

    -- __contenst__: '/usr/local/bin/nvim' -u NONE -l /home/onur.cakmak-simic/.local/share/nvim/lazy/fzf-lua/lua/fzf-lua/spawn.lua 'return <bunch_of_gibberish>'
    -- __opts__: {
    --   _cwd = "/home/onur.cakmak-simic/work/riot/main",
    --  actions = {
    --   ["alt-Q"] = <function 3>,
    --   ["alt-f"] = {
    --     fn = <function 4>,
    --     header = false,
    --     reuse = true
    --   },
    --   enter = <function 10>
    --   cmd = "fdfind --no-ignore --hidden --color=never --type f --type l --exclude .git",
    -- fzf_opts = {
    --   ["--ansi"] = true,
    --   ["--border"] = "none",
    --   ["--delimiter"] = "[ ]",
    -- ...
    -- hls = {   -- A list of all highlights can be found in `fzf-lua/init.lua`.
    --   backdrop = "FzfLuaBackdrop", 
    --   border = "FzfLuaBorder",
    --   buf_flag_alt = "FzfLuaBufFlagAlt",
    --   fzf = {
    --     border = "FzfLuaFzfBorder",
    --     cursorline = "FzfLuaFzfCursorLine",
    --   ...
    -- keymap = {
    --   builtin = {
    --     ["<c-b>"] = "preview-page-up",
    --     ["<c-f>"] = "preview-page-down"
    --   },
    --   fzf = {
    --     ["alt-a"] = "beginning-of-line",
    --   ...
    -- prompt = "~/work/riot/main/",
    -- rg_opts = '--color=never --files -g "!.git"',
    -- winopts = {
    --   backdrop = 60,
    --   border = "rounded",
    --   col = 0.55,
    --   fullscreen = false,
    --   height = 0.3,
    --   preview = {
    --     border = "rounded",
    --     default = "builtin", -- uses fzf's builtin preview window. The "builtin" previewer uses a neovim buffer inside floating window created with the nvim_open_win API.
    -- }

    -- Once an item in the shown results is selected the keymappings in the `actions` table leads to the given builtin action or
    -- our own handler being executed. The builtin actions are in `fzf-lua/actions.lua`.

    -- In the example above we see that the previewer is the `builtin` which uses a neovim buffer inside a floating window created via `nvim_open_win.
    -- The other option would be fzf's native previewer, hence the names `defaults.keymap.builtin` and `default.keymap.fzf`, for the keymaps. The builtin
    -- neovim previewer comes with a bunch of pre-configured previewers that can be found here https://github.com/ibhagwan/fzf-lua#customization

    -- Having the big picture, what we can do in our config is globally or for each provider individually

    --  1. Actions performed on selected items
    --  2. Top level `winopts`, `previewer` settings and their `winopts`
    --  3. `fzf` and `fzf-lua` Highlights
    --  4. Properties of the provider itself, e.g., options passed to the utilities

    -- Where fzf-lua options can be provided in the following ways

    --  1. Global setup options applyting to every fzf interface, e.g., `fzf-lua.setup({ defaults = { file_icons = false } })`
    --  2. Provider defaults e.g., `fzf-lua.setup({ winopts = { ... })`
    --  3. Provider specific e.g., `fzf-lua.setup({ files = { winopts = { ... } }})`
    --  4. Command call options, e.g., ???

    config = function()
      -- vim.print("opts", opts)
      local actions = require("fzf-lua").actions
      require("fzf-lua").setup({
        fzf_colors = true,
        keymap     = {
          builtin = {
            -- TODO Why does this require `C` for control, and does not work with `ctrl`
            -- https://neovim.io/doc/user/intro.html#key-codes
            ["<C-f>"]    = "preview-half-page-down",
            ["<C-b>"]    = "preview-half-page-up",
          },
          fzf = { -- TODO maybe I can fzf to .editrc for custom keybinds?
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
            ["alt-e"] = "end-of-line",
            ["alt-a"]  = "beginning-of-line",
            ["ctrl-q"] = "select-all+accept",
            ["ctrl-e"] = "preview-half-page-down",
            ["ctrl-b"] = "preview-half-page-up",
          },
        },
        -- TODO add config for lsp picker
        files = {
          actions = {
            ["ctrl-s"] = actions.file_vsplit,
          },
          winopts = {
            row = 0.35,
            col = 0.5,
            height = 0.3,
            width = 0.4,
            backdrop = 100,
            title = '',
            title_flags = false,
            preview = {
              hidden = true,
            },
          }
          -- no_ignore = false, -- include ignored files, as `git_files` already includes `--exclude-standard` respecting .gitignore and .git/info/exclude
        },
        git = {
          files = {
            winopts = {
              backdrop = 100,
              title = '',
              title_flags = false,
              row = 0.35,
              col = 0.5,
              height = 0.3,
              width = 0.4,
              cwd_header = true,
              preview = {
                hidden = true,
              },
            },
          },
          bcommits = {
            actions = {
              ["ctrl-s"] = actions.git_buf_vsplit,
              ["ctrl-o"] = function(selected, opts)
                -- Get the commit hash from the selected item
                local commit = selected[1]:match("%S+") -- Extract first word (the commit hash)
                if commit then
                  -- Close any existing diffview
                  vim.cmd("DiffviewClose")
                  -- Get current file path relative to git root
                  local file_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
                  -- Open diffview for this specific file and commit
                  vim.cmd(string.format("DiffviewOpen %s^..%s -- %s", commit, commit, file_path))
                end
              end
            },
          },
        },
        grep = {
          RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
          winopts = {
            title = '',
            title_flags = false,
            backdrop = 100,
            preview = {
              scrollbar = false,
              layout = "vertical",
            },
          },
        },
        lsp = {
          winopts = {
            title = '',
            title_flags = false,
            backdrop = 100,
            preview = {
              scrollbar = false,
              layout = "vertical",
            },
          },
        },
      })

      local fzf = require("fzf-lua")

      -- require("fzf-lua").setup()
      -- not sure what this impacts beyond the stuff we already defined ourselves in lsp
      fzf.register_ui_select()
      vim.keymap.set('n', '<leader>saf', function() fzf.files({ no_ignore = true })  end) -- ignore .gitignore
      vim.keymap.set('n', '<leader>sf', fzf.files)  -- respects `.gitignore`, `$HOME/.config/git/ignore`, and `.git/info/exclude` by default

      -- git
      -- uses git ls-files which out of the box respects .gitignore, .git/info/exclude, etc.
      -- Default preview shows a git diff against the last commit
      vim.keymap.set('n', '<leader>sgc', fzf.git_bcommits)
      -- not really useful for my workflow, the only nice thing would be in general a nice way to inspect stash contents
      vim.keymap.set('n', '<leader>sgs', fzf.git_stash)

      -- REMARK Options or Flags are things that modify a command while arguments are typically the values specifying what the
      -- command operates on as input. Arguments in most cases follow the name of the command and an arbitrary number of options,
      -- and their position typically matters. Options / Flags are typically introduced by one or two hyphens. Most modern command
      -- utilities treat a double hyphen `--` by itself as a special signal, that this is the end of all options. Any subsequent items
      -- will be treated as positional arguments and not options, useful for example when the argument is a filename with a hyphen as prefix.
      -- Options with a single hyphen are referred to as __short options__ or __single-character options__, as the hyphen is only followed
      -- by a single alaphanumeric character. These can typically be bundled together, i.e., `-l -t -f` <=> `-ltf`. If such an option takes
      -- a value it can typically be specified right after the character, e.g., `-ofilename` or `-o filename`.
      -- Options with double hyphen are called __long options__ or __GNU-style options__. Here values are typically seperated from the option
      -- using an equal sign, e.g., `--output=filename`, while many utilities also support separation via a space.
      -- NOTE that the special double-hyphen delimiter `--` is also often used by wrapper utilities, which allows the user to indicate the point
      -- of the command where every following options should be passed to the wrapped utility, e.g., `cargo test <test_module> -- <rest>` will
      -- pass `<rest>` to the compiled test binary.

      -- NOTE ripgrep  recursively searches the current directory (or stdin) for a regex pattern. By default ripgrep respects `.gitignore`
      -- and skips hidden files and directories. Unlike grep when its stdout is connected to a tty ripgrep will by default enable colors,
      -- line numbers and headings with filenames. By defualt rusts regex engine is used https://docs.rs/regex/1.*/regex/#syntax

      -- REMARK The term `glob` has its origin in the early versions of Unix where the `glob` utility (derived from `global`) performed wildcard
      -- expansion of wildcard characters in command-line arguments before the command itself was executed. See `man 7 glob` for more information.
      -- A string is a wildcard pattern if it contains one of the characters `?`, `*`, or `[`. Globbing is the operation that expands the wildcard pattern
      -- into the list of pathnames matching the pattern. It is important to be aware that wildcard patterns which match filenames are not the same as
      -- regular expressions which match text. For example `*` as a wildcard pattern matches any string while in regular expressions it maches zero or
      -- more copies of the preceeding expression.


      -- `--pre-glob=GLOB` can be used to only search for the patten in files that match `GLOB`. In particular useful when we use the `--pre=COMMAND` option
      --    as well which results in every input PATH to have COMMAND applied to and ripgrep search the standard output of that command, e.g., COMMAND= `pdftotext`
      -- `--glob=GLOB` or `-g GLOB` can be used to include or exclude files and directories that match the given `GLOB`. Prefixing with ! will exclude
      --    files or directories matching the glob. That means searching a particular directory `foo` is done via `rg --glob="foo/**"
      -- `--hidden` makes rg include hidden files and directories in its search, which by default is not the case.
      -- `--type=TYPE` / `--type-not=TYPE` makes rg search / not search in files of the given TYPE, e.g., `cpp`, `txt`, `zsh`, `yaml`, `pdf`
      -- `--sort=SORTBY` enables sorting of results by things like `modified` or `created` timestamp
      -- `--count-matches` shows the count of matches for each file that was searched for the pattern. That means with `--regexp="*"` this is basically
      --    equivalent to `cat  file | wc -l`(?)
      -- `--files` prints each file that would be searched without actually performing the search

      -- Although it has lowest priority we can write `.rgignore` files to specify files and directories to be ignored. `--no-ignore` will disable all,
      -- `--hidden` will mage rg search hidden files and directories `--follow` will make it follow symbolic links, and `--binary` will make it search
      -- binary files as well.
      -- For custom configuration we can specify `RIPGREP_CONFIG_PATH` where we can place a `.ripgreprc` file where we can place arguments that will
      -- be prepended to the explicit arguments given on the command line.
      -- We can use `--generate=complete-zsh` to generate completion script for zsh and copy the `_rg` file to `/usr/local/share/zsh/site-functions/`
      -- or `$HOME/.zsh/completions/`


      -- Globbing rules match `.gitignore` globs.
      vim.keymap.set('n', '<leader>sp', fzf.live_grep_native) -- aparently faster than the one above, why the distinction then?
      vim.keymap.set('n', '<leader>sap', function() fzf.live_grep_native({ no_ignore = true }) end) -- add `--no-ignore` option

      vim.keymap.set('n', '<leader>sw', fzf.grep_cword)
      vim.keymap.set('n', '<leader>saw', function() fzf.grep_cword({ no_ignore = true }) end) -- add `--no-ignore` option
      -- really nice in combination with <ctrl-g> to search the search results
      vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf)
      -- vim.keymap.set('n', '<leader>sr', fzf.live_grep_resume) -- difference to below?
      vim.keymap.set('n', '<leader>sr', fzf.resume)
      vim.keymap.set('n', '<leader>sht', fzf.helptags)
      vim.keymap.set('n', '<leader>smp', fzf.manpages)
      vim.keymap.set('n', '<leader>shi', fzf.highlights)
      vim.keymap.set('n', '<leader>skm', fzf.keymaps)
      vim.keymap.set('n', '<leader>sma', fzf.marks)
      vim.keymap.set('n', 'z=', function() fzf.spell_suggest({ winopts = { height = 0.3, width = 0.4, backdrop = 100, title = '' }}) end)
    end
  }
}

