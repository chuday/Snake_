//
//  GameScene.swift
//  Snake
//
//  Created by Evgeny Kireev on 02/02/2019.
//  Copyright © 2019 Pinspb. All rights reserved.
//

import SpriteKit
import GameplayKit

/*
protocol GameSceneDelegate: AnyObject {
    func didEndGame(with result: Int)
}
 */

final class GameScene: SKScene {
    
    var snake: Snake?
    
    var apple: Apple?
    
//    weak var gameSceneDelegate: GameSceneDelegate?
    
    var onGameEnd: ((Int) -> Void)?
    
    private let appleStrategy: AppleStrategy
    private let speedStrategy: SnakeSpeedStrategy
    
    init(size: CGSize, appleStrategy: AppleStrategy, speedStrategy: SnakeSpeedStrategy) {
        self.appleStrategy = appleStrategy
        self.speedStrategy = speedStrategy
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SKScene
    
    override func didMove(to view: SKView) {
        self.configureUI()
        self.configurePhysics()
        self.addButtons()
        self.addSnake()
        self.createApple()
    }
    
    override func update(_ currentTime: TimeInterval) {
        snake?.move()
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode
                , touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
                    return
            }
            touchedNode.fillColor = .green
            if touchedNode.name == "counterClockwiseButton" {
                snake?.moveCounterClockwise()
            } else if touchedNode.name == "clockwiseButton" {
                snake?.moveClockwise()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
                    return
            }
            touchedNode.fillColor = UIColor.gray
        }
    }
    
    // MARK: - Private
    
    private func configureUI() {
        backgroundColor = SKColor.black
        self.view?.showsPhysics = true
    }
    
    private func configurePhysics() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    private func addButtons() {
        guard let view = self.view, let scene = view.scene else { return }
        
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.position = CGPoint(x: scene.frame.minX + 30, y: scene.frame.minY + 30)
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.fillColor = UIColor.gray
        counterClockwiseButton.strokeColor = UIColor.gray
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.position = CGPoint(x: scene.frame.maxX - 80, y: scene.frame.minY + 30)
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.fillColor = UIColor.gray
        clockwiseButton.strokeColor = UIColor.gray
        clockwiseButton.lineWidth = 10
        clockwiseButton.name = "clockwiseButton"
        
        self.addChild(counterClockwiseButton)
        self.addChild(clockwiseButton)
    }
    
    private func addSnake() {
        guard let view = self.view, let scene = view.scene else { return }
        
        let snake = Snake(atPoint: CGPoint(x: scene.frame.midX, y: scene.frame.midY))
        self.snake = snake
        self.addChild(snake)
    }
    
    fileprivate func createApple(){
        guard let view = self.view, let scene = view.scene else { return }
    
        let apples = appleStrategy.createApple(in: scene.frame)
        guard let apple = apples.first else { return }
        
        self.addChild(apple)
    }
    
    fileprivate func restartGame() {
        self.snake?.body.forEach { $0.removeFromParent() }
        self.snake?.removeFromParent()
        self.snake = nil
        self.apple?.removeFromParent()
        self.apple = nil
        self.addSnake()
        self.createApple()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes ^ CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            self.headDidCollideApple(apple: apple)
        case CollisionCategories.EdgeBody:
            self.headDidCollideWall(contact)
        default:
            break
        }
    }
    
    private func headDidCollideApple(apple: SKNode?) {
        snake?.addBodyPart()
        apple?.removeFromParent()
        self.apple = nil
        createApple()
        
        speedStrategy.snake = snake
        speedStrategy.increaseSpeed()
    }
    
    private func headDidCollideWall(_ contact: SKPhysicsContact) {
//        self.restartGame()
        
        guard let snake = snake else { return }
        
        let score = snake.body.count - 1
        let record = Record(date: Date(), score: score)
        
        GameSingleton.shared.addRecord(record: record)
        
//        gameSceneDelegate?.didEndGame(with: score)
        onGameEnd?(score)
    }
}
