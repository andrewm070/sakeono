import SwiftUI

struct AccountDetailView: View {
    @EnvironmentObject var store: AccountStore
    var accountID: Int

    var body: some View {
        VStack(alignment: .leading) {
            if let index = store.accounts.firstIndex(where: { $0.id == accountID }) {
                let account = store.accounts[index]
                Text(account.name)
                    .font(.largeTitle)
                Text("Type: \(account.type)")
                Text("Category: \(account.category)")
                Text("Total cases sold: \(account.casesSold)")
                    .padding(.bottom)

                List {
                    ForEach(account.visits) { visit in
                        VStack(alignment: .leading) {
                            Text(visit.date, style: .date)
                                .font(.headline)
                            Text("Salesperson: \(visit.salesperson)")
                                .font(.subheadline)
                            Text(visit.notes)
                        }
                    }
                }

                NavigationLink("Add Visit") {
                    AddVisitView(accountID: account.id)
                }
                .padding()
            } else {
                Text("Account not found")
            }
        }
        .navigationTitle("Details")
        .padding()
    }
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailView(accountID: 1)
            .environmentObject(AccountStore())
    }
}
