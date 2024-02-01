# 42Initializer 🚀

Welcome to 42Initializer!
This script automates the installation of crucial tools and programs used in the 42 common core.
It's here to help new students begin their journey or to provide moral support after the deletion of your session.

## Features:
- [**Create SSH Key**](https://download.asperasoft.com/download/docs/sync2/3.5.1/admin_osx/webhelp/dita/creating_public_key_cmd.html)

- [**Oh My Zsh**](https://ohmyz.sh/)
  
- **[Homebrew Without Sudo](https://www.scivision.dev/macos-homebrew-non-sudo/)**

- **[CMake](https://formulae.brew.sh/formula/cmake), [GLFW](https://formulae.brew.sh/formula/glfw), and [Valgrind](https://github.com/LouisBrunner/valgrind-macos)**

- **Alias to Open Vscode (code .)**

- **[Cleaner_42](https://github.com/ombhd/Cleaner_42)**

- **[NCDU](https://dev.yorhel.nl/ncdu)** (Alternative to CCleaner, need to uncomment to use)

## Getting Started

1. Clone this repository to your 42 School computer.

    ```bash
    git clone https://github.com/Jalevesq/42Initializer
    ```

2. Navigate to the 42Initializer directory.

    ```bash
    cd 42Initializer
    ```

3. Run the script and let the magic happen!

    ```bash
    ./42Initializer.sh
    ```
    If your present working directory ($PWD) is not $HOME, the program will prompt you with two menu options:

    - **Home Directory:** Choose this option if you want to move to $HOME before downloading dependencies.
    
    - **Current Directory:** Choose this option if you want to stay in your directory to download. **Note: This may cause issues.**

    <img src="https://github.com/Jalevesq/42Initializer/assets/103976653/3ebc4e4e-566f-425e-a80c-6c3563f22738" alt="42Initializer Menu" width="400"/>

4. Install what you need.
    For each program, you will be prompted to choose whether you want to download it or not.

    <img width="400" alt="Screenshot 2023-11-18 at 7 04 39 PM" src="https://github.com/Jalevesq/42Initializer/assets/103976653/bd82c968-6a23-497e-885d-344ed5c16c67">

## Contribution Guidelines

Contributions are welcome! If you find a way to magically create more space on 42 School computers so we don't have to delete everything each month, or if you have other improvements, feel free to open an issue or submit a pull request.

## Disclaimer

This toolkit is not responsible for any magical creatures that may appear during installation. Use at your own risk.

## Acknowledgements

A big shoutout to 42 School for inspiring this toolkit. Remember, when in doubt, add more color codes to your terminal.
