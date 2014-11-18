SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

.PHONY: info test-isil test-code

info:
	@echo "make deps - installiert benötigte Perl-Module zur Konvertierung."
	@echo "make sites - konvertiert alle sites.txt nach RDF."
	@echo "make test -  überprüft alle Dateien auf syntaktische Korrektheit."
	@echo "make dirs - erstellt Verzeichniss für alle Einrichtungen in isil.csv."
	@echo "make zdb - läd und Konvertiert RDF-Daten des Sigelverzeichnis."
	@echo "make dump - Erstell aus allen RDF-Daten in einen Dump."
	@echo "make docs - erstellt die Dokumentation im Verzeichnis doc/."
	@echo "make clean - löscht alle Dateien, die nicht unter Versionskontrolle stehen."

# Abhängigkeiten installieren
deps:
	@cpanm --installdeps .
	@if ! hash rapper 2>/dev/null;\
	   then echo "missing 'rapper', install raptor-utils!";\
	   exit 1;\
	fi

# Konvertierung aller sites.txt
sites:
	@ls isil/*/sites.txt | xargs ./bin/sites
	@./bin/siteof

# ZDB
zdb:
	@ls isil | xargs ./bin/getzdb

# Tests
test: test-code test-isil test-sites

test-isil:
	@cat isil.csv | perl -ne \
		'die "invalid ISIL in isil.csv: $$_" unless /^[A-Z]{1,3}-[A-Za-z0-9\/:-]{1,10}$$/'
	@echo isil.csv - OK

test-sites: sites
	@ls isil | perl -ne \
		'die "invalid ISIL directory: $$_" unless /^[A-Z]{1,3}-[A-Za-z0-9_:-]{1,10}$$/'

test-code:
	@prove -Ilib t

# ISIL-Verzeichnisse
dirs: test-isil
	@cd isil && xargs mkdir -v -p < ../isil.csv

# Dump aller Tripel
dump: libsites.ttl
libsites.ttl:
	@find isil -regextype sed -regex ".*\.\(ttl\|nt\)$$" | bin/dump > $@

# Dokumentation
docs:
	@cd doc && make html pdf wiki

gbvwiki: docs
	@./bin/mediawiki-upload
	
# Aufräumen
clean:
	@git clean -xdf -e mediawiki.json
