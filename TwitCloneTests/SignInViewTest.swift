@testable import TwitClone
import Foundation
import XCTest

class SignInViewTest: XCTestCase {
 
    func testDeallocation() {
        assertObjectWillDealloc {
            let view = SignInView()
            view.frame = CGRect(x: 0.0, y: 0.0, width: 320.0, height: 150.0)
            return view
        }
    }
    
    func testViewProperties() {
        let view = SignInView()
        let signInStackView = view.findViewByAccessibilityId("sign_in_stack_view") as? UIStackView
        let logoImageView = view.findViewByAccessibilityId("logo_image_view") as? UIImageView
        let textFieldStackView = view.findViewByAccessibilityId("text_field_stack_view") as? UIStackView
        let emailTextField = view.findViewByAccessibilityId("email_text_field") as? PaddedTextField
        let passwordTextField = view.findViewByAccessibilityId("password_text_field") as? PaddedTextField
        let buttonStackView = view.findViewByAccessibilityId("button_stack_view") as? UIStackView
        let signInButton = view.findViewByAccessibilityId("sign_in_buton") as? UIButton
        let signUpButton = view.findViewByAccessibilityId("sign_up_button") as? UIButton
        let forgotPasswordButton = view.findViewByAccessibilityId("forgot_password_button") as? UIButton
        
        
        if let signInStackView = signInStackView, let logoImageView = logoImageView, let textFieldStackView = textFieldStackView, let emailTextField = emailTextField, let paswordTextField = passwordTextField, let buttonStackView = buttonStackView, let signInButton = signInButton, let signUpButton = signUpButton {
            XCTAssertEqual(signInStackView.alignment, UIStackView.Alignment.fill)
            XCTAssertEqual(signInStackView.axis, NSLayoutConstraint.Axis.vertical)
            XCTAssertEqual(signInStackView.distribution, UIStackView.Distribution.equalCentering)
            XCTAssertEqual(signInStackView.spacing, CGFloat(20))
            XCTAssertNil(signInStackView.backgroundColor)
            
            XCTAssertNotNil(logoImageView.image)
            XCTAssertEqual(logoImageView.contentMode, UIImageView.ContentMode.scaleAspectFit)
            
            XCTAssertEqual(textFieldStackView.alignment, UIStackView.Alignment.fill)
            XCTAssertEqual(textFieldStackView.axis, NSLayoutConstraint.Axis.vertical)
            XCTAssertEqual(textFieldStackView.distribution, UIStackView.Distribution.equalSpacing)
            XCTAssertEqual(textFieldStackView.spacing, CGFloat(10))
            XCTAssertNil(textFieldStackView.backgroundColor)
            
            XCTAssertEqual(emailTextField.placeholder, "email")
            XCTAssertEqual(emailTextField.backgroundColor, .white)
            XCTAssertEqual(emailTextField.layer.cornerRadius, 5)
            XCTAssert(emailTextField.clipsToBounds)
            
            XCTAssertEqual(paswordTextField.placeholder, "password")
            XCTAssertEqual(paswordTextField.layer.cornerRadius, 5)
            XCTAssert(paswordTextField.clipsToBounds)
            
            XCTAssertEqual(buttonStackView.alignment, UIStackView.Alignment.center)
            XCTAssertEqual(buttonStackView.axis, NSLayoutConstraint.Axis.horizontal)
            XCTAssertEqual(buttonStackView.distribution, UIStackView.Distribution.fillEqually)
            XCTAssertEqual(buttonStackView.spacing, CGFloat(20))
            
            XCTAssertEqual(signInButton.backgroundColor, .white)
            XCTAssertEqual(signInButton.titleColor(for: .normal), .darkGray)
            XCTAssertEqual(signInButton.titleLabel?.text, "sign in")
            XCTAssertEqual(signInButton.layer.cornerRadius, 5)
            
            XCTAssertEqual(signUpButton.backgroundColor, .white)
            XCTAssertEqual(signUpButton.titleColor(for: .normal), .darkGray)
            XCTAssertEqual(signUpButton.titleLabel?.text, "sign up")
            XCTAssertEqual(signUpButton.layer.cornerRadius, 5)
            
            XCTAssertEqual(forgotPasswordButton?.titleLabel?.text, "forgot your password")
        }
        
    }
}

extension XCTestCase {
    public func assertObjectWillDealloc(_ file: StaticString = #file, line: UInt = #line, createObject: () -> AnyObject) {
        weak var weakReference: AnyObject?
        
        autoreleasepool {
            let strongReference = createObject()
            if let viewController = strongReference as? UIViewController {
                _ = viewController.view
            }
            weakReference = strongReference
        }
        
        XCTAssertNil(weakReference, "weak reference not cleaned up, there may be a retain cycle", file: file, line: line)
    }
}

extension UIView {
    func findViewByAccessibilityId(_ identifier: String) -> UIView? {
        guard !identifier.isEmpty else { return nil }
        
        if accessibilityIdentifier == identifier {
            return self
        }
        
        for subview in subviews {
            if let id = subview.findViewByAccessibilityId(identifier) {
                return id
            }
        }
        return nil
    }
}
