//
//  ResultsViewController.swift
//  Snake
//
//  Created by Mikhail Chudaev on 04.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ResultsViewController: UITableViewDelegate {
    
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GameSingleton.shared.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell {
            
            let record = GameSingleton.shared.records[indexPath.row]
            cell.scoreLabel.text = "\(record.score)"
            cell.dateLabel.text = record.date.description
            cell.cellDelegate = self
            
            return cell
        }
    
        return UITableViewCell()
    }
}

extension ResultsViewController: RecordTableViewCellDelegate {
    func didTapOnScoreLabel(scoreLabelText: String) {
        print(scoreLabelText)
    }
}
