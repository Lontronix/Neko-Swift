//
//  MyPanel.swift
//  Neko-Swift
//
//  Created by Lonnie Gerol on 4/7/23.
//

import AppKit


class NekoViewModel {
    
    var stateCount = 0
    var tickCount = 0
    var currentState: NekoState = .stop {
        willSet {
            guard newValue != currentState else { return }
            self.tickCount = 0
            self.stateCount = 0
        }
    }
    
    func advanceClock() {
        tickCount += 1
        if tickCount == 255 {
            tickCount = 0
        }
        
        if tickCount % 2 == 0 {
            if stateCount < 255 {
                stateCount += 1
            }
        }
    }
}

class NekoPanel: NSPanel {
    
    var updateTimer: Timer!
    
    var nekoMoveDx: Float = 0
    var nekoMoveDy: Float = 0
    
    var isNekoMoveStart: Bool {
        return nekoMoveDx > 6 || nekoMoveDx < -6 || nekoMoveDy > 6 || nekoMoveDy < -6
    }
    
    var viewModel = NekoViewModel()
    
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
        
        self.updateTimer = Timer.scheduledTimer(withTimeInterval: 0.125, repeats: true) { timer in
            self.updateNekoLocation()
        }
    }
    
    func setNekoDirection() {
        
        guard nekoMoveDx != 0 && nekoMoveDy != 0 else {
            viewModel.currentState = .stop
            return
        }
        
        let nekoMoveDx = Double(nekoMoveDx)
        let nekoMoveDy = Double(nekoMoveDy)
        
        let length = sqrt(pow(nekoMoveDx, 2) + pow(nekoMoveDy, 2))
        let sinTheta = nekoMoveDy / length
        
        let newState: NekoState
        
        if nekoMoveDx > 0 {
            if (sinTheta > 0.9239) {
                newState = .move(direction: .up)
            } else if (sinTheta > 0.3827) {
                newState = .move(direction: .upRight)
            } else if (sinTheta > -0.3827) {
                newState = .move(direction: .right)
            } else if (sinTheta > -0.9239) {
                newState = .move(direction: .downRight)
            } else {
                newState = .move(direction: .down)
            }
        } else {
            if (sinTheta > 0.9239) {
                newState = .move(direction: .up)
            } else if (sinTheta > 0.3827) {
                newState = .move(direction: .upLeft)
            } else if (sinTheta > -0.3827) {
                newState = .move(direction: .left)
            } else if (sinTheta > -0.9239) {
                newState = .move(direction: .downLeft)
            } else {
                newState = .move(direction: .down)
            }
        }
        
        self.viewModel.currentState = newState
        
    }
    
    func updateNekoLocation() {
        var xPos = Float(self.frame.origin.x)
        var yPos = Float(self.frame.origin.y)
        
        guard let vc = self.contentViewController as? ViewController else {
            fatalError("ContentViewController is not an instance of ViewController")
        }
        
        print(viewModel.tickCount)
        if viewModel.currentState != .sleep {
            vc.update(image: viewModel.currentState.imageFor(tickCount: viewModel.tickCount))
        } else {
            vc.update(image: viewModel.currentState.imageFor(tickCount: viewModel.tickCount<<2))

        }
        
        viewModel.advanceClock()
        
        switch viewModel.currentState {
        case .stop:
            handleStop()
        case .jare:
            handleJare()
        case .kaki:
            handleKaki()
        case .akubi:
            handleAkubi()
        case .sleep:
            handleSleep()
        case .awake:
            self.setNekoDirection()
        case .togi(direction: _):
            handleTogi()
        case .move(direction: _):
            xPos += nekoMoveDx
            yPos += nekoMoveDy
            self.setNekoDirection()
        }
        
        self.setFrameOrigin(CGPoint(x: Double(xPos), y: Double(yPos)))
        
        self.calcDxDy(x: Float(self.frame.origin.x), y: Float(self.frame.origin.y))
        
        // https://developer.apple.com/forums/thread/696742
        // I spent hours trying to figure out why the outline of the inital image would persist... this is the reason
        self.invalidateShadow()
//        vc.update(image: viewModel.currentState.image)
        
    }
    
    private func handleStop() {
        if isNekoMoveStart {
            viewModel.currentState = .awake
        }
        if viewModel.stateCount >= 4 {
            viewModel.currentState = .jare
        }
    }
    
    private func handleJare() {
        if isNekoMoveStart {
            self.viewModel.currentState = .awake
            return
        }
        
        guard viewModel.stateCount >= 10 else { return }
        
        self.viewModel.currentState = .kaki
    }
    
    private func handleKaki() {
        if isNekoMoveStart {
            self.viewModel.currentState = .awake
            return
        }
        
        guard viewModel.stateCount >= 4 else {
           return
        }
        
        self.viewModel.currentState = .akubi
    }
    
    private func handleAkubi() {
        if isNekoMoveStart {
            self.viewModel.currentState = .awake
            return
        }
        
        guard viewModel.stateCount >= 6 else {
            return
        }
        
        self.viewModel.currentState = .sleep
    }
    
    private func handleSleep() {
        if isNekoMoveStart {
            self.viewModel.currentState = .awake
            return
        }
    }
    
    private func handleAwake() {
        guard viewModel.stateCount >= 3 else {
            return
        }
        
        self.setNekoDirection()
        
    }
    
    private func handleTogi() {
        if isNekoMoveStart {
            self.viewModel.currentState = .awake
            return
        }
        
        guard viewModel.stateCount >= 10 else { return }
        self.viewModel.currentState = .kaki
    }
    
    func calcDxDy(x: Float, y: Float) {
        let mousePoint = NSEvent.mouseLocation
        let mouseXPos = Float(mousePoint.x)
        let mouseYPos = Float(mousePoint.y)
        
        // TODO: Figure out what this magic number does...
        let deltaX = floor(mouseXPos - x - 16.0)
//        print(deltaX)
        let deltaY = floor(mouseYPos - y)
        
        let length = hypot(deltaX, deltaY)
        
//        print("length: \(length)")
        
        guard length != 0 else {
            nekoMoveDx = 0
            nekoMoveDy = 0
            return
        }
        
        // TODO: Figure out what this magic number does...
        if length <= 13 {
            nekoMoveDx = deltaX
            nekoMoveDy = deltaY
        } else {
            nekoMoveDx = (13.0 * deltaX) / length
            nekoMoveDy = (13.0 * deltaY) / length
        }
        
    }
    
}
