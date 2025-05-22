import SwiftUI

struct AddVisitView: View {
    @EnvironmentObject var store: AccountStore
    var accountID: Int
    @Environment(\.dismiss) private var dismiss

    @State private var date = Date()
    @State private var salesperson = ""
    @State private var notes = ""

    var body: some View {
        Form {
            DatePicker("Date", selection: $date, displayedComponents: .date)
            TextField("Salesperson", text: $salesperson)
            TextField("Notes", text: $notes)
        }
        .navigationTitle("New Visit")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { save() }
            }
        }
    }

    private func save() {
        guard let index = store.accounts.firstIndex(where: { $0.id == accountID }) else { return }
        let visit = SalesVisit(date: date, salesperson: salesperson, notes: notes)
        store.accounts[index].visits.append(visit)
        dismiss()
    }
}

struct AddVisitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddVisitView(accountID: 1)
                .environmentObject(AccountStore())
        }
    }
}
