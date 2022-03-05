import UIKit

class CalendarPickerFooterView: UIView {

    // MARK: Properties
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.lightAsh.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var previousMonthButton: LSImageButton = {
        let buttonView = LSImageButton(image: Asserts.chevronLeftCircleFill, tintColor: AppColor.lightBlack)
        
        buttonView.button.addTarget(self, action: #selector(didTapPreviousMonthButton), for: .touchUpInside)
        return buttonView
    }()
    
    lazy var nextMonthButton: LSImageButton = {
        let buttonView = LSImageButton(image: Asserts.chevronRighttCircleFill, tintColor: AppColor.lightBlack)
                
        buttonView.button.addTarget(self, action: #selector(didTapNextMonthButton), for: .touchUpInside)
        return buttonView
    }()
    
//    private var previousOrientation: UIDeviceOrientation = UIDevice.current.orientation
    
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
        backgroundColor = .systemBackground
        
        addSubviews(separatorView, previousMonthButton, nextMonthButton)
    }
    
    
    func layout() {
        let buttonDimensions: CGFloat = 35
        
        separatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: 1))
        
        previousMonthButton.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: buttonDimensions, height: buttonDimensions))
        previousMonthButton.centerVerticallyInSuperView()
        
        nextMonthButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20), size: .init(width: buttonDimensions, height: buttonDimensions))
        nextMonthButton.centerVerticallyInSuperView()
    }
}
