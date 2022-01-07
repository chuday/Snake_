//
//  MainViewController.swift
//  Snake
//
//  Created by Mikhail Chudaev on 04.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var difficultySegmentedControl: UISegmentedControl!
    
    private var selectedDifficulty: Difficulty {
        switch difficultySegmentedControl.selectedSegmentIndex {
        case 0:
            return .easy
        case 1:
            return .medium
        case 2:
            return .hard
        case 3:
            return .nightmare
        default:
            return .medium
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toGameVC":
            if let destination = segue.destination as? GameViewController {
                // destination.gameVCDelegate = self
                
                destination.difficulty = selectedDifficulty
                
                destination.onGameEnd = { [weak self] (result) in
                    guard let self = self else { return }
                    
                    self.resultLabel.text = "Количество очков: \(result)"
                }
            }
        default:
            break
        }
    }
}

/*
extension MainViewController: GameViewControllerDelegate {
    func didEndGame(with result: Int) {
        resultLabel.text = "Количество очков: \(result)"
    }
}
*/
