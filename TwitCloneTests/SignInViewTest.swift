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
        let signInButton = view.findViewByAccessibilityId("sign_in_buton") as? UIButton
        
        
        if let signInStackView = signInStackView, let logoImageView = logoImageView, let signInButton = signInButton {
            XCTAssertEqual(signInStackView.alignment, UIStackView.Alignment.fill)
            XCTAssertEqual(signInStackView.axis, NSLayoutConstraint.Axis.vertical)
            XCTAssertEqual(signInStackView.distribution, UIStackView.Distribution.equalCentering)
            XCTAssertEqual(signInStackView.spacing, CGFloat(20))
            XCTAssertNil(signInStackView.backgroundColor)
            
            XCTAssertNotNil(logoImageView.image)
            XCTAssertEqual(logoImageView.contentMode, UIImageView.ContentMode.scaleAspectFit)
            
            XCTAssertEqual(signInButton.backgroundColor, .white)
            XCTAssertEqual(signInButton.titleColor(for: .normal), .darkGray)
            XCTAssertEqual(signInButton.titleLabel?.text, "sign in")
            XCTAssertEqual(signInButton.layer.cornerRadius, 5)
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
