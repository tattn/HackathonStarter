
if ! type brew > /dev/null 2>&1; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! type carthage > /dev/null 2>&1; then
	brew install carthage
fi

if ! type swiftlint > /dev/null 2>&1; then
	brew install swiftlint
fi

bundle install

