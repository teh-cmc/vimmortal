### Vimmortal 2k14 gros!

help:
	@echo "General"
	@echo "======="
	@echo "help.....................,,,: shows this help"
	@echo "install.....................: installs vimmortal"

# VARS #

VIM_DIR=$(HOME)/.vim
BUNDLE_DIR=$(VIM_DIR)/bundle

# RULES #

install: build-bundle-dir install-neobundle paste-config all-done

build-bundle-dir:
	@echo "building $(BUNDLE_DIR)..."
	@if [ ! -d $(BUNDLE_DIR) ]; then \
		mkdir -p $(BUNDLE_DIR) ; \
	fi

install-neobundle:
	@echo "installing NeoBundle..."
	git clone https://github.com/Shougo/neobundle.vim $(BUNDLE_DIR)/neobundle.vim

paste-config:
	@echo "pasting vim conf..."
	@if [ ! -f $(HOME)/.vimrc ]; then \
		@echo "old .vimrc file renamed to .vimrc,backup" ; \
		mv $(HOME)/.vimrc $(HOME)/.vimrc.backup ; \
	fi
	cp -f ./.vimrc $(HOME)/.vimrc

all-done:
	@echo "all done"
	@echo "plugins will be installed next time you start vim (PRESS YES!)"
