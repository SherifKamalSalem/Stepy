//
//  RunLogCell.swift
//  Stepy
//
//  Created by Sherif Kamal on 11/7/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var runDurationLbl: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var averagePaceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(run: Run) {
        runDurationLbl.text = run.duration.formatDurationToString()
        totalDistanceLbl.text = "\(run.distance.metersToMiles(places: 2)) mi"
        averagePaceLbl.text = run.pace.formatDurationToString()
        dateLbl.text = run.date.getDateString()
    }
    
}
