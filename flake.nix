{
  description = "Development environment for LLMs from scratch";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              python312
              uv
              direnv
              git
              pkg-config
            ];

            env = {
              UV_PYTHON = "${pkgs.python312}/bin/python";
              UV_PROJECT_ENVIRONMENT = ".venv";
            };
          };
        });
    };
}
