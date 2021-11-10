//
//  WeatherTableViewCell.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 08.11.2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var weatherImageView: CustomImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var condition: UILabel!
    
    func setCity(city:String){
        self.city.text = city
    }
    func setTemp(temp:String){
        self.temp.text = temp
    }
    func setImage(image:UIImage){
        self.weatherImageView.image = image
    }
    func setCondition(condition:String) {
        self.condition.text = condition
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        indicator.isHidden = false
        indicator.startAnimating()
        city.text = ""
        temp.text = ""
        weatherImageView.image = nil
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
