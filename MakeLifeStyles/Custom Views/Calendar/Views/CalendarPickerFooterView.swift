import UIKit

class CalendarPickerFooterView: UIView {

    // MARK: Properties
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.lightAsh.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var previousMonthButton: UIButton = {
        let button = LSButton(backgroundColor: .clear, titleColor: AppColor.lightBlack, fontSize: 17)
        button.titleLabel?.textAlignment = .left
        
        let chevronImage = Asserts.chevronLeftCircleFill
        let imageAttachment = NSTextAttachment(image: chevronImage)
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(
            NSAttributedString(attachment: imageAttachment)
        )
        
        attributedString.append(
            NSAttributedString(string: " Previous")
        )
        
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.addTarget(self, action: #selector(didTapPreviousMonthButton), for: .touchUpInside)
        return button
    }()
    
    lazy var nextMonthButton: UIButton = {
        let button = LSButton(backgroundColor: .clear, titleColor: AppColor.lightBlack, fontSize: 17)
        button.titleLabel?.textAlignment = .left
        
        let chevronImage = Asserts.chevronRighttCircleFill
        let imageAttachment = NSTextAttachment(image: chevronImage)
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(
            NSAttributedString(attachment: imageAttachment)
        )
        
        attributedString.append(
            NSAttributedString(string: "Next")
        )
        
        button.setAttributedTitle(attributedString, for: .normal)
                
        button.addTarget(self, action: #selector(didTapNextMonthButton), for: .touchUpInside)
        return button
    }()
    
    private var previousOrientation: UIDeviceOrientation = UIDevice.current.orientation
    
    let didTapLastMonthCompletionHandler: (() -> Void)
    let didTapNextMonthCompletionHandler: (() -> Void)
    
    
    // MARK: Initializers
    init(didTapLastMonthCompletionHandler: @escaping (() -> Void), didTapNextMonthCompletionHandler: @escaping (() -> Void)) {
        self.didTapLastMonthCompletionHandler = didTapLastMonthCompletionHandler
        self.didTapNextMonthCompletionHandler = didTapNextMonthCompletionHandler
        
        super.init(frame: CGRect.zero)
        
        initialSetup()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
        
    // MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        style()
        layout()
    }
}


// MARK: - Private Methods
private extension CalendarPickerFooterView {
    
    @objc func didTapPreviousMonthButton() {
        didTapLastMonthCompletionHandler()
    }
    
    
    @objc func didTapNextMonthButton() {
        didTapNextMonthCompletionHandler()
    }
    
    
    func initialSetup() {
        backgroundColor = AppColor.lightYellow
        
        addSubviews(separatorView, previousMonthButton, nextMonthButton)
    }
    
    
    func style() {
        let smallDevice = UIScreen.main.bounds.width <= 350
        
        let fontPointSize: CGFloat = smallDevice ? 14 : 17
        
        previousMonthButton.titleLabel?.font = .systemFont(ofSize: fontPointSize, weight: .medium)
        nextMonthButton.titleLabel?.font = .systemFont(ofSize: fontPointSize, weight: .medium)
    }
    
    
    func layout() {
        separatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: 1))
        
        previousMonthButton.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 0, height: GlobalDimensions.height))
        previousMonthButton.centerVerticallyInSuperView()
        
        nextMonthButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: 0, height: GlobalDimensions.height))
        nextMonthButton.centerVerticallyInSuperView()
    }
}
