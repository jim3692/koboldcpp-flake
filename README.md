# KoboldCpp Vulkan Flake

Run `nix run github:jim3692/koboldcpp-flake`

It downloads [Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf](https://huggingface.co/lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF) using `huggingface-cli`, if it doesn't already exist in `~/.cache/huggingface`, and then starts KoboldCpp in Vulkan mode.
