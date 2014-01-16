Dieses git-Repository enthält Konfigurationsdateien zur **Definition von
Standorten** von Bibliotheken und verwandten Einrichtungen. 

Weitere Informationen siehe unter
<http://www.gbv.de/wikis/cls/Standortverwaltung>.

### Anlegen und Ändern von Standorten und Standortbeschreibungen

Zur Einrichtung im Standortverzeichnis muss

* entweder eine Datei mit dem Namen `sites.txt` im Unterverzeichnis mit dem
  ISIL der Einrichtung existieren,

* oder der ISIL in der Datei `isil.csv` aufgeführt sein (für
  Einrichtungen ohne weitere Standorte außer dem Hauptgebäude).

Mit `make dirs` werden für die in `isil.csv` aufgeführten Einrichtungen
Unterverzeichnisse angelegt, falls noch nicht vorhanden.

`make clean` löscht alle Dateien, die nicht unter Versionskontrolle stehen.
