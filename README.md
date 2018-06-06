Bing Dork Scanner (BDScan.exe)

## Introduction

Bing Dork Scanner
 is meant to assist the Bing search engine for sqli's 
## Requirements
```
BDScan.exe
dorks_found.txt
dorks_found_sqli.txt
```
## Usage


```
BDScan.exe <DORK> <Pages to crawl>
```
**For example:**
```
BDScan.exe instreamset:url:details.php?nr= 15
```

## Example Output
```
C:\Users\Bustd\Desktop\bing dork scanner>BDScan.exe instreamset:url:user.php?uid= 5
----------------------------------------

        Bing Dork Scanner by Bustd86

----------------------------------------

    [!]  Suche nach Dork: instreamset:url:user.php?uid=
    [!]  Durchsuche 5 Seiten auf Bing

----------------------------------------

    [+]  Durchsuche Seite 1 von 5
    [!]  10  URLs gefunden...

    [+]  Durchsuche Seite 2 von 5
    [!]  14  URLs gefunden...

    [+]  Durchsuche Seite 3 von 5
    [!]  15  URLs gefunden...

    [+]  Durchsuche Seite 4 von 5
    [!]  19  URLs gefunden...

    [+]  Durchsuche Seite 5 von 5
    [!]  19  URLs gefunden...


----------------------------------------


     Getting Unique URLs with Params


-----------------Results----------------

[1]     http://www.luke54.org/user.php?uid=277
[2]     http://music.weibo.com/snake/snk_user.php?uid=1335693500
[3]     http://www.forgotten.pl/user.php?uid=albinaadamska78
[!]     Possible SQLi:  http://www.forgotten.pl/user.php?uid=albinaadamska78
[4]     http://ota-fair.jp/k22/syutten/user.php?uid=945
[5]     http://ota-fair.jp/k22/syutten/user.php?uid=891
[6]     http://www.allegro.pl/show_user.php?uid=72904
[7]     http://www.luke54.org/user.php?uid=7857
[8]     http://big5.51job.com/gate/big5/bbs.51job.com/user.php?uid=1167774
[9]     http://www.game24.co.kr/user.php?uid=5118
[10]    http://www.forgotten.pl/user.php?uid=ludmitawalczak8
[!]     Possible SQLi:  http://www.forgotten.pl/user.php?uid=ludmitawalczak8
[11]    http://www.ls1howto.com/transferuser.php?uid=tr
[!]     Possible SQLi:  http://www.ls1howto.com/transferuser.php?uid=tr

----------------------------------------

Ergebnise gespeichert nach: C:\Users\Bustd\Desktop\bing dork scanner\dorks_found.txt
```
