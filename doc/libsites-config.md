# Übersicht
 
Unter <http://uri.gbv.de/organization/> werden Informationen zu Standorten von
Bibliotheken, Museen und verwandten Einrichtungen zusammengeführt und als
Linked Open Data zur Verfügung gestellt. Grundlage sind der *International
Standard Identifier for Libraries and Related Organizations* (ISIL) und Angaben
aus den jeweiligen ISIL-Verzeichnissen. Darüber hinaus können mit der
GBV-Standortverwaltung unterhalb der Ebene von ISIL-Einträgen weitere Standorte
(im Folgenden "Departments") wie z.B.  Teilbibliotheken, Außenmagazine,
Handapparate etc. konfiguriert werden.

## Inhalte der Konfiguration

Die Konfiguration der GBV-Standortverwaltung besteht aus:

* Einer Liste von ISIL aller Einrichtungen des GBV-Standortverzeichnis **in der
  Datei `isil.csv`**.

* Informationen zu Departments einzelner Einrichtungen **in der Datei
  `sites.txt`** im Unterverzeichnis `isil/XXXX/`, wobei `XXXX` für den ISIL
  der jeweiligen Einrichtung steht.

Zu den einzelnen Departments sind in `sites.txt` folgende Angaben möglich:

* Standortkürzel oder ISIL (notwendige Angabe)
* Name
* Öffnungszeiten
* Addresse
* Kurzbeschreibung oder Hinweis
* Mailadresse
* Telefonnummer
* Homepage
* Geokoordinaten 

Die genaue Syntax ist am Besten den [vorhandenen
Konfigurationen](https://github.com/gbv/libsites-config/tree/master/isil) und
[Beispielen](#beispiele) zu entnehmen.

Allee Inhalte stehen als Open Data ([CC Zero]) zur freien Verfügung.

[CC Zero]: http://creativecommons.org/publicdomain/zero/1.0/deed.de

## Verwaltung der Konfiguration

Die Konfiguration der GBV-Standortverwaltung ist in einem öffentlichen
git-Repository unter unter <https://github.com/gbv/libsites-config> einsehbar.
Änderungen an der Konfiguration sind ausschließlich durch Anlegen bzw.
Bearbeitung der jeweiligen Konfigurationsdateien (`isil.csv`, `sites.txt`)
möglich. Änderungen lassen sich am besten per Pull-Request am Repository auf
GitHub anmelden. 

Zum Überprüfen der syntaktischen Korrektheit enthält das
Repository Test-Routinen, die mit `make test` aufgerufen werden können.  

# Konfiguration

## Hauptstandort

Jede Einrichtung im GBV-Standortverzeichnis muss durch einen ISIL
identifizierbar sein. Sofern noch kein ISIL vorhanden ist, muss zunächst bei
der entsprechenden ISIL-Stelle ein Eintrag beantragt werden. Der ISIL
identifiziert gleichzeitg den *Hauptstandort* der Einrichtung
(Department-Kürzel "@"). Nähere Informationen zum Hauptstandort (Name, Adresse,
Telefonnummer etc.) sollten nicht in *sites.txt* eingetragen werden, da sie
automatisch aus dem ISIL-Verzeichnis übernommen werden.

## Weitere Departments

Neben dem Hauptstandort können der Einrichtung in `sites.txt` weitere Departments 
zugeordnet werden. Dabei lassen sich zwei Fälle unterscheiden:

* **Unselbständige Departments** die genau einer Einrichtung untergeordnet sind. 
   Diese Standorte werden durch ein frei wählbares alphanumerisches Kürzel
   (Kleinbuchstaben, Ziffern, Unterstrich) im Zusammenhang mit dem ISIL der 
   übergeordneten Einrichtung identifiziert, wobei dem Kürzel das Zeichen 
   '`@`' vorangestellt wird. Beispielsweise hat die AZP-Bibliothek der UB Hildesheim
   das Kürzel [DE-Hil2@azp].

* **Selbstständige Departments** die ihrerseits Einrichtungen mit eigener ISIL sind.
   Beispielsweise ist die Bibliothek im Kurt-Schwitters-Forum ([ISIL DE-960-3])
   ein Standort der Bibliothek der Hochschule Hannover ([ISIL DE-960]). 

Aus ISIL und Kürzel ergibt sich für jedes Department eine URI zur eindeutigen
Referenzierug des Standortes, beispielsweise
<http://uri.gbv.de/organization/isil/DE-Hil2@azp>.

[DE-Hil2@azp]: http://uri.gbv.de/organization/isil/DE-Hil2@azp
[ISIL DE-960]: http://uri.gbv.de/organization/isil/DE-960
[ISIL DE-960-3]: http://uri.gbv.de/organization/isil/DE-960-3

Über die GBV-Standortverwaltung hinaus können Anwendungen weitere
Unterteilungen von Standorten vornehmen. So in der Konfiguration der *Document
Availability Information API* (DAIA) neben dem Feld "department" das
Freitextfeld "storage" für lokale Angaben wie "Lesesaal", "Lehrbuchsammlung",
"Etage 3", oder "Magazin" vorgesehen. So lassen sich Standorte weiter
differenzieren ohne ihre Anzahl in der GBV-Standortkonfiguration unnötig
aufzublähen. Ob und ab welcher Granularität eigene Departments konfiguriert
werden, liegt im eigenen Ermessen der jeweiligen Einrichtung. Als Faustregel
kann gelten, dass ein Department über eine gewisse Eigenständigkeit wie 
eigene Adresse und Öffnungszeiten verfügen sollte.

## Siehe auch

* [ISIL- und Sigelverzeichnis]
* [lobid-organisations]

[ISIL- und Sigelverzeichnis]: http://zdb-opac.de/DB=1.2/
[lobid-organisations]: http://lobid.org/organisation

# Beispiel

Im einfachsten Fall gibt es neben dem Hauptstandort keine weiteren Departments
(dann reicht ein Eintrag in `isil.csv`) oder alle Standorte verfügen über einen
eigenen ISIL. Für die HAWK ([ISIL DE-Hil3]) sieht die gesamte Konfiguration in
`sites.txt` beispielsweise folgendermaßen aus:

    ISIL DE-Hil3-1
    ISIL DE-Hil3-2
    ISIL DE-Hil3-3
    ISIL DE-Hil3-4
    ISIL DE-Hil3-9
  
Die UB Hildesheim ([ISIl DE-Hil2]) hat dagegen neben dem Hauptstandort drei
Departments:

 Kürzel   Name                URI
-------- ------------------- ---------------------------------------------------
  @       UB Hildesheim       <http://uri.gbv.de/organization/isil/DE-Hil2>
  @ami    AMI-Medienzentrum   <http://uri.gbv.de/organization/isil/DE-Hil2@ami>
  @azp    AZP-Bibliothek      <http://uri.gbv.de/organization/isil/DE-Hil2@azp>
  @hand   Handapparat         <http://uri.gbv.de/organization/isil/DE-Hil2@hand>

Zur Konfiguration werden die Departments der Reihe nach aufgeführt. Folgender
Abschnitt in [isil/DE-Hil2/sites.txt] definiert beispielsweise das
"AMI-Medienzentrum" mit der URI
<http://uri.gbv.de/organization/isil/DE-Hil2@ami>:

    @ami
    AMI-Medienzentrum
    Raum G009
    Marienburger Platz 22
    31141 Hildesheim

    +49 05121 883740

    amimz@uni-hildesheim.de

    52.1341,9.976481

    Di,Do 9:30-12:30, 14:00-16:00, Mi 14:00-16:00

Diese Angaben werden nach RDF übersetzt unter <http://uri.gbv.de/organization/>
zur Verfügung gestellt und bilden die Grundlage für weitere Anwendungen. 

[isil/DE-Hil2/sites.txt]: https://github.com/gbv/libsites-config/blob/master/isil/DE-Hil2/sites.txt

[ISIL DE-Hil2]: http://uri.gbv.de/organization/isil/DE-Hil2
[ISIL DE-Hil3]: http://uri.gbv.de/organization/isil/DE-Hil3
