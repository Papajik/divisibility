import 'package:divisibility_calculator/widgets/formula_card.dart';
import 'package:flutter/material.dart';

class ManualScreen extends StatefulWidget {
  const ManualScreen({Key? key}) : super(key: key);

  @override
  State<ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen> {
  final _cycle = [
    "1. Vydělíme číslo Y číslem X. Dostaneme zbytek N z množiny {0, 1 ... X-1}",
    "2. Přířadíme Y = N*Z",
    "Mohou nastat následující situace: ",
    " 3a. Dostaneme zbytek '0'. Cyklus není a výpočet končí.",
    " 3b. Vyhneme se '0', ",
    "    Pokud jsme již stejný zbytek dostali, objevili jsme cyklus, Výpočet končí. ",
    "    V opačném případě pokračujeme znovu krokem 1. ",
  ];

  final _graph = [
    "Při děliteli menším než 25 je možné zobrazit grafické znázornění cyklu",
    "Modře jsou označeny zbytky, které je možné při dělení získat",
    "Šedou jsou označeny zbytky, které není možné získat",
    "Zeleně je označen zbytek, ve kterém došlo k zacyklení",
    "První krok v nalezeném postupu je vyznačen oranžově, ostatní jsou čerené"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const FormulaCard(
            children: [
              Text(
                'Pozorování',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                    "1. Po dělení číslem X zbude zbytek z množiny {0, 1 ... X-1}"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                    "2. Dělím-li Y číslem X a zbude Z, potom pří dělení 10Y číslem X zbude 10Z"),
              ),
            ],
          ),
          FormulaCard(children: [
            const Text(
              "Cyklus dělitelnosti číslem X v Z-soustavě",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ..._cycle
                .map((e) => Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(e),
                    ))
                .toList()
          ]),
          const FormulaCard(
            children: [
              Text(
                'Návod',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
              const Text(
                'Grafické znázornění cyklu',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ..._graph
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(e),
                      ))
                  .toList(),
            ],
          )
        ],
      ),
    );
  }
}
