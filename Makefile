### Vimmortal 2k14 gros!

help:
	@echo "General"
	@echo "======="
	@echo "help........................: shows this help"
	@echo "install.....................: installs vimmortal"

# VARS #

VIMRC_PATH=$(HOME)/.vimrc
VIM_DIR=$(HOME)/.vim
BUNDLE_DIR=$(VIM_DIR)/bundle

# RULES #

install: build-bundle-dir install-neobundle paste-config all-done

build-bundle-dir:
	@echo "building $(BUNDLE_DIR)..."
	@if [ -d $(BUNDLE_DIR) ]; then \
		echo "old bundle/ dir renamed to bundle.backup/" ; \
		mv -f $(BUNDLE_DIR) $(BUNDLE_DIR).backup ; \
	fi
	@mkdir -p $(BUNDLE_DIR)

install-neobundle:
	@echo "installing NeoBundle..."
	git clone https://github.com/Shougo/neobundle.vim $(BUNDLE_DIR)/neobundle.vim

paste-config:
	@echo "pasting vim conf..."
	@if [ -f $(VIMRC_PATH) ]; then \
		echo "old .vimrc file renamed to .vimrc.backup" ; \
		mv -f $(VIMRC_PATH) $(VIMRC_PATH).backup ; \
	fi
	@cp -f ./.vimrc $(VIMRC_PATH)
	@if [ -d $(VIM_DIR) ]; then \
		echo "old .vim/ file renamed to .vim.backup/" ; \
		mv -f $(VIM_DIR) $(VIM_DIR).backup ; \
	fi
	@cp -rf ./.vim $(VIM_DIR)

all-done:
	@echo "all done"
	@echo "plugins will be installed next time you start vim (PRESS YES!)"
