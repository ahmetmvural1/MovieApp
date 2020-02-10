//
//  detailCell.swift
//  MovieApp
//
//  Created by koineks teknoloji on 10.02.2020.
//  Copyright © 2020 Ahmet Muhammet Vural. All rights reserved.
//

import UIKit

class detailCell: UITableViewCell {

    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
