//
//  CollectionCell.swift
//  WeatherParser
//
//  Created by macbook on 31.01.2021.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(model:Welcome){
        self.name.text = model.name
        switch model.weather[0].main{
        case "Snow":
            self.image.image = UIImage(systemName: "cloud.snow")
        case "Rain":
            self.image.image = UIImage(systemName: "cloud.rain")
        case "Clear":
            self.image.image = UIImage(systemName: "sun.min")
        default:
            self.image.image = UIImage(named: "sun.min")
        }
        self.temp.text = ("\(model.main.temp) C")
    }
    @IBAction func searchButton(_ sender: Any) {
        let alert = UIAlertController(title: "Enter your city", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let citySearch   = UIAlertAction(title: "Set your city ", style: .default, handler: nil)
        alert.addAction(citySearch)
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.present(alert, animated: true, completion: nil)
    }
    
}
