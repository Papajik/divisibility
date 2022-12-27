import 'package:divisibility_calculator/widgets/formula_card.dart';
import 'package:flutter/material.dart';

class ManualScreen extends StatefulWidget {
  const ManualScreen({Key? key}) : super(key: key);

  @override
  State<ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FormulaCard(
          children: [
            Text('Pozorování'),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "1. Po dělení číslem x zbude zbytek z množiny {0, 1 ... x-1}"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "2. Dělím-li Y číslem X a zbude Z, potom pří dělení 10Y číslem X zbude 10Z"),
            ),
          ],
        ),
        FormulaCard(
          children: [
            Text('Cyklus'),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "1. Postupným dělením dostatečně velkého čísla Y číslem X můžeme dostat různé zbytky z množiny {0, 1 ... x-1}"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "2. Je-li po dělení Y číslem X zbytek 0, pak po dělení 10Y "
                  "číslem X zbude 0. Jakmile vyjde zbytek 0, další cifry již nepřispívají"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "3a. Postupným dělením Y číslem X dojdeme buď do '0' a tím cyklus končí"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("NEBO"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "3b. Vyhneme se '0', potom má cyklus nejvýše x-1 členů a existuje cyklus"),
            ),
          ],
        ),
        FormulaCard(
          children: [
            Text('Návod'),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "Vstupní data - dělitel se zapisuje v desítkové soustavě"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "Po zadání dat se zobrazí obecná rovnice a vypočtená rovnice pro ověření dělitelnosti"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "Přes tlačítko 'Zobrazit výpočet' je možné vidět způsob tvorby výsledné rovnice"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "Pro zadané hodnoty systému a dělitele lze pak ověřovat dělitelnost jakéhokoliv čísla. "
                      "Dělitelnost je ověřována pomocí získané rovnice."),
            ),
          ],
        ),
        FormulaCard(
          children: [
            Text('Grafické znázornění cyklu'),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "Při děliteli menším než 25 je možné zobrazit grafické znázornění cyklu"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "Modře jsou označeny zbytky, které je možné při dělení získat"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "Šedou jsou označeny zbytky, které není možné získat"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "Zeleně je označen zbytek, ve kterém došlo k zacyklení"),
            ),
          ],
        )
      ],
    );
  }
}
