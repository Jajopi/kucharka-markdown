# Identified issues

Found using LLM, false positives are slowly being manually removed.
Some of the points show contradiction between obsolete information, they should be updated with current facts instead.
Few of the points come from the LLM misunderstanding the text, they might need be corrected as this can also happen to non-native speakers.
Points from E and F are mostly style and wording issues which do not need to be fixed.

How to read the items: text in straight quotes `"…"` is an **exact phrase** from the
files (you can search for it), `→ *…*` is a suggested correction (not in the files).
Line numbers may differ after some edits have been done.

## A. Contradictions inside the guidebook (both languages)

1. **Door locking** – `cs/4.md:19` "které se na noc (0:30 – 6:00) mají zavírat", "Budova A bývá ale otevřená" `en/4.md:21` "if it would be locked during the night"; vs. `cs/12.md:23` "Od roku 2025 se skleněné vstupní dveře zamykají pořád", `en/12.md:23` "is locked all day". → Update chapter 4 to match chapter 12.
2. **Lab A printer** – `cs/5.md:81` "ze které už neumíme tisknout", `en/5.md:81` "we cannot print there"; vs. `cs/6.md:95` "Tiskárna v labu A ale už má kabel a přes něj lze tisknout", `en/6.md:97` "there is a cable, which works". → Decide which is true, sync both.
3. **Jinonice account** – `cs/5.md:81` "která ale přestala fungovat na jaře 2024"; vs. `cs/6.md:97` "Je potřeba mít účet JINONICE", `en/6.md:99` "You need to have a JINONICE account", and `cs/14.md:23` "na doméně Jinonice", `en/14.md:23` "on the Jinonice domain". → Verify, update.
4. **Music room price** – `cs/D.md:13` "| Hudební zkušebna | Vrátnice A | Zdarma oproti průkazu |", `en/D.md:13` "| Music rehearsal room | Reception A | Free of charge with pass |"; vs. `cs/5.md:85` "Za 400 Kč na semestr (případně 700 Kč na rok)". → *Oproti průkazu (400 Kč / semestr, 700 Kč / rok)*
5. **Gym price** – `cs/D.md:16` "| Posilovna | Vrátnice A, B | Zdarma oproti průkazu |", `en/D.md:16` "| Gym | Receptions A, B | Free of charge with pass |"; vs. `cs/8.md:23` "která stojí 200 Kč na 6 měsíců, případně 350 Kč na rok", `en/8.md:23` "which costs CZK 200 for six months". → Same as 4.
6. **Ball pump** – `cs/8.md:7` "Rovněž si můžete zapůjčit pumpičku na míče či kolo", `en/8.md:7` "You can also borrow a pump for balls or a bike" (the paragraph is about reception B); vs. `cs/D.md:24` "| Pumpa na míče | Vrátnice A | Zdarma |" and the reception B list `cs/6.md:53` "pumpu na kolo, sportovní vybavení" (no ball pump). EN also reads as "borrow a bike" → *a pump for balls or bikes*
7. **Keys at reception B** – `cs/5.md:65` "klíče se dají půjčit na vrátnici B oproti kolejence" (study room B) and `cs/5.md:49` "s několika druhy míčků, které půjčují na vrátnici B" (foosball); both missing in the reception B lists `cs/6.md:53` / `cs/6.md:55` "Půjčuje klíče od malé klubovny, velké klubovny, ekumenické místnosti" (same in `en/6.md:51–53`).
8. **Drying rooms** – "If you have borrowed a laundry room" → *drying room*
9. **"průkaz" vs. "kolejenka"** – appendix D: `cs/D.md:13` "Zdarma oproti průkazu"; chapter 5: `cs/5.md:65` "oproti kolejence". Unify.
10. **Smoking places** – `cs/13.md:7` "který je aktuálně zavřený", "je mimo provoz", yet "Obě místa jsou označena cedulemi povolujícími kouření"; `en/13.md:7` "which is currently closed", "it is out of service", "Both places are marked with signs" – effectively nowhere to smoke. Verify the current state.
11. **Prohibition vs. "clean up"** – `cs/5.md:75` "Zdůrazňujeme zákaz požívání alkoholu, i jídla apod., případně si to po sobě alespoň pořádně ukliďte"; `en/5.md:75` "If you decide to do that anyway, at least don’t be a jerk and clean up after yourself properly". Clarify whether food is allowed.
12. **Pillow** – `en/4.md:31` "you will then receive linens, sheets, and a blanket" … "You don’t need to buy a pillow and a blanket"; `cs/4.md:25` "dostanete prostěradlo, povlečení a deku" – no pillow is handed out, yet EN says you don't need to buy one.
13. **Psychotherapist heading** – `cs/6.md:89` "## Psychoterapeutka", `en/6.md:91` "## Psychotherapist"; the text describes `cs/6.md:91` "Fakultní koordinátorka poradenských služeb Veronika Jonáková", `en/6.md:93` "Faculty Counselling Services Coordinator". Verify the heading and the name (changing the heading changes its `#id`; only the TOC links to it).

## B. Czech vs. English differ in facts

14. **Bus at Povltavská** – `cs/2.md:21` "kam jezdí autobus 112 nebo 243"; `en/2.md:23` "where buses 112 and 234 run", "buses (112, 187, 234 etc.)". One is a typo – check the PID timetable.
15. **Phone book link** – `en/2.md:63` "[Dormitory Council’s website](https://fb.com/groups/koleje/)" points to Facebook → *https://listopad.koleje.cuni.cz/dokumenty/telefonni-seznam.pdf* (as in CS: `cs/2.md:59` "telefonni-seznam.pdf").
16. **Service desk** – `en/7.md:19` "send an e-mail to the [service desk](mailto:servicedesk.cuni.cz)" is a broken link (no @) → *contact the [service desk](https://servicedesk.cuni.cz)* (as in CS).
17. **UVT tutorial** – `en/7.md:9` "Tutorial can be found on the [^2]https://uvt.cuni.cz/UVTEN-60.html." → *A tutorial can be found on the [ÚVT website](https://uvt.cuni.cz/UVTEN-60.html)[^2].* The footnotes also differ: `en/7.md:21` "Charles University Computer Centre" vs. `en/7.md:22` "website of Computer Science Center".
18. **Drama club contact** – `cs/9.md:25` "<https://fhs.cuni.cz/FHS-3295.html#13>" vs. `en/9.md:25` "<v.blumentritova@seznam.cz>". Sync.
19. **Rokoska restaurant** – `cs/10.md:115` "### Čína na Rokosce", `cs/10.md:117` "klasická čínská restaurace" vs. `en/10.md:113` "### Family restaurant of Vietnamese and Thai food at Rokoska", `en/10.md:115` "is a classic Asian restaurant". Verify and sync.
20. **Altenburg boat** – `cs/10.md:123` "máme jeden takový naproti přes řeku" vs. `en/10.md:121` "can be found on the Vltava river during the summer right next to our dorms".
21. **Big clubroom signature** – `cs/5.md:21` "za příslušným členem Kolejní rady" … "nebo za vedoucí koleje" vs. `en/5.md:21` "to the head of the dormitory (preferred) or to the respective member of the Dormitory Council" – the preference is reversed.
22. **Lamp deposit** – `cs/3.md:41` "za panem Holubem, u kterého si za zálohu asi 200 Kč" vs. `en/3.md:41` "Mrs. Jana Provazníková) for a returnable deposit of CZK 200" – different person and "asi" missing in EN.
23. **Top-up place** – `en/10.md:41` "at housekeepers" vs. `cs/10.md:41` "na poštovně" → *at the dormitory post office*. Also `cs/10.md:41` "Otevřena je jenom v pracovní dny" vs. `en/10.md:41` "open only on school days".
24. **Accommodation scholarship** – `cs/14.md:23` "na které má nárok každý student UK, který nemá trvalé bydliště v Praze" vs. `en/14.md:23` "almost every CU student studying in Czech". EN is probably more accurate → fix CS.

## C. Content missing in one language

25. `en/1.md:7` "*Dormitory Council’s email newsletters*! How" – the sentence is cut off (as in the original PDF); the instructions (fill in e-mail → Subscribe / register, check spam) are missing.
26. `cs/1.md:13` "srecepty.cz/recepty/fridge" – the recipes paragraph has no EN version.
27. `cs/2.md:15` "boje[^1]", `cs/2.md:72` "Zatímco nacisté krutě a bezcitně trestali" – this footnote is missing in EN.
28. `cs/2.md:17` "[zaniklé usedlosti](https://cs.wikipedia.org/wiki/Pelc-Tyrolka)" – the link is missing in EN (`en/2.md:17` "a vanished homestead").
29. `cs/2.md:41` "Pošli to AlzaBoxem" … "v testovacím provozu za 49" – missing in EN; in CS probably outdated anyway.
30. `cs/3.md:37` "komiksu MaFian liFe od Daniela Scheiricha" – the paragraph is missing in EN.
31. `cs/4.md:21` "Zde zaplatíte také rovnou cca 7 000 Kč v hotovosti" and "Případně ho lze poslat i emailem" – missing in EN (`en/4.md:23–25`).
32. `cs/4.md:45` "V případě odjezdu na Erasmus se prý dá ubytování „pozastavit“" – missing in EN.
33. `cs/4.md:19` "Budova A bývá ale otevřená, tak to kdyžtak můžete vzít i tunelem" – missing in EN (see also 1).
34. `cs/10.md:121` "dvě hotelová (veřejně přístupná) wellness centra" – missing in EN.
35. `cs/12.md:35` "směrem na východ od budovy A" and "Nikde jinde na ploše není povoleno dlouhodobě parkovat" – missing in EN.
36. EN-only content (fine, just FYI): `en/1.md:5` "thanks to CU Point"; `en/2.md:29` "Pubtran app"; `en/6.md:87` "## Housing assistant"; `en/12.md:53` "[our leaflet]"; `en/4.md:3` "As a foreign student"; `en/4.md:5` "**3 working days**".

## D. Probably outdated (verify)

37. `cs/10.md:9` "a brzy (říjen?) snad i ovoce", `en/10.md:9` "soon (October?) hopefully even fruit" – a temporary note.
38. `cs/8.md:45` "během etapy B stavby FHS", `cs/13.md:7` "do provedení etapy B stavby FHS".
39. Time-relative statements: `cs/2.md:3` "před pár lety přestavěla"; `cs/2.md:41` "nově od roku 2024"; `cs/4.md:11` "Doufáme ale, že se snad už brzy dočkáme"; `cs/6.md:95` "Bývala tu Robocopy, za kterou se snad brzy dočkáme náhrady".
40. Prices/times to verify: `cs/3.md:11` "pouze 104", "necelých 1200 Kč"; `cs/4.md:7` "levnější o 7 Kč/den"; `cs/5.md:85` "Za 400 Kč na semestr"; `cs/6.md:19–23` "23 Kč / cyklus", "2 dny zdarma, potom 20 Kč / den", "5 Kč / 30 min"; `cs/6.md:97` "Knihovna je otevřena ve všední dny od 9:00 do 19:00"; `cs/12.md:45` "prvních 15 minut jízdy zdarma"; `cs/2.md:21` "nejezdí o víkendu kromě nedělního odpoledne a večera"; `en/10.md:93` "until half past twelve and from about half past four", "is open non-stop in Letňany"; `en/10.md:85` "Norma"; `en/8.md:25` "the power supply is broken".
41. People: `cs/5.md:93` "Magdaléně Gabániové"; `cs/6.md:91` "Veronika Jonáková"; `cs/11.md:33` "Mgr. Jana Provazníková"; `cs/11.md:37` "Paní Vojáčková", "paní Gregorová".
42. `cs/10.md:29` "com.filtermac.app", "apps.apple.com/be/app/filtermac" – the Lokni app links still point to Filtermac (App Store region "be"); `cs/12.md:17` "or_13_2011___ubytovaci_rad" – accommodation rules from 2011.
43. `cs/C.md:21` "| úterý | 7:30 – 11:00 |" vs. `cs/C.md:22` "| čtvrtek | 8:00 – 11:00 |" – intended?

## E. Czech – unclear sentences and style

44. `cs/10.md:95` "přejdete ulici a nejbližším vchodem do OC, kterým projdete drže se vlevo" → *přejdete ulici, vejdete nejbližším vchodem do OC a projdete jím, držte se vlevo*
45. `cs/10.md:87` "nebo č. 6 na *Dělnickou* a kousek dojdete a vydáte se první ulicí doprava" → *nebo č. 6 na Dělnickou, odkud dojdete první ulicí doprava…*
46. `cs/10.md:105` "odnesete si ho do jedné z místností, nebo je tam i diskotéka" → *…místností; je tam i diskotéka*
47. `cs/12.md:89` "Nebo si od Kolejní rady půjčit gril" → *Nebo si od Kolejní rady půjčte gril*
48. `cs/12.md:39` "je možné také využít taktéž" → *je možné využít také*
49. `cs/12.md:15` "má nárok na jedno přespání měsíčně zdarma" – item 3 of the list is a note, not a step.
50. `cs/2.md:21` "U ní akorát pozor" (refers to the tram, grammatically to the stop) → *U tramvaje akorát pozor*
51. `cs/2.md:35` "Případně prosím napište na kolejní" → *Pokud k omylu přesto dojde, napište na kolejní*
52. `cs/2.md:37` "budete muset na poštu na adrese" → *budete si pro něj muset zajít na poštu na adrese*
53. `cs/2.md:47` "nabízí i vrácení e-shopu" → *nabízí i vrácení zboží do e-shopu*
54. `cs/3.md:3` "Co by kamenem dohodil od oblasti Holešovice." – an incomplete sentence; "kopírující břeh Vltavy, který je zas ideální na procházky" – unclear what is ideal for walks.
55. `cs/5.md:25` "tak musíte (ideálně osobně, s papírovým formulářem) za vedoucí koleje" → *musíte zajít…*; `cs/5.md:27` "přibližná kapacita místnosti je asi 40 lidí" → drop *asi*; `cs/5.md:65` "Studovna většinou bývá neustále otevřená" → *Studovna bývá většinou otevřená*
56. `cs/7.md:3` "můžete se o ni pokusit" → *o něj*; "co nastavíte na Eduroam viz níže" → *(viz níže)*; `cs/7.md:5` "opět máte dvě možnosti" – "opět" has nothing to refer to.
57. `cs/7.md:17` heading "## Zařízení neschopné možností výše" → *Zařízení, která se nepřipojí výše uvedenými způsoby* (no links point to it).
58. `cs/9.md:13` "[e-mailové konference]", "[této konference]", "[přidat také]" – three links to the same URL in one paragraph; `cs/9.md:21` "Na koleji je skupinka křesťanů" … "či organizují" – singular/plural mix; "čas a termín skupinek" – duplicate.
59. `cs/4.md:35` "hospodářka pokoj zamkne" (the paragraph starts with "Hospodyně:") → *hospodyně*
60. Minor style:
    - `cs/3.md:23` "což se občasně stane" → *což se občas stává*
    - `cs/5.md:97` "stůl s třemi židlemi" → *se třemi*
    - `cs/6.md:77` "ale i sluch svůj a ubytovaných pod vámi" → *i svůj sluch a sluch sousedů pod vámi*
    - `cs/8.md:45` "v pondělky večer" → *v pondělí večer*
    - `cs/8.md:93` "Pokud si s nimi chceš zahrát" – the frisbee section uses "ty" instead of "vy"
    - `cs/9.md:39` "spojující ty, jež milují" → *ty, kteří milují*
    - `cs/10.md:65` "asiatského krámku" → *asijského*
    - `cs/10.md:85` "Používáno převážně studenty" → *Používána*
    - `cs/10.md:99` "se stávají čím dál populárnější služby" → *populárnějšími*
    - `cs/10.md:113` "ceny drahé" → *ceny vysoké*
    - `cs/D.md:39` "je circa 200 Kč" → *cca*
61. Consistency of names:
    - "Pelc Tyrolka" (`cs/2.md:21`, `en/2.md:21`) vs. "Pelc-Tyrolka" (`cs/2.md:17`)
    - `cs/2.md:13` "Sametovou revoluci", "z Východního bloku" → *sametovou revoluci*, *východního bloku*
    - `cs/7.md:3` "podobné jako pro Eduroam" vs. `cs/7.md:9` "přístup k síti eduroam"
    - `cs/4.md:21` "poslat i emailem" → *e-mailem*
    - `cs/D.md:28` "| REkrabička |" vs. `cs/10.md:37` "[Rekrabičky]"; `en/D.md:28` "| REkrabička |" vs. `en/10.md:37` "[“Rekrabička”]"
    - `cs/10.md:99` "[*Bolt Foods*]", `en/10.md:97` "[*Bolt Foods*]" → *Bolt Food*
    - `cs/6.md:99` "*Průša MK4*" → *Original Prusa MK4*
    - `cs/10.md:81` "na Kobylisích", `cs/10.md:95` "na Letňanech" → *v Kobylisích*, *v Letňanech*
    - `cs/5.md:25` "za Velkou klubovnu"; `cs/5.md:63` "kde je Studovna, Ekumenická místnost a Kancelář vedoucí" – capitals
    - `cs/2.md:63` "| vrátnice A | 1211 |" – lower case in the phone table
62. `cs/2.md:72` "odmítal povolit postup americké armády na Prahu" – simplified (it was an agreed demarcation line).
63. `cs/3.md:37` "scheirich/?page%20id=67" – probably should be *?page_id=67* (check that the link works).

## F. English – wording and translation

64. `en/B.md:3` "## Groud floor, building A", `en/B.md:7` "## Groud floor, building B" → *Ground floor* (no links point to them – safe).
65. `en/10.md:61` heading "### A Small grocery shop in Holešovice" → *A small grocery shop in Holešovice*
66. `en/2.md:29` "[iOS3]" → *[iOS]* (as printed in the original).
67. `en/3.md:3`:
    - "Most Barikadníků" → *Most Barikádníků*
    - "which follows the bank of the Vltava River, which is ideal for walking" – ambiguous (the tunnel is ideal for walking?)
    - "A stone’s throw away is a wide expressway" – CS says something else: `cs/3.md:3` "Co by kamenem dohodil od oblasti Holešovice"
68. `en/2.md:9` "and look a little different" – CS `cs/2.md:9` "a vypadat trochu jako koleje na Jižním městě" (look a bit like the Jižní Město dorms).
69. `en/1.md:5` "It was usually written in Czech" → *It was originally written in Czech*
70. `en/2.md:13`:
    - "(“velvet” comes from no violence)" → *(called “velvet” because it was non-violent)*
    - "(today’s Russia)" → *(the USSR)*
    - "a violently suppressed demonstration against the Nazi storming of Charles University" – historically imprecise
71. `en/2.md` other wording:
    - :15 "managed to relatively liberate Prague" → *largely liberate*; "which helped to final liberation" → *contributed to the final liberation*
    - :17 "and after by Tyrall" → *and later by Tyrall*
    - :21 "it runs in a very limited schedule" → *on a limited schedule*; "Since September 2021, the stop is located" → *has been located*
    - :23 "you don’t find the tram 17 stop" → *won’t find*
    - :27 "go to the stop from the dormitory along the newly reconstructed sidewalk straight and then to the left" → *from the dormitory, walk straight along the sidewalk and then turn left to the stop*
    - :39 "you need to unlock them" → *unlock your box*; "you have mail of someone else" → *someone else’s mail*
    - :41 "you must go for it to the post office" → *collect it at the post office*
    - :45 "Fortunately, since 2024, we now have" → *Since 2024, we have had*
    - :51 "write the return number on it" vs. "enter your claim number" – the same number?
    - :53 "it has the two nearest branches located near" → *its two nearest branches are near*
    - :63 "`*20502` (or `*20501`) for the phone in cell `B501`/`502`" – order of the codes vs. rooms
72. `en/3.md`:
    - :19 "arrange with the people who are to move in after you" → *make arrangements with the people moving in after you*
    - :27 "discuss with the other roommates" → *cellmates?*
    - :33 "It is therefore more than recommended" → *strongly recommended*
    - :37 "pay a visit to “Hospodyně = Housekeeper”" → *visit the housekeeper (“Hospodyně”)*
    - :41 "From the edge of time" → *Since time immemorial*; "After a revision of electronic devices" → *After an inspection of electrical appliances*
73. `en/4.md`:
    - :3 "OR better yet" → *Or better yet*; "ask your ERASMUS coordinator" vs. "from your Erasmus office"
    - :5 "in advance!!!" – shouting style
    - :11 "living in a dormitory during a year" → *during the year*; "it’s best to arrange the contract at the accommodation office before signing" – hard to follow
    - :15 "to select in a pretty good way", "out of dormitories regulation", "long time ago promised" → *long-promised*; reservations said to be run by the Council, then by the accommodation office
    - :21 "if it would be locked during the night" → *if it is locked at night*
    - :25 "pay for the whole October and part of September" – assumes an autumn arrival
    - :27 "Check the inventory according to the list hanging on the door if all equipment is indeed there" → *Check against the inventory list on the door that all equipment is there*
    - :29 "stand in the queue" – no queue mentioned before
    - :33 "stuck to the entrance room door" → *the entrance door of the cell*
    - :57 "you need to end the contract on 11" … "May at the latest" → *give notice by 11th May*
74. `en/5.md`:
    - :15 "How to rent out the room:" → *How to book the room:*
    - :17, :37 "and find a free term" → *a free slot*
    - :25 "for the Big Clubroom" – capitalisation
    - :49 "From June 2023, there is" → *Since June 2023, there has been*
    - :53 "On the contrary, the disadvantage" → *On the other hand*
    - :63 "through a narrow hallway with a door, and to the left of the twin lifts" – hard to follow
    - :79 "there was a computer laboratory ever since" → *there had been*
    - :85 "in the back of the aerobic room" → *aerobics room*
    - :93 "arrange room exchange with the other borrower" → *arrange a handover*; "the people who come here to exercise" → *to practise*
    - :97 "(Return it the same day!)" → *Return them* (the keys)
    - :99 "Return whatever you borrow asap" → *as soon as possible*
75. `en/6.md`:
    - :5 "It is no longer needed to pay a visit" → *It is no longer necessary to visit*
    - :7 "you enter a number of any washing machine" → *the number of any*
    - :11 "starting it from a computer browser" – unclear logic
    - :33 "without you present in it" → *without you being present*; "the reasoning for an entrance" → *the reason for entering*
    - :67 "reported in the books of defects" → *book of defects*
    - :89 "as she/he can assist you" → *as they can assist you*
    - :97 "There was Robocopy, and we are looking forward to replacement in near future" – unclear/outdated; "when you bring papers" → *paper*
    - :99 "at the rental desk" → *circulation desk*; "JINONICE" vs. "Jinonice"
    - :109 "Please return it in as clean (or cleaner) condition" → *in the same (or cleaner) condition as you received it*
    - :111 "a drill screwdriver" → *a cordless drill*
    - :113 "In case of laundry washed a long time ago" → *If someone’s finished laundry has been left in the machine for a long time*
76. `en/7.md`:
    - :3 "the 17. Listopadu Dormitory" → *17. listopadu*
    - :5 "you again have two options" – "again" has nothing to refer to
77. `en/8.md`:
    - :15 "right behind ping-pong" → *the ping-pong room*; "The room has horizontal bars" → *a horizontal bar?*
    - :33 "(for the deposit CZK 200)" → *for a deposit of CZK 200*
    - :37 "In every case" → *In any case*
    - :49 "A suitable diversion are kayakers in the Troja channel" → *Watching the kayakers on the Troja canal is a nice diversion*; "the underground passage" → *the underpass*
    - :51 "all the way to Prague-Řež" → *Řež near Prague*
    - :61 "be careful of the opening hours" → *check the opening hours*
    - :71 "there is a modern laser tag arena with lots of game modes since 2022" → *since 2022, there has been…*; "movement game" → *active game*
    - :75 "The *TJ Sokol Troja* section" → *club*; "dockyard" → *boathouse*
    - :89 "around 10 mins close to" → *around 10 minutes away, close to*
    - :93 "in the grassland west of the dormitories" – the organisers from CS `cs/8.md:93` "Lidi z korespondenčních seminářů" are missing
78. `en/9.md`:
    - :13 "[e-mail conference]", "[join this conference]" → *mailing list* (same link twice); the opening "However, information" is misplaced; "it is happening very irregularly" – not in CS
    - :17 "in the Small clubroom" → *small clubroom*
    - :29 "blend a little bit more with" → *blend in a little more with*
    - :31 "Usually, the walks were happening" → *The walks usually take place*
    - :35 "It is happening so far quite irregularly" → *So far, it has been quite irregular*
    - :39 "reach a new potential" → *reach its potential*; "please send a PM to" (an e-mail link) → *send an e-mail to*
79. `en/10.md`:
    - :5 "[automatized 24/7 shop]" → *automated*
    - :19 "Matfyz’ *Pěkný číslo*" → *Matfyz’s*; "half-liter" vs. :29 "three litres" – US/UK spelling
    - :35 "for a fraction of the price on the market" → *for a fraction of the market price*
    - :37 "hygiene forbid to use own box" → *hygiene regulations forbid using your own box*
    - :43 "For each meal, in addition to the ordered meals" → *For each dish, in addition to the pre-ordered portions*
    - :47 "comfortable) sitting indoors" → *seating indoors*
    - :59 "there is complex [Port7]" → *there is the Port7 complex*
    - :83 "Used mainly by students from Malá Strana" → *It is used mainly by…*
    - :107 "right on the Troja Channel" vs. "Troja channel" elsewhere → *Troja canal*
    - :111 "the prices are expensive" → *the prices are high*
    - :115 "with traditional prices" → *at typical prices*
    - :123 "what sounds like an apocalyptic concert rather than cooking of your neighbour" → *your neighbour’s cooking, which sounds more like an apocalyptic concert*
80. `en/11.md`:
    - :15 "We administer managers of bike and luggage rooms." → *We coordinate the administrators of the bike and luggage rooms.*
    - :19 "We enforced better service of the bus 187." → *We pushed for better service on bus 187.*
    - :37 "## Accommodation assistants" – easily confused with "Housing assistant" (chapter 6)
    - :47 "to see if the recipient is not in the dormitory, and if they are not" → *to check whether the recipient happens to be in, and if not*
81. `en/12.md`:
    - :13 "for CZK 50, you can pick up clean bed linens" – at the accommodation office? (linen is otherwise handled by the laundry storage room)
    - :19 "Overnight visitors who do not sleep in a roommate’s bed do not exist under current regulations" → *Under current regulations, an overnight visitor may only sleep in a resident’s bed*
    - :29 "However, it is necessary to lock your door" – nothing to contrast with
    - :31 "(more than CZK 2000)" vs. `en/9.md:7` "over 1,000 books" – number formatting
    - :37 "The reserving of the parking spot takes CZK 300 per month" → *Reserving a parking spot costs CZK 300 per month*; "needs to be ringed in using a bell at the gate" → *you need to ring the bell at the gate*
    - :45 "both companies offer twice a day the first 15 minutes free of charge" → *offer the first 15 minutes free twice a day*; "to the Matfyz buildings on Troja" → *in Troja*; "compared to *Rekola’s* 1" → *one*
    - :55 "is for free" → *is free*
    - :57, :91 "just south of the college" → *dormitory*
    - :59 "can be thrown out to the small white boxes" → *put into the small white boxes*
    - :69 "on one bulletin board" vs. "## Noticeboards"; "lifts" vs. "elevators" (:59, :75)
    - :81 "Part of the drying rooms" → *Some of the drying rooms*
    - :95 "Also parties from boat Altenburg or other places can disturb" → *Parties on the boat Altenburg 1964 or elsewhere can also disturb you*
82. `en/13.md:7` "at the exit of building A which is currently closed" – ambiguous (is the exit or the smoking place closed?).
83. `en/14.md`:
    - :6 "You can also write us at" → *write to us at*
    - :44 "Including a page about the dormitory" – a fragment → *It includes a page about the dormitory*
84. `en/D.md:35` "the good will of woman in the storage room" → *the goodwill of the ladies in the storage room*
85. `en/metadata.yaml:13` "The guidebook has also a web version" → *The guidebook also has a web version*
86. Terminology to unify in EN:
    - "email newsletters" (`en/1.md:7`) vs. "e-mail" elsewhere
    - "Dormitory council" (`en/1.md:9`, `en/3.md:45`) vs. "Dormitory Council"
    - "at the receptions" (`en/2.md:61`) vs. "reception desk"
    - "Vltava river" vs. "Vltava River" (`en/3.md:3`)
    - "in Annexes" (`en/5.md:5`) vs. appendices
