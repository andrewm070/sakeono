# Sake Ono Data Prototype

This repository contains a minimal example of how Sake Ono can combine
qualitative sales visit notes with distributor depletion data. The goal is
to give a quick view of which accounts are performing well and what
activity is happening with the sales team.

## Layout

```
./data/               Sample CSV files for accounts, depletions and visits
./src/analyze.py      Script that loads the CSVs into a SQLite database
                      and prints a simple report
```

## Running the example

1. Ensure you have Python 3 installed (no external packages are required).
2. Execute:

```
python3 src/analyze.py
```

This will create a local `sakeono.db` SQLite database, load the data from
`data/` and output a summary similar to:

```
Top accounts by cases sold:
Sushi Place               Flagship 22 cases
Craft Cocktail Bar        Tier1   11 cases
...
```

The script demonstrates a simple approach to aggregating sales metrics and
listing recent salesperson activity.

In a real deployment, the CSV files could be replaced with automated exports
from VIP or another data source, and the database could be extended with more
analytics.

## iOS App Prototype

A simple SwiftUI prototype is included in `ios/SakeOnoApp`. Open this folder in Xcode 15 or later and run the `SakeOnoApp` scheme to try the demo app. It shows a list of sample accounts, their total cases sold, and allows entering new sales visit notes.
