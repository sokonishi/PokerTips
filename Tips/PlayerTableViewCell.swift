//
//  PlayerTableViewCell.swift
//  Tips
//
//  Created by 小西壮 on 2019/06/10.
//  Copyright © 2019 小西壮. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel?
    @IBOutlet weak var betPriceLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setcell(playerName:String,betPrice:String){
//        playerNameLabel?.text = playerName
//        betPriceLabel?.text = betPrice
//    }

}
