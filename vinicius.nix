{
  home.username = "vinicius";
  home.homeDirectory = "/home/vinicius";
  
  programs.git = {
    enable = true;
    userName = "Vinicius da Cruz Rodrigues Paulo";
    userEmail = "vinicius.rodrigues04@outlook.com";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
    };
  };

  home.stateVersion = "25.11";
}
