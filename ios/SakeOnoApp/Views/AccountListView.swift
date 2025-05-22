import SwiftUI

struct AccountListView: View {
    @EnvironmentObject var store: AccountStore

    var body: some View {
        NavigationView {
            List(store.accounts) { account in
                NavigationLink(destination: AccountDetailView(accountID: account.id)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(account.name)
                                .font(.headline)
                            Text(account.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("\(account.casesSold) cases")
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("Accounts")
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView()
            .environmentObject(AccountStore())
    }
}
