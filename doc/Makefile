TITLE   = Konfiguration der GBV-Standortverwaltung
AUTHOR  = Jakob Voß (VZG)
NAME    = libsites-config
VERSION = 0.8

LANGUAGE=ngerman
include vzgspec/Makefile

wiki:
	@echo '{{GBV-Standortverwaltung:Kopfzeile}}' > $(NAME).wiki
	@$(PANDOC) $(NAME).md -t mediawiki -o $(NAME).wiki
