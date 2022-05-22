//
//  WeatherHourlyTableViewCell.swift
//  WeatherApp
//
//  Created by Vipin Saini on 21/05/22.
//

import UIKit

class WeatherHourlyTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    
     
    // MARK: - View load
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
}
