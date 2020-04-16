import BRYXBanner
import Foundation

class DialogueHelper {
    static func showStatusBarErrorMessage(errorMessageStr: String, _ color: UIColor = .systemOrange)  {
        DispatchQueue.main.async {
            let banner = Banner(title: "", subtitle: errorMessageStr, image: nil, backgroundColor: color)
            banner.preferredStatusBarStyle = .lightContent
            banner.detailLabel.textAlignment = .center
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
        }
    }
}
