import SwiftUI


@main
struct AppToCheckEnhancedAndManualAXStatusesApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
