//
//  QuestionCell.swift
//  Aether
//
//  Created by Karan Mehta on 6/20/15.
//  Copyright (c) 2015 karohan. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet var questionLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showQuestion(){
        
    }

}
