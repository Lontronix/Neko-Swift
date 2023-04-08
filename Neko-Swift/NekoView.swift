//
//  NekoView.swift
//  Neko-Swift
//
//  Created by Lonnie Gerol on 4/7/23.
//

import Cocoa

class NekoView: NSView {
    
    var image: NSImage?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        guard let image = image else { return }
        guard let context = NSGraphicsContext.current else {
            return
        }
        context.imageInterpolation = .none
        image.draw(in: self.frame, from: .zero, operation: .copy, fraction: 1)
    }
    
    
    func update(image: NSImage) {
        guard image != self.image else {
            return
        }
        self.image = image
        self.needsDisplay = true
    }

}
