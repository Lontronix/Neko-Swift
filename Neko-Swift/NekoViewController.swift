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

