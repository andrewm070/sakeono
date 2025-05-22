import Foundation

enum SampleData {
    static let accounts: [Account] = [
        Account(id: 1, name: "Sushi Place", type: "Flagship", category: "on", casesSold: 22,
                visits: [
                    SalesVisit(date: Date(timeIntervalSince1970: 1714521600), salesperson: "Jane", notes: "Discussed new cocktail menu"),
                    SalesVisit(date: Date(timeIntervalSince1970: 1714867200), salesperson: "Jane", notes: "Training staff on sake service")
                ]),
        Account(id: 2, name: "Craft Cocktail Bar", type: "Tier1", category: "on", casesSold: 11,
                visits: [
                    SalesVisit(date: Date(timeIntervalSince1970: 1714694400), salesperson: "Bob", notes: "Sake pairing dinner planned")
                ]),
        Account(id: 3, name: "Downtown Liquor", type: "Tier2", category: "off", casesSold: 3,
                visits: [
                    SalesVisit(date: Date(timeIntervalSince1970: 1715020800), salesperson: "Alice", notes: "Interested in small bottle sizes")
                ]),
        Account(id: 4, name: "Neighborhood Bistro", type: "Other", category: "on", casesSold: 3)
    ]
}
