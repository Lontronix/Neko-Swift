//
//  ViewController.swift
//  Neko-Swift
//
//  Created by Lonnie Gerol on 4/7/23.
//

import Cocoa

class NekoViewController: NSViewController {
    
    private var imageView: NekoView!
    private var currentState: NekoState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = NSRect(x: 0, y: 0, width: 32, height: 32)
        imageView = NekoView(frame: self.view.frame)
        self.view.addSubview(imageView)
    }
    
    func update(image: NSImage) {
        imageView.update(image: image)
        imageView.image = image
    }
    
}

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

