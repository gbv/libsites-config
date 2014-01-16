Dieses git-Repository enthält Konfigurationsdateien zur **Definition von
Standorten** von Bibliotheken und verwandten Einrichtungen. 

Weitere Informationen siehe unter
<http://www.gbv.de/wikis/cls/Standortverwaltung>.

### Anlegen und Ändern von Standorten und Standortbeschreibungen

Für jede Einrichtung gibt es ein Verzeichnis, dessen Namen dem ISIL der
Einrichtung entspricht. Die Konfiguration befindet sich in der Datei
`sites.txt`. 

Zusätzlich können in der Datei `isil.csv` im Wurzelverzeichnis ISIL von
Einrichtungen aufgeführt werden, für die bislang keine Standorte eingerichtet
sind. Mit `make dirs` werden für diese Einrichtungen die fehlenden
Unterverzeichnisse angelegt.

`make clean` löscht alle Dateien, die nicht unter Versionskontrolle stehen.
