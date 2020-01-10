//
//  TableViewCell.swift
//  PhotoNotes
//
//  Created by Иван Лебедев on 15.11.2019.
//  Copyright © 2019 Иван Лебедев. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!

    @IBOutlet weak var cellImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
