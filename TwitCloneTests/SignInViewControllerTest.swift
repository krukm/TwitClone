@testable import TwitClone
import XCTest

class SignInViewControllerTest: XCTestCase {
    
    func testDeallocation() {
        assertObjectWillDealloc {
            let viewController = SignInViewController(viewModel: MockAuthorizationViewModel())
            return viewController
        }
    }
}

class MockAuthorizationViewModel: AuthorizationViewModel {}
