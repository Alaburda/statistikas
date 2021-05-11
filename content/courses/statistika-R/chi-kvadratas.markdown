---
title: 'Chi-kvadrato ir Fisher tikslus testai'
linkTitle: Chi-kvadrato ir Fisher tikslus testai
date: "2021-05-11"
menu:
  lesson:
    parent: Statistiniai testai
    weight: 1
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---

## Kada naudoti Chi-kvadrato testą?

Chi-kvadrato testas yra skirtas įvertinti, ar yra asociacija tarp dviejų kategorinių kintamųjų. Asociaciją vertiname pagal tai, kokia tikimybė gauti stebimus dažnius duomenyse, jeigu laikome, jog tarp kintamųjų asociacijos nėra. Žmogiškais terminais mes lyginame du scenarijus:

`\(H_0\)`: kintamieji yra nepriklausomi ir sąsajos tarp kategorinių kintamųjų nėra.
`\(H_1\)`: kintamieji yra susiję tarpusavyje. Žinodami vieno kintamojo vertę galime nuspėti kito kintamojo vertę.

Chi-kvadrato testas priima arba atmeta nulinę hipotezę lygindamas esamus dažnius su teoriniais dažniais, kurių tikėtumėmės. Chi-kvadrato testas grąžina dvi reikšmes: `\(\chi^2\)` reikšmę ir atitinkamą p reikšmę, kuri nusako `\(\chi^2\)` reikšmės vietą `\(\chi^2\)` skirstinyje. Geriausia įsitikinti, kaip tai veikia su pavyzdžiu.

### Duomenys

Naudosime `iris` duomenų rinkinį. Iš jo susikursime naują kategorinį kintamąjį `dydis`, kuris suskirsto taurėlapius į didelius ir mažus pagal tai, ar jie didesni ar mažesni už medianą. Atliksime Chi-kvadrato testą tikrinti asociaciją tarp taurėlapių dydžio ir augalo rūšies.


```r
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 4.0.5
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
data <- iris %>% 
  mutate(dydis = case_when(Sepal.Length < median(Sepal.Length) ~ "Maži",
                          Sepal.Length >= median(Sepal.Length) ~ "Dideli"))
```

Prieš nerdami į patį statistinį testą, gera praktika yra pavaizduoti turimus duomenis. Kintamųjų dažnius galime patikrinti suformuodami dažnių lentelę:


```r
table(data$dydis,data$Species)
```

```
##         
##          setosa versicolor virginica
##   Dideli      1         29        47
##   Maži       49         21         3
```

Taip pat su `ggplot2` paketu galime duomenis pavaizduoti grafiškai:


```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 4.0.5
```

```r
ggplot(data) +
  aes(x = Species, fill = dydis) +
  geom_bar(position = "fill") + 
  labs(x = "Augalo rūšis",
       y = "Augalų dalis")
```

<img src="/courses/statistika-R/chi-kvadratas_files/figure-html/unnamed-chunk-3-1.png" width="672" />

Grafike ant x ašies matome augalo rūšį, o ant y ašies matome, kokia dalis matuotų augalų turėjo didelius arba mažus taurėlapius. 

Kai matome, jog viskas yra gerai su duomenimis, galime atlikti Chi-kvadrato testą. Chi-kvadratui reikia pateikti tokią pačią dažnių lentelę, kokią kūrėme prieš tai:


```r
chisq.test(table(data$dydis,data$Species))
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  table(data$dydis, data$Species)
## X-squared = 86.035, df = 2, p-value < 2.2e-16
```

Galime prabėgti gautus rezultatus:

* X-squared yra Chi-kvadrato reikšmė
* df yra laisvės laipsnių skaičius
* p-value yra mūsų reikšmė

Tinkamas būdas raportuoti duomenis būtų toks:

Atlikus Chi-kvadrato testą, sąsaja tarp taurėlapių dydžio ir augalo rūšies buvo statistiškai reikšminga ($\chi^2$(2) = 86,035, p < 0,001). Maži taurėlapiai buvo susiję su `setosa` rūšimi, o dideli taurėlapiai su `virginica` rūšimi.

p reikšmę mes raportuojame kaip mažesnę negu 0,001 dėl sutartinių normų - laisvai galėtume rašyti tokį patį rezultatą, kokį grąžina `chisq.test()` funkcija, bet tai nebūtų informatyvu. Svarbiausia nerašyti, jog p = 0,00!

## Kada nenaudoti Chi-kvadrato testo?

Kai vienas iš tikėtinų dažnių yra mažesnis negu 5, rekomenduojama arba sutraukti kelias grupes į vieną grupę, arba naudoti Fisher tikslų testą. Fisher tikslus testas po savimi neturi jokio statistinio testo savaime - jis apskaičiuoja tikimybę gauti tokius dažnius, kokius matome. Dėl to atlikdami testą su `fisher.test` komanda gauname tik p reikšmę:


```r
fisher.test(table(data$dydis,data$Species))
```

```
## 
## 	Fisher's Exact Test for Count Data
## 
## data:  table(data$dydis, data$Species)
## p-value < 2.2e-16
## alternative hypothesis: two.sided
```

Taip pat svarbu, jog Chi-kvadrato testas laikosi prielaidos, jog stebėjimai tarpusavyje nėra susiję. Nesunkiai prielaidą galima pažeisti atliekant odontologinį tyrimį. Pavyzdžiui, renkame informaciją apie sugedusius dantis ir tiriame sąsają tarp sugedusių dantų skaičiaus ir danties tipo. Jeigu įtraukiame po kelis dantis iš kiekvieno paciento, mes įtraukiame matavimus, kurie savaime jau yra susiję. Jeigu netyčia įtrauksime pacientą, kuriam sugedo daugiau negu 1 dantis, pažeistume testo prielaidą ir galimai gautume neteisingą rezultatą.
