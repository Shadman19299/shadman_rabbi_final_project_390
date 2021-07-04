//
//  cell.swift
//  shadman_rabbi_final_project_390
//
//  Created by Shadman UR Rabbi on 7/3/21.
//

import UIKit

class cell: UITableViewCell {

   
    @IBOutlet weak var ittaglbl: UILabel!

    @IBOutlet weak var Slocationlbl: UILabel!
    @IBOutlet weak var Flocationlbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
