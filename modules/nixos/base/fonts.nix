_:

{
  flake.modules.nixos.workstation =
    { pkgs, ... }:

    {
      fonts = {
        packages = with pkgs; [
          inter
          nerd-fonts.jetbrains-mono
          nerd-fonts.symbols-only
          noto-fonts
          noto-fonts-color-emoji
        ];

        fontconfig.defaultFonts = {
          serif = [ "Inter" ];
          sansSerif = [ "Inter" ];
          monospace = [ "JetBrainsMono Nerd Font" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
}
