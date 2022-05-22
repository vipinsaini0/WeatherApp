//
//  WeatherMainCollectionViewCell.swift
//  WeatherApp
//
//  Created by Vipin Saini on 21/05/22.
//

import UIKit
import SDWebImage


class WeatherMainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tblView: UITableView!
    
    var weatherList: [WeatherListCellViewModel]?
}
 
    // MARK: - Table View
extension WeatherMainCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // Header Title
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let date = weatherList?[section].weatherDate
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 0, width: headerView.frame.width-10, height: headerView.frame.height)
        label.text = helper.getDateString(date: date ?? Date()) // set Date on current section
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        headerView.addSubview(label)
        headerView.backgroundColor = .clear
        return headerView
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherHourlyTableViewCell
        if let weather = weatherList?[indexPath.row] {
            // Set time
            cell.lblTime.text = helper.convertTimeFromTimestamp(timeStamp: weather.dt)
            // Set temperature
            let temp = round(weather.main?.temp ?? 0)
            cell.lblTemp.text = "\(Int(temp))°C"
            // Set weather icon
            let imgName = weather.weather?.first?.icon ?? "01d"
            cell.imgView.sd_setImage(with: URL(string: "https://openweathermap.org/img/wn/\(imgName)@2x.png"))
        }
        return cell
    }
}
