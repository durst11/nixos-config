{ config, pkgs, inputs ... }:

{
  home.username = "jeremy";
  home.homeDirectory = "/home/jeremy";

  # User Packages
  home.packages = with pkgs; [
    
    asciinema
    fastfetch
    nnn # terminal file manager
    # Utils
    eza # replace for 'ls'
    fzf # command-line fuzzy finder

  ];

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "durst11";
    userEmail = "durst.11@protonmail.com";
  };

  home.stateVersion = "24.05";
  
  # let home manager install and manage itself
  programs.home-manager.enable = true;


# WezTerm
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
  };
}
