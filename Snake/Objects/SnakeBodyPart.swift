//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by Evgeny Kireev on 02/02/2019.
//  Copyright © 2019 Pinspb. All rights reserved.
//


import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    
    // MARK: - Init
    
    init(atPoint point: CGPoint) {
        super.init()
        self.position = point
        self.configureUI()
        self.addPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configureUI() {
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = UIColor.green
        strokeColor = UIColor.green
        lineWidth = 5
    }
    
    private func addPhysicsBody() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: 6, center: CGPoint(x: 5, y:5))
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple
    }
}
