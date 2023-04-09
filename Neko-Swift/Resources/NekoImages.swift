//
//  NekoImage.swift
//  Neko-Swift
//
//  Created by Lonnie Gerol on 4/8/23.
//

import AppKit

struct NekoImages {
    
    // MARK: Stop
    static let stopImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "mati2", ofType: "gif")!)!
    ]
    
    // MARK: Up
    static let moveUpImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "up1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "up2", ofType: "gif")!)!
    ]
    
    // MARK: Up Left
    static let moveUpLeftImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "upleft1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "upleft2", ofType: "gif")!)!
    ]
    
    // MARK: Up Right
    static let moveUpRightImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "upright1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "upright2", ofType: "gif")!)!
    ]
    
    // MARK: Down
    static let moveDownImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "down1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "down2", ofType: "gif")!)!
    ]
    
    // MARK: Down Left
    static let moveDownLeftImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "dwleft1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "dwleft2", ofType: "gif")!)!
    ]
    
    // MARK: Down Right
    static let moveDownRightImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "dwright1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "dwright2", ofType: "gif")!)!
    ]
    
    // MARK: Left
    static let moveLeftImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "left1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "left2", ofType: "gif")!)!
    ]
    
    // MARK: Right
    static let moveRightImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "right1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "right2", ofType: "gif")!)!
    ]
    
    // MARK: Jare
    static let jareImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "jare2", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "mati2", ofType: "gif")!)!,
    ]
    
    // MARK: Kaki
    static let kakiImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "kaki2", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "kaki2", ofType: "gif")!)!,
    ]
    
    // MARK: Akubi
    static let akubiImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "mati3", ofType: "gif")!)!,
    ]
    
    // MARK: Sleep
    static let sleepImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "sleep1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "sleep2", ofType: "gif")!)!
    ]
    
    // MARK: Awake
    static let awakeImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "awake", ofType: "gif")!)!
    ]
    
    // MARK: Up Togi
    static let upTogiImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "utogi1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "utogi2", ofType: "gif")!)!
    ]
    
    // MARK: Down Togi
    static let downTogiImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "dtogi1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "dtogi2", ofType: "gif")!)!
    ]
    
    // MARK: Left Togi
    static let leftTogiImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "ltogi1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "ltogi2", ofType: "gif")!)!
    ]
    
    // MARK: Right Togi
    static let rightTogiImages = [
        NSImage(contentsOfFile: Bundle.main.path(forResource: "rtogi1", ofType: "gif")!)!,
        NSImage(contentsOfFile: Bundle.main.path(forResource: "rtogi2", ofType: "gif")!)!
    ]
}
