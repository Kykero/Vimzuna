# modules/aspects/yazi.nix
{ ... }:
{
  den.aspects.yazi.vim =
    { pkgs, ... }:
    {
      extraPackages = [ pkgs.yazi ];

      utility.yazi-nvim = {
        enable = true;
        mappings = {
          openYazi = "<leader>n";
          openYaziDir = "<leader>N";
        };
      };
    };
}
