//
//  TaskCellTableViewCell.swift
//  Gamyfy Life
//
//  Created by Vighnesh Vadiraja on 24/02/21.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak var lblTaskName: UILabel!
    @IBOutlet weak var lblFrequency: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
