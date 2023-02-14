#
# Makefile for GitHub Site Builder
#

CONFIG := config
LOG := log

default: rebuild

CRONTAB := crontab
PWD := $(shell pwd)

rebuild::
	./rebuild "$(PWD)/$(LOG)"

# Lock down the config file and add the crontab
install::
	chmod 600 "$(CONFIG)"
	(crontab -l 2>/dev/null || true) > "$(CRONTAB)"
	. ./$(CONFIG) && sed -i -e "/^#BEGIN-builder-$${NAME}$$/,/^#END-$${NAME}$$/d" "$(CRONTAB)"
	. ./$(CONFIG) && echo "#BEGIN-builder-$${NAME}" >> "$(CRONTAB)"
	echo "# Installed $$(date)" >> "$(CRONTAB)"
	printf "0 1,5,9,13,17,21 * * * %s/rebuild '%s'\n" "$(PWD)" "$(PWD)/$(LOG)" >> "$(CRONTAB)"
	. ./$(CONFIG) && echo "#END-builder-$${NAME}" >> "$(CRONTAB)"
	crontab "$(CRONTAB)"
	rm -f "$(CRONTAB)"
TO_CLEAN += $(CRONTAB) $(LOG)


# Remove the crontab
uninstall::
	(crontab -l 2>/dev/null || cat /dev/null) \
	| (. ./$(CONFIG) && sed -e "/^#BEGIN-builder-$${NAME}$$/,/^#END-$${NAME}$$/d") \
	| crontab -


clean:
	rm -rf $(TO_CLEAN) *~
