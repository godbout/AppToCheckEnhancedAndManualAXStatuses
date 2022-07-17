import SwiftUI


class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        if AXIsProcessTrusted() == false {
            let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
            
            AXIsProcessTrustedWithOptions(options)
        }
    }
        
}
