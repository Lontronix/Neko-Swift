//
//  AppDelegate.swift
//  Neko-Swift
//
//  Created by Lonnie Gerol on 4/7/23.
//

import Cocoa

enum NekoWindowState {
    case visible
    case hidden
    
    var title: String {
        switch self {
        case .visible:
            return "Hide Neko"
        case .hidden:
            return "Show Neko"
        }
    }
    
    var icon: NSImage {
        switch self {
        case .visible:
            return NekoImages.jareImages[1]
        case .hidden:
            return NekoImages.sleepImages[0]
        }
    }
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem?
    @IBOutlet weak var statusMenu: NSMenu!
    
    @IBOutlet weak var toggleNekoMenuItem: NSMenuItem!
    
    var currentWindowState: NekoWindowState = .visible {
        didSet {
            toggleNekoMenuItem.title = currentWindowState.title
            statusItem?.button?.image = currentWindowState.icon
            configureStatusItem()
            
            if currentWindowState == .hidden {
                print("hiding window...")
            }
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        toggleNekoMenuItem.title = currentWindowState.title
        configureStatusItem()
    }

    @IBAction func toggleNekoMenuItemClicked(_ sender: NSMenuItem) {
        switch currentWindowState {
        case .visible:
            currentWindowState = .hidden
        case .hidden:
            currentWindowState = .visible
        }
        
        let notificationName = NekoNotifications.windowStateDidChangeNotification
        NotificationCenter.default.post(
            name: notificationName,
            object: nil,
            userInfo: [ "state": currentWindowState ]
        )
    }
    
    private func configureStatusItem() {
        let bundle = Bundle.main
        let image = currentWindowState.icon
        image.size = NSSize(width: 22, height: 22)
        
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        guard let statusItemButton = statusItem.button else { return }
        statusItemButton.image = image
        
        statusItem.menu = statusMenu
        
        
        self.statusItem = statusItem
    }


}

