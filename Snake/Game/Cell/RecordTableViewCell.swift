//
//  RecordTableViewCell.swift
//  Snake
//
//  Created by Mikhail Chudaev on 04.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import UIKit

protocol RecordTableViewCellDelegate: AnyObject {
    func didTapOnScoreLabel(scoreLabelText: String)
}

class RecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var cellDelegate: RecordTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel))
        scoreLabel.addGestureRecognizer(tapGesture)
        scoreLabel.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension RecordTableViewCell {
    @objc func didTapOnLabel() {
        cellDelegate?.didTapOnScoreLabel(scoreLabelText: scoreLabel.text ?? "")
    }
}
