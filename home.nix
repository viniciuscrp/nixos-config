{
  home.username = "brainov";
  home.homeDirectory = "/home/brainov";
  
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
      gcloud_disabled = true;
      line_break.disabled = true;
    };
  };

  home.stateVersion = "25.11";
}
