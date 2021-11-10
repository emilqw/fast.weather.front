//
//  ImageView.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 08.11.2021.
//

import UIKit
import SVGKit
/// Кастомный Image View
@IBDesignable class CustomImageView: UIImageView {
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        DispatchQueue.global().async {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let receivedicon: SVGKImage = SVGKImage(data: data),
                let image = receivedicon.uiImage else {
                    self.download(from: url)
                    return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
        }
    }
    
    
    /// Скачивает изображение по URL
    /// - Parameters:
    ///   - link: URL Изображения
    ///   - mode:
    func download(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
}
