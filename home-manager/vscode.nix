{ pkgs, config, ... } @ args:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    userSettings = {
    
      ##### VsCode Settings #####
      ## Commonly Used
      "files.autoSave" = "onFocusChange";
      "editor.fontSize" = 11;
      "editor.fontFamily" = "'Ubuntu Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
      "editor.tabSize" = 4;
      "editor.renderWhitespace" = "selection";
      "editor.cursorStyle" = "line";
      "editor.multiCursorModifier" = "alt";
      "editor.insertSpaces" = true;
      "editor.wordWrap" = "off";
      "files.exclude" = {
        "**/.git" = true;
        "**/.svn" = true;
        "**/.hg" = true;
        "**/CVS" = true;
        "**/.DS_Store" = true;
        "**/Thumbs.db" = true;
      };
      "files.associations" = { };
      "workbench.editor.enablePreview" = true;

      ## WorkBench
      "workbench.colorTheme" = "Default Dark+";
      "workbench.startupEditor" = "none";

      ## Window
      "window.autoDetectColorScheme" = false;

      ## Features
      #### Explorer
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "explorer.enableDragAndDrop" = false;

      ## Application
      #### Update
      "update.mode" = "none";
      "update.showReleaseNotes" = false;

      ## Security
      #### Workspace
      "security.workspace.trust.enabled" = false;
      "security.workspace.trust.startupPrompt" = "never";
      "security.workspace.trust.emptyWindow" = false;
      "security.workspace.trust.untrustedFiles" = "open";
      "security.workspace.trust.banner" = "never";

      ## Extensions
      #### Copilot
      "github.copilot.advanced" = { };
      "github.copilot.editor.enableAutoCompletions" = true;
      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = false;
        "markdown" = false;
        "scminput" = false;
        "yaml" = false;
        "python" = true;
        "javascript" = true;
      };
      #### NixIDE
      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "nixpkgs-fmt";
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "eval" = { };
          "formatting" = {
            "command" = "nixpkgs-fmt";
          };
          "options" = {
            "enable" = true;
            "target" = {
              "args" = [ ];
            };
          };
        };
      };
    };

    extensions = with pkgs.vscode-extensions; [
      # Github Copilot
      github.copilot
      # Nix Language
      jnoortheen.nix-ide
    ];
  };

  home.packages = with pkgs; [
    # Nix Language
    nixd
    nixpkgs-fmt
  ];

  # Impermanence Persistent For VsCode
  home.persistence."/nix/persistent${config.home.homeDirectory}" = {
    directories = [
      ".config/Code/User"
      ".vscode/extensions"
    ];
    files = [ ];
    allowOther = false;
    removePrefixDirectory = false;
  };
}
