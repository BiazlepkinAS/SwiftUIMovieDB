import SwiftUI
import UIKit

private let _imageCach = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoad = false
    var imageCash = _imageCach
    
    func loadImage(with url: URL){
        let urlString = url.absoluteString
        if let imageFromCash = imageCash.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCash
            return
        }
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                self.imageCash.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}

