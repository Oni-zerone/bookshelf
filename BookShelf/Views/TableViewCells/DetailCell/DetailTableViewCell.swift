//
//  DetailTableViewCell.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var firstLabel:UILabel!
    @IBOutlet weak var secondLabel:UILabel!
    @IBOutlet weak var secondAccessorLabel: UILabel!
    @IBOutlet weak var thirdLabel:UILabel!
    @IBOutlet weak var fourthLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.firstLabel.text = ""
        self.secondLabel.text = ""
        self.secondAccessorLabel.text = ""
        self.thirdLabel.text = ""
        self.fourthLabel.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
