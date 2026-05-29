{
  programs.git = {
    enable = true;

    settings = {
      alias = {
        a = "add";
        br = "branch";
        ci = "commit";
        co = "checkout";
        lg = "log --graph --pretty=format:'%C(auto)%h%Creset %C(cyan)%ad%Creset %C(auto)%d%Creset %s %C(dim white)- %an%Creset' --date=short";
        st = "status --short --branch";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
      rerere.enabled = true;
      core.editor = "nvim";
      merge.conflictStyle = "zdiff3";
      diff.algorithm = "histogram";
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
    };

    ignores = [
      ".direnv/"
      ".envrc.local"
      ".DS_Store"
      "node_modules/"
      "dist/"
      "build/"
      ".turbo/"
      ".next/"
      ".nuxt/"
      "coverage/"
    ];
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
