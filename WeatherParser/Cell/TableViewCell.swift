//
//  TableViewCell.swift
//  WeatherParser
//
//  Created by macbook on 27.01.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelLike: UILabel!
    
    
     private var parObj:Welcome?
    
    public func setModel(with model:Welcome?){
         self.parObj = model
        name.text = model?.name
        weather.text = model?.weather[0].weatherDescription
        if let t = model?.main.temp,let fl = model?.main.feelsLike{
        temp.text = "\(t)"
        feelLike.text = "\(fl)"
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
