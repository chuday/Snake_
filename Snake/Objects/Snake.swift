//
//  Snake.swift
//  Snake
//
//  Created by Evgeny Kireev on 02/02/2019.
//  Copyright © 2019 Pinspb. All rights reserved.
//

import UIKit
import SpriteKit

class Snake: SKShapeNode {
    
    var moveSpeed = Observable<Double>(125.0)
    var angle: CGFloat = 0.0
    var body = [SnakeBodyPart]()
    
    // MARK: - Init
    
    convenience init(atPoint point: CGPoint) {
        self.init()
        self.createHead(at: point)
    }
    
    // MARK: - Methods
    
    func addBodyPart() {
        let point = CGPoint(x: body[0].position.x, y: body[0].position.y)
        let newBodyPart = SnakeBodyPart(atPoint: point)
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    func move() {
        guard !body.isEmpty else { return }
        
        let head = body[0]
        moveHead(head)
        
        for index in (0..<body.count) where index > 0 {
            moveBodyPart(body[index], to: body[index-1])
        }
    }
    
    func moveClockwise(){
        angle += CGFloat(Double.pi/2)
    }
    
    func moveCounterClockwise(){
        angle -= CGFloat(Double.pi/2)
    }
    
    // MARK: - Private
    
    private func createHead(at point: CGPoint) {
        let head = SnakeHead(atPoint: point)
        body.append(head)
        addChild(head)
    }

    private func moveHead(_ head: SnakeBodyPart) {
        let dx = CGFloat(moveSpeed.value) * sin(angle);
        let dy = CGFloat(moveSpeed.value) * cos(angle);
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        head.run(moveAction)
    }
    
    private func moveBodyPart(_ bodyPart: SnakeBodyPart, to toBodyPart: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: toBodyPart.position.x, y: toBodyPart.position.y), duration: 0.1)
        bodyPart.run(moveAction)
    }
}
