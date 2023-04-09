//
//  MyPanel.swift
//  Neko-Swift
//
//  Created by Lonnie Gerol on 4/7/23.
//

import AppKit

class NekoPanelController: NSWindowController {
    
    @IBOutlet weak var nekoPanel: NekoPanel!
    
    private var stateMachine = NekoStateMachine()
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.handleWindowStateChangeNotification(_:)),
            name: NekoNotifications.windowStateDidChangeNotification,
            object: nil
        )
        
        stateMachine.delegate = self
        stateMachine.resume()
    }
    
    @objc private func handleWindowStateChangeNotification(_ notification: NSNotification) {
        guard let state = notification.userInfo?["state"] as? NekoWindowState else { return }
        switch state {
        case .visible:
            stateMachine.resume()
            showWindow(nekoPanel)
        case .hidden:
            stateMachine.pause()
            nekoPanel.close()
        }
    }
    
}

extension NekoPanelController: NekoStateMachineDelegate {
    func update(sprite: NSImage) {
        guard let vc = nekoPanel.contentViewController as? NekoViewController else { return }
        vc.update(image: sprite)
        nekoPanel.invalidateShadow()
    }
    
    func getCursorNekoLocation() -> (NSPoint, NSPoint) {
        let mousePoint = NSEvent.mouseLocation
        return (mousePoint, nekoPanel.frame.origin)
    }
    
    func newNeko(pos: CGPoint) {
        nekoPanel.setFrameOrigin(pos)
    }
    
    
}

class NekoPanel: NSPanel {
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        
        super.init(contentRect: contentRect, styleMask: NSWindow.StyleMask.borderless, backing: backingStoreType, defer: flag)
        self.becomesKeyOnlyIfNeeded = true
        self.level = .statusBar
        self.canHide = false
        self.backgroundColor = .clear
        self.isMovableByWindowBackground = false
        self.ignoresMouseEvents = true
        self.setFrame(NSRect(x: 0, y: 0, width: 32, height: 32), display: false)
        self.center()
    }
    
}
