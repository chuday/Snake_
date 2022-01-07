//
//  Apple.swift
//  Snake
//
//  Created by Evgeny Kireev on 02/02/2019.
//  Copyright © 2019 Pinspb. All rights reserved.
//

import UIKit
import SpriteKit

final class Apple: SKShapeNode {
    
    convenience init(position: CGPoint) {
        self.init()
        self.position = position
        self.configureUI()
        self.addPhysicsBody()
    }
    
    private func configureUI() {
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = UIColor.red
        strokeColor = UIColor.red
        lineWidth = 5
    }
    
    private func addPhysicsBody() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center:CGPoint(x:5, y:5))
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}

