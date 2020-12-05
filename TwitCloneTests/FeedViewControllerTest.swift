@testable import TwitClone
import XCTest

class FeedViewControllerTest: XCTestCase {
    
    func testDeallocation() {
        assertObjectWillDealloc {
            let viewController = FeedViewController(authorizationViewModel: MockAuthorizationViewModel())
            return viewController
        }
    }
    
    func testViewProperties() {
        guard let view = FeedViewController(authorizationViewModel: MockAuthorizationViewModel()).view else {
            XCTFail("error locating main view")
            return
        }
        
        let tableView = view.findViewByAccessibilityId("table_view") as? UITableView
        
        if let tableview = tableView {
            XCTAssertEqual(tableview.estimatedRowHeight, 200)
            XCTAssertEqual(tableview.rowHeight, UITableView.automaticDimension)
            XCTAssertEqual(tableview.separatorStyle, .none)
            XCTAssertEqual(tableview.backgroundColor, .systemTeal)
        }
    }
}
