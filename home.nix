{ config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "min";
  home.homeDirectory = "/home/min";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    tmux
    htop
    jq
    ncdu
    tig
    tldr
    tree
    vnstat
    bat
    pass
    fzf
    ripgrep
    git-lfs
    nerd-fonts.caskaydia-cove
    direnv

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "CaskaydiaCoveNerdFont" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/tmux/tmux.conf".source = dotfiles/tmux.conf;
    ".config/ripgrep/config".source = dotfiles/ripgreprc;
    ".config/tig/config".source = dotfiles/tigrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/min/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Shell
  programs.bash = {
    enable = true;
    initExtra = ''
      source "$HOME/.config/home-manager/dotfiles/bashrc"
    '';
  };

  # Git
  programs.git = {
    enable = true;
    # NOTE: Don't add config here. Its in ./dotfiles/git/config
  };
  xdg.configFile."git" = {
    recursive = true;
    source = ./dotfiles/git;  # this source is `.config/home-manager/lua`
  };


# TODO: Migrate neovim config to nix:
  # https://nixalted.com/
  # Following config is copy pasted from:
  #https://github.com/LazyVim/LazyVim/discussions/1972
  programs.neovim = {
	enable = true;
	vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      # Telescope
      #ripgrep
      #fzf
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig =
      let
        plugins = with pkgs.vimPlugins; [
          LazyVim
          # Have nix save plugins to nix store so that lazy doesn't have to save them to ~/.local
          # My plugins
          vim-fugitive
          vim-fubitive
          fugitive-gitlab-vim
          vim-rhubarb
          vim-unimpaired
          vim-sensible
          vim-surround  # TODO: Check mini
          vim-endwise
          vim-sleuth
          vim-abolish
          fzf-vim
          nerdcommenter  # TODO: Chieck mini
          toggleterm-nvim
	      cmp-emoji
          # LazyVim Defaults
          # bufferline-nvim  # I don't use
          cmp-buffer
          cmp-nvim-lsp
          cmp-path
          cmp_luasnip
          conform-nvim
          dashboard-nvim
          dressing-nvim
          # flash-nvim  # I don't use
          friendly-snippets
          gitsigns-nvim
          grug-far-nvim
          indent-blankline-nvim
          lazydev-nvim
          lualine-nvim
          neo-tree-nvim
          neoconf-nvim
          neodev-nvim
          noice-nvim
          nui-nvim
          nvim-cmp
          nvim-lint
          nvim-lspconfig
          nvim-notify
          nvim-snippets
          nvim-spectre
          # nvim-treesitter
          # nvim-treesitter-context
          # nvim-treesitter-textobjects
          nvim-ts-autotag
          nvim-ts-context-commentstring
          nvim-web-devicons
          persistence-nvim
          plenary-nvim
          snacks-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          todo-comments-nvim
          tokyonight-nvim
          trouble-nvim
          ts-comments-nvim
          vim-illuminate
          vim-startuptime
          which-key-nvim
	      vim-nix
          { name = "LuaSnip"; path = luasnip; }
          { name = "catppuccin"; path = catppuccin-nvim; }
          { name = "mini.ai"; path = mini-nvim; }
          { name = "mini.bufremove"; path = mini-nvim; }
          { name = "mini.comment"; path = mini-nvim; }
          { name = "mini.indentscope"; path = mini-nvim; }
          { name = "mini.pairs"; path = mini-nvim; }
          { name = "mini.surround"; path = mini-nvim; }
          { name = "mini.icons"; path = mini-nvim; }
        ];
        mkEntryFromDrv = drv:
          if lib.isDerivation drv then
            { name = "${lib.getName drv}"; path = drv; }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
        require("lazy").setup({
          defaults = {
            lazy = true,
          },
          dev = {
            -- reuse files from pkgs.vimPlugins.*
            path = "${lazyPath}",
            patterns = { "" },
            -- fallback to download
            fallback = true,
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- The following configs are needed for fixing lazyvim on nix
            -- force enable telescope-fzf-native.nvim
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
            -- disable mason.nvim, use programs.neovim.extraPackages
            { "williamboman/mason-lspconfig.nvim", enabled = false },
            { "williamboman/mason.nvim", enabled = false },
            -- disable default LazyVim plugins i don't like
            -- see ./config/nvim/lua/plugins/core.lua
            -- import/override with your plugins
            { import = "plugins" },
            -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
            -- { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
            { "nvim-treesitter/nvim-treesitter", enabled = false },
            { "nvim-treesitter/nvim-treesitter-context", enabled = false },
            { "nvim-treesitter/nvim-treesitter-textobjects", enabled = false },
          },
        })
      '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  # xdg.configFile."nvim/parser".source =
  #   let
  #     parsers = pkgs.symlinkJoin {
  #       name = "treesitter-parsers";
  #       paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
  #         c
  #         lua
  #       ])).dependencies;
  #     };
  #   in
  #   "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  # NOTE: This unfortunately get copied (not linked) from the source
  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;  # this source is `.config/home-manager/lua`
  };
}
