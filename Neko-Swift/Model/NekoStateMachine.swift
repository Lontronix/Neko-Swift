//
//  StateMachine.swift
//  Neko-Swift
//
//  Created by Lonnie Gerol on 4/8/23.
//

import AppKit

protocol NekoStateMachineDelegate {
    func update(sprite: NSImage)
    func getCursorNekoLocation() -> (NSPoint, NSPoint)
    func newNeko(pos: CGPoint)
}

protocol NekoStateMachine {
    var delegate: NekoStateMachineDelegate? { get set }
    
    func pause()
    
    func resume()
}
