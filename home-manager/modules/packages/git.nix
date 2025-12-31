{ inputs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ludofr3";
        email = "ludovic.de-chavagnac@epitech.eu";
      };
    };    
  };
}