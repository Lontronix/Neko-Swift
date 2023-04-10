//
//  NekoFullScreenStateMachine.swift
//  Neko-Swift
//
//  Created by Lonnie Gerol on 4/9/23.
//

import Foundation

class NekoFullScreenStateMachine: NekoStateMachine {
    
    var delegate: NekoStateMachineDelegate?
    
    var currentState: NekoState = .stop {
        willSet {
            guard newValue != currentState else { return }
            self.tickCount = 0
            self.stateCount = 0
        }
    }
    
    private var updateTimer: Timer?
    
    private var nekoMoveDx: Float = 0
    private var nekoMoveDy: Float = 0
    
    private var stateCount = 0
    private var tickCount = 0
    
    var isNekoMoveStart: Bool {
        return nekoMoveDx > 6 || nekoMoveDx < -6 || nekoMoveDy > 6 || nekoMoveDy < -6
    }
    
    func pause() {
        self.updateTimer?.invalidate()
    }
    
    func resume() {
        self.updateTimer = Timer.scheduledTimer(
            withTimeInterval: 0.125,
            repeats: true
        ) { timer in
            guard let delegate = self.delegate else { return }
            
            let ( mousePos, nekoPos ) = delegate.getCursorNekoLocation()
            self.updateNekoPosition(mousePos: mousePos, nekoPos: nekoPos)
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
    
    private func updateNekoPosition(mousePos: NSPoint, nekoPos: NSPoint) {
        
        var nekoPos = nekoPos
        
        guard let delegate = delegate else { return }
        
        if currentState != .sleep {
            delegate.update(sprite: currentState.imageFor(tickCount: tickCount))
        } else {
            delegate.update(sprite: currentState.imageFor(tickCount: tickCount << 2))
        }
        
        self.advanceClock()
        
        switch currentState {
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
            handleAwake()
        case .move(let _):
            nekoPos.x += CGFloat(nekoMoveDx)
            nekoPos.y += CGFloat(nekoMoveDy)
            self.setNekoDirection()
        case .togi(let _):
            handleTogi()
        }
        
        let newPos = CGPoint(x: Double(nekoPos.x), y: Double(nekoPos.y))
        delegate.newNeko(pos: newPos)
        
        self.calcDxDy(mousePos: mousePos, nekoPos: newPos)
        
    }
    
    private func handleStop() {
        if isNekoMoveStart {
            currentState = .awake
        }
        if stateCount >= 4 {
            currentState = .jare
        }
    }
    
    private func handleJare() {
        if isNekoMoveStart {
            currentState = .awake
            return
        }
        
        guard stateCount >= 10 else { return }
        
        currentState = .kaki
    }
    
    private func handleKaki() {
        if isNekoMoveStart {
            currentState = .awake
            return
        }
        
        guard stateCount >= 4 else {
            return
        }
        
        currentState = .akubi
    }
    
    private func handleAkubi() {
        if isNekoMoveStart {
            currentState = .awake
            return
        }
        
        guard stateCount >= 6 else {
            return
        }
        
        currentState = .sleep
    }
    
    private func handleSleep() {
        if isNekoMoveStart {
            currentState = .awake
            return
        }
    }
    
    private func handleAwake() {
        guard stateCount >= 3 else {
            return
        }
        
        self.setNekoDirection()
    }
    
    private func handleTogi() {
        if isNekoMoveStart {
            currentState = .awake
            return
        }
        
        guard stateCount >= 10 else { return }
        self.currentState = .kaki
    }
    
    private func setNekoDirection() {
        guard nekoMoveDx != 0 && nekoMoveDy != 0 else {
            currentState = .stop
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
        
        self.currentState = newState
        
    }
    
    private func calcDxDy(mousePos: NSPoint, nekoPos: NSPoint) {
        // TODO: Figure out what this magic number does...
        let deltaX = floor(mousePos.x - nekoPos.x - 16.0)
        let deltaY = floor(mousePos.y - nekoPos.y)
        
        let length = hypot(deltaX, deltaY)
        
        guard length != 0 else {
            nekoMoveDx = 0
            nekoMoveDy = 0
            return
        }
        
        // TODO: Figure out what this magic number does...
        if length <= 13 {
            nekoMoveDx = Float(deltaX)
            nekoMoveDy = Float(deltaY)
        } else {
            nekoMoveDx = Float((13.0 * deltaX) / length)
            nekoMoveDy = Float((13.0 * deltaY) / length)
        }
        
    }
    
}
