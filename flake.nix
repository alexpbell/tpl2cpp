{
  description = "tpl2cpp";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    
    packages.x86_64-linux.default = 
      
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation {

        name = "tpl2cpp";
        src = pkgs.fetchFromGitHub {
          owner = "admb-project";
          repo = "admb";
          rev = "admb-13.2";
          sha256 = "z7S3MqT6TQH8GW5VImCzmBnk+7XQmHeEN7ocmBHGUqg=";
        };

        buildInputs = [ pkgs.flex ];

        buildPhase = ''
          flex src/nh99/tpl2cpp.lex
          sed -f src/nh99/sedflex lex.yy.c > tpl2cpp.c
          gcc tpl2cpp.c -o tpl2cpp
        '';
      
        installPhase = ''
          mkdir -p $out/bin
          install -t $out/bin tpl2cpp
        '';
      };

  };

}
