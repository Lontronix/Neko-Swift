//
//  NekoState.swift
//  Neko-Swift
//
//  Created by Lonnie Gerol on 4/8/23.
//

import AppKit

// MARK: NekoDirection
enum NekoDirection {
    case left
    case right
    case up
    case upLeft
    case upRight
    case down
    case downLeft
    case downRight
}

enum TogiDirection {
    case up
    case down
    case left
    case right
}

// MARK: NekoState
enum NekoState {
    case stop
    case jare
    case kaki
    case akubi
    case sleep
    case awake
    case move(direction: NekoDirection)
    case togi(direction: TogiDirection)
    
    var images: [NSImage] {
        switch self {
        case .stop:
            return NekoImages.stopImages
        case .move(direction: let direction):
            switch direction {
            case .left:
                return NekoImages.moveLeftImages
            case .right:
                return NekoImages.moveRightImages
            case .up:
                return NekoImages.moveUpImages
            case .upLeft:
                return NekoImages.moveUpLeftImages
            case .upRight:
                return NekoImages.moveUpRightImages
            case .down:
                return NekoImages.moveDownImages
            case .downLeft:
                return NekoImages.moveDownLeftImages
            case .downRight:
                return NekoImages.moveDownRightImages
            }
        case .jare:
            return NekoImages.jareImages
        case .akubi:
            return NekoImages.akubiImages
        case .kaki:
            return NekoImages.kakiImages
        case .awake:
            return NekoImages.awakeImages
        case .sleep:
            return NekoImages.sleepImages
        case .togi(direction: let direction):
            switch direction {
            case .up:
                return NekoImages.upTogiImages
            case .down:
                return NekoImages.downTogiImages
            case .left:
                return NekoImages.leftTogiImages
            case .right:
                return NekoImages.rightTogiImages
            }
        }
    }
    
    func imageFor(tickCount: Int) -> NSImage {
        let images = self.images
        return images[tickCount % images.count]
    }
}

// MARK: NekoState Equatable
extension NekoState: Equatable {
    public static func ==(lhs: NekoState, rhs:NekoState) -> Bool {
          switch (lhs,rhs) {
          case (.stop, .stop):
              return true
          case (.jare, .jare):
              return true
          case (.kaki, .kaki):
              return true
          case (.akubi, .akubi):
              return true
          case (.sleep, .sleep):
              return true
          case (.awake, .awake):
              return true
          case (.move(let a), .move(let b)):
              return a == b
          default:
              return false
          }
          
      }
}
