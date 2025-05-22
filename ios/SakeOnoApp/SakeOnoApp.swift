import SwiftUI

@main
struct SakeOnoApp: App {
    @StateObject private var store = AccountStore()
    var body: some Scene {
        WindowGroup {
            AccountListView()
                .environmentObject(store)
        }
    }
}
