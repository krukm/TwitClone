import UIKit

class SignInView: UIView {
    
    private lazy var signInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = CGFloat(20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "sign_in_stack_view"
        return stackView
    }()
    
    private lazy var logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "twitter_logo")?.rounded
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "logo_image_view"
        return imageView
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("sign in", for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "sign_in_button"
        return button
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        accessibilityIdentifier = "sign_in_view"
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemTeal
        addSubview(signInStackView)
        signInStackView.addArrangedSubview(logoImageView)
        signInStackView.addArrangedSubview(signInButton)
    }
    
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(signInStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(60)))
        constraints.append(signInStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(-60)))
        constraints.append(signInStackView.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(signInStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.20))
        
        constraints.append(logoImageView.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -20))
        
        constraints.append(signInButton.heightAnchor.constraint(equalToConstant: 30))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIImage {
    var rounded: UIImage? {
        UIGraphicsBeginImageContext(size)
        UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).addClip()
        self.draw(at: .zero)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIView {
    func fill(superview: UIView, withLayoutMargins: Bool = false) -> [NSLayoutConstraint] {
        if withLayoutMargins {
            return [
                topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
                leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor),
                superview.layoutMarginsGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
                superview.layoutMarginsGuide.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
        return [
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            superview.bottomAnchor.constraint(equalTo: bottomAnchor),
            superview.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
    
    func equalEdgeInsets(inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
