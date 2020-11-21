import Foundation
import UIKit

class SignInView: UIView {
    
    private lazy var signInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
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
    
    private lazy var textFieldStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = CGFloat(10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "text_field_stack_view"
        return stackView
    }()
    
    private lazy var emailTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "email"
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "email_text_field"
        return textField
    }()
    
    private lazy var passwordTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "password"
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "password_text_field"
        return textField
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = CGFloat(20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "button_stack_view"
        return stackView
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("sign in", for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "sign_in_button"
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("sign up", for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "sign_up_button"
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("forgot your password?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "forgot_password_button"
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
        signInStackView.addArrangedSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        buttonStackView.addArrangedSubview(signInButton)
        buttonStackView.addArrangedSubview(signUpButton)
        signInStackView.addArrangedSubview(buttonStackView)
        signInStackView.addArrangedSubview(forgotPasswordButton)
    }
    
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(signInStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(60)))
        constraints.append(signInStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(-60)))
        constraints.append(signInStackView.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(signInStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40))
        
        constraints.append(logoImageView.bottomAnchor.constraint(equalTo: textFieldStackView.topAnchor, constant: -50))
        
        constraints.append(emailTextField.heightAnchor.constraint(equalToConstant: CGFloat(30)))
        constraints.append(passwordTextField.heightAnchor.constraint(equalToConstant: CGFloat(30)))
        
        constraints.append(buttonStackView.leadingAnchor.constraint(equalTo: signInStackView.leadingAnchor, constant: 10))
        constraints.append(buttonStackView.trailingAnchor.constraint(equalTo: signInStackView.trailingAnchor, constant: -10))

                
        NSLayoutConstraint.activate(constraints)
    }
}

class PaddedTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
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
