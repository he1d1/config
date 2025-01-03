{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = true;
    };

    clipboard = {
      providers = {
        wl-copy.enable = true;
      };
      register = "unnamedplus";
    };

    opts = {
      number = true;
      mouse = "a";
      showmode = false;
      breakindent = true;
      undofile = true;
      signcolumn = "yes";
    };

    plugins = {
      # statusline
      lualine = {
        enable = true;
        settings = {
          theme = "auto";
        };
      };

      sleuth.enable = true; # auto detect tabs

      gitsigns.enable = true; # adds git signs to gutter

      # shows pending commands
      which-key = {
        enable = true;
        settings.spec = [
          {
            __unkeyed-1 = "<leader>c";
            group = "[C]ode";
            icon = "";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "[D]ocument";
            icon = "";
          }
          {
            __unkeyed-1 = "<leader>r";
            group = "[R]ename";
            icon = "which_key_ignore";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "[S]earch";
            icon = "which_key_ignore";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "[W]orkspace";
            icon = "which_key_ignore";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "[T]oggle";
            icon = "which_key_ignore";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "Git [H]unk";
            icon = "which_key_ignore";
          }

        ];
      };

      # search
      telescope = {
        enable = true;

        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };

        keymaps = {
          "<leader>sh" = {
            mode = "n";
            action = "help_tags";
            options = {
              desc = "[S]earch [H]elp";
            };
          };
          "<leader>sk" = {
            mode = "n";
            action = "keymaps";
            options = {
              desc = "[S]earch [K]eymaps";
            };
          };
          "<leader>sf" = {
            mode = "n";
            action = "find_files";
            options = {
              desc = "[S]earch [F]iles";
            };
          };
          "<leader>ss" = {
            mode = "n";
            action = "builtin";
            options = {
              desc = "[S]earch [S]elect Telescope";
            };
          };
          "<leader>sw" = {
            mode = "n";
            action = "grep_string";
            options = {
              desc = "[S]earch current [W]ord";
            };
          };
          "<leader>sg" = {
            mode = "n";
            action = "live_grep";
            options = {
              desc = "[S]earch by [G]rep";
            };
          };
          "<leader>sd" = {
            mode = "n";
            action = "diagnostics";
            options = {
              desc = "[S]earch [D]iagnostics";
            };
          };
          "<leader>sr" = {
            mode = "n";
            action = "resume";
            options = {
              desc = "[S]earch [R]esume";
            };
          };
          "<leader>so" = {
            mode = "n";
            action = "oldfiles";
            options = {
              desc = "[S]earch [O]ld Files";
            };
          };
          "<leader><leader>" = {
            mode = "n";
            action = "buffers";
            options = {
              desc = "[ ] Find existing buffers";
            };
          };
        };
      };

      # errors
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # nix
        };
      };

      # formatting
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = [ "nixfmt" ];
          };
          format_on_save =
            # Lua
            ''
              function(bufnr)
               return {}
              end
            '';
        };
      };

      # completions
      cmp = {
        enable = true;

        settings = {
          snippet = {
            expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };

          completion = {
            completeopt = "menu,menuone,noinsert";
          };

          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
        };
      };
      luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;

      # Syntax Highlighting
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      mini = {
        enable = true;

        modules = {
          ai = { };
          surround = { };
          icons = { };
        };

        mockDevIcons = true;
      };

      todo-comments = {
        enable = true;
        signs = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style # nix formatter
    ripgrep # telescope live grep
  ];
}
