DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if ! [ -x "$(command -v brew)" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Terminal
if ! [ -x "$(command -v zsh)" ]; then
  brew install zsh
  brew cask install iterm2
  chsh -s /bin/zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  mkdir -p ~/terminal
  cd ~/terminal
  curl -O https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Dracula.itermcolors

  echo ". $DIR/.zshrc-cjamcl" >> ~/.zshrc

  cd ~
fi

# https://superuser.com/questions/71588/how-to-syntax-highlight-via-less
brew install highlight

# Node
if ! [ -x "$(command -v nvm)" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
fi

if ! [ -x "$(command -v yarn)" ]; then
  brew install yarn
fi

yarn global add bundle-buddy

# Python

if ! [ -x "$(command -v pip)" ]; then
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python get-pip.py --user
fi

# Code
if ! [ -x "$(command -v code)" ]; then
  brew install visual-studio-code
fi
cp vscode-settings.json ~/Library/"Application Support"/Code/User/settings.json
