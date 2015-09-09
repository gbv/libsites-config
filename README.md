# libsites-config

Dieses git-Repository enthält Konfigurationsdateien zur GBV-Standortverwaltung.
Weitere Informationen gibt es im Unterverzeichnis `doc/` bzw. auf der Seite
<http://www.gbv.de/wikis/cls/Standortverwaltung> im GBV-Wiki.

Das Repository ist öffentlich unter <https://github.com/gbv/libsites-config>
einsehbar. Änderungen an der Konfiguration können durch einen
[Pull-Request](https://help.github.com/articles/using-pull-requests) angemeldet
werden. Alle Inhalte werden als Public Domain (CC-Zero) freigegeben.

## Technischer Hintergrund

> Die folgenden Ausführungen sind nicht mehr aktuell!

Der master-branch des Repository wird durch aufruf von `make test` automatisch
unter <http://travis-ci.org> auf syntaktische Korrektheit getestet. Die zum
Testen notwendigen Perl-Module lassen sich mit `make deps` installieren. Zur
Konvertierung einzelner Konfigurationsdateien (`sites.txt`) kann das Skript
`bin/sites` folgendermaßen verwendet werden (Option `-v` für zusätzliche
Ausgabe):

    ./bin/sites -v DE-Hil3

Das Skript `bin/getzdb` dient zum Herunterladen und Konvertieren von Angaben 
aus dem ZDB-ISIL/Sigelverzeichnis.

Die Dokumentation steht in der Datei `doc/libsites-config.md`. Mit `make docs`
lassen sich HTML- und PDF-Version sowie eine MediaWiki-Variante zum Speichern
unter <http://www.gbv.de/wikis/cls/Konfiguration_der_GBV-Standortverwaltung>
erstellen.

Das Skript `bin/update` testet, ob das Repository aktualisiert wurde und
aktualisiert in diesem Fall die RDF-Daten.

## Status

[![Build Status](https://travis-ci.org/gbv/libsites-config.png?branch=master)](https://travis-ci.org/gbv/libsites-config)
[![CC Zero](http://i.creativecommons.org/p/mark/1.0/80x15.png)](http://creativecommons.org/publicdomain/mark/1.0/)
