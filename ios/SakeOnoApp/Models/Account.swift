import Foundation

struct SalesVisit: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var salesperson: String
    var notes: String
}

struct Account: Identifiable, Codable {
    var id: Int
    var name: String
    var type: String
    var category: String
    var casesSold: Int
    var visits: [SalesVisit] = []
}

class AccountStore: ObservableObject {
    @Published var accounts: [Account] = SampleData.accounts
}
