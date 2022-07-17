import SwiftUI


struct ContentView: View {
    
    @State private var axEnhancedUserInterfaceValue: String = "N/A"
    @State private var axManualAccessibilityValue: String = "N/A"
    
    private static var timer: Timer?
    private static var delay = 2 
    
    var body: some View {
        HStack {
            VStack {
                Text("AXEnhancedUserInterface")
                    .font(.title)
                Button("GET") {
                    Self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                        getAXEnhancedUserInterfaceAttribute()
                    })
                }
                Button("SET") {
                    Self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                        setAXEnhancedUserInterfaceAttribute()
                    })
                }
                Divider()
                Text(axEnhancedUserInterfaceValue)
            }
            Spacer()
            VStack {
                Text("AXManualAccessibility")
                    .font(.title)
                Button("GET") {
                    Self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                        getAXManualAccessibilityAttribute()
                    })
                }
                Button("SET") {
                    Self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                        setAXManualAccessibilityAttribute()
                    })
                }
                Divider()
                Text(axManualAccessibilityValue)
            }
        }
        .padding()
        Spacer()
    }
    
    
    private func axFrontmostApplicationPID() -> pid_t? {
        let axSystemWideElement = AXUIElementCreateSystemWide()
        
        var axApplication: AnyObject?
        guard AXUIElementCopyAttributeValue(axSystemWideElement, kAXFocusedApplicationAttribute as CFString, &axApplication) == .success else { return nil }

        var pid: pid_t = -1
        AXUIElementGetPid(axApplication as! AXUIElement, &pid)
        
        return pid == -1 ? nil : pid
    }
        
    
    private func getAXEnhancedUserInterfaceAttribute() {
        guard let pid = axFrontmostApplicationPID() else { 
            axEnhancedUserInterfaceValue = "failed to get app PID"
                    
            return
        }
        
        let axApplicationElement = AXUIElementCreateApplication(pid)

        var axAXEnhancedUserInterface: AnyObject?
        guard AXUIElementCopyAttributeValue(axApplicationElement, "AXEnhancedUserInterface" as CFString, &axAXEnhancedUserInterface) == .success else {
            axEnhancedUserInterfaceValue = "failed to get AXEnhancedUserInterface status"
            
            return
        }
                
        axEnhancedUserInterfaceValue = String(axAXEnhancedUserInterface as! Bool)
    }

    private func setAXEnhancedUserInterfaceAttribute() {
        guard let pid = axFrontmostApplicationPID() else { 
            axEnhancedUserInterfaceValue = "failed to get app PID"
                    
            return
        }
                
        let axApplicationElement = AXUIElementCreateApplication(pid)
        guard AXUIElementSetAttributeValue(axApplicationElement, "AXEnhancedUserInterface" as CFString, true as CFTypeRef) == .success else {
            axEnhancedUserInterfaceValue = "failed to set AXEnhancedUserInterface"
            
            return
        }
                
        axEnhancedUserInterfaceValue = "AXEnhancedUserInterface set"
    }

    private func getAXManualAccessibilityAttribute() {
        guard let pid = axFrontmostApplicationPID() else { 
            axManualAccessibilityValue = "failed to get app PID"
                    
            return
        }
        
        let axApplicationElement = AXUIElementCreateApplication(pid)

        var axAXManualAccessibility: AnyObject?
        guard AXUIElementCopyAttributeValue(axApplicationElement, "AXManualAccessibility" as CFString, &axAXManualAccessibility) == .success else {
            axManualAccessibilityValue = "failed to get AXManualAccessibility status"
            
            return
        }
                
        axManualAccessibilityValue = String(axAXManualAccessibility as! Bool)
    }

    private func setAXManualAccessibilityAttribute() {
        guard let pid = axFrontmostApplicationPID() else { 
            axManualAccessibilityValue = "failed to get app PID"
                    
            return
        }
                
        let axApplicationElement = AXUIElementCreateApplication(pid)
        guard AXUIElementSetAttributeValue(axApplicationElement, "AXManualAccessibility" as CFString, true as CFTypeRef) == .success else {
            axManualAccessibilityValue = "failed to set AXManualAccessibility"
            
            return
        }
                
        axManualAccessibilityValue = "AXManualAccessibility set"
    }

}
