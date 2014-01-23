TITLE   = Konfiguration der GBV-Standortverwaltung
AUTHOR  = Jakob Voß (VZG)
NAME    = libsites-config
VERSION = 0.8

LANGUAGE=ngerman
include vzgspec/Makefile

wiki: $(NAME).wiki

$(NAME).wiki: $(NAME).md
	@$(PANDOC) $< -t mediawiki -o $@
