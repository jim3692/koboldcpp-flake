{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      repoName = "lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF";
      fileName = "Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf";
    in {
      apps.${system}.default = let
        run = pkgs.writeShellApplication {
          name = "run";
          text = with pkgs; ''
            findModel() {
              find ~/.cache/huggingface -name "${fileName}" | head -n1
            }

            if [ "$(findModel)" == "" ]; then
              ${python312Packages.huggingface-hub}/bin/huggingface-cli download "${repoName}" "${fileName}"
            fi

            modelPath="$(findModel)"
            echo "Found ${fileName} at $modelPath"
            AMD_VULKAN_ICD=AMDVLK ${koboldcpp}/bin/koboldcpp --usevulkan --model "$modelPath" --gpulayers 100
          '';
        };
      in {
        type = "app";
        program = "${run}/bin/run";
      };
    };
}

