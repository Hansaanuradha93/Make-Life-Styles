import UIKit

class MakeHabitsVC: UIViewController {

    let titleLabel = LSTitleLabel(fontSize: 28, textAlignment: .left)
    let saveButton = LSButton(backgroundColor: UIColor.appColor(color: .teal), title: "SAVE", titleColor: .white, radius: 16, fontSize: 12)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(saveButton)
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 36, left: 20, bottom: 0, right: 0))
        saveButton.anchor(top: nil, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20), size: .init(width: 80, height: 32))
        saveButton.centerVertically(in: titleLabel)
        
        
        
        let attributedString = NSMutableAttributedString(string: "CREATE")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(2.5), range: NSRange(location: 0, length: attributedString.length))
        titleLabel.attributedText = attributedString
        
        
        
        
    }
}
