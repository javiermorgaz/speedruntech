//
//  GameListTableViewCell.swift
//  speedruntech
//
//  Created by Javier Morgaz García on 13/8/18.
//  Copyright © 2018 Javier Morgaz García. All rights reserved.
//

import UIKit
import SDWebImage

class GameListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        setUpCell()
    }
    
    // MARK: - Public Methods
    public func updateCell(model:Game) {
        nameLabel.text = model.name
        if let url = URL(string: model.logoUri) {
            logoImageView.sd_setImage(with: url, placeholderImage: nil)
        }
    }

    // MARK: - Private Methods
    private func setUpCell() {
        
        self.selectionStyle = .none
        logoImageView.layer.cornerRadius = 30.0
        logoImageView.layer.borderWidth = 1.5
        logoImageView.layer.borderColor = UIColor.red.cgColor
    }
}
