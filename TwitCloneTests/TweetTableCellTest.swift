@testable import TwitClone
import XCTest

class TweetTableCellTest: XCTestCase {
    
    func testDeallocation() {
        assertObjectWillDealloc {
            let view = TweetTableViewCell()
            view.frame = CGRect(x: 0.0, y: 0.0, width: 320.0, height: 150.0)
            return view
        }
    }
    
    func testViewProperties() {
        let view = TweetTableViewCell()
        let tweetStackView = view.findViewByAccessibilityId("tweet_stack_view") as? UIStackView
        let profileImageView = view.findViewByAccessibilityId("profile_image_view") as? UIImageView
        let bodyStackView = view.findViewByAccessibilityId("body_stack_view") as? UIStackView
        let headerStackView = view.findViewByAccessibilityId("header_stack_view") as? UIStackView
        let handelLabel = view.findViewByAccessibilityId("handel_label") as? UILabel
        let checkmarkImageView = view.findViewByAccessibilityId("checkmark_image_view") as? UIImageView
        let nameLabel = view.findViewByAccessibilityId("name_label") as? UILabel
        let tweetTimeLabel = view.findViewByAccessibilityId("tweet_time_label") as? UILabel
        let tweetTextLabel = view.findViewByAccessibilityId("tweetTextLabel") as? UILabel
        
        if let tweetStackView = tweetStackView, let profileImageView = profileImageView,
           let bodyStackView = bodyStackView, let headerStackView = headerStackView,
           let handelLabel = handelLabel, let checkmarkImageView = checkmarkImageView,
           let nameLabel = nameLabel, let tweetTimeLabel = tweetTimeLabel,
           let tweetTextLabel = tweetTextLabel {
            
            XCTAssertFalse(view.showCheckMark)
            
            XCTAssertEqual(tweetStackView.alignment, .top)
            XCTAssertEqual(tweetStackView.axis, .horizontal)
            XCTAssertEqual(tweetStackView.layer.cornerRadius, 8)
            XCTAssert(tweetStackView.layer.masksToBounds)
            XCTAssertEqual(tweetStackView, UIColor.white)
            
            XCTAssertNotNil(profileImageView.image)
            
            XCTAssertEqual(bodyStackView.alignment, .top)
            XCTAssertEqual(bodyStackView.axis, .vertical)
            XCTAssertEqual(bodyStackView.distribution, .fillProportionally)
            XCTAssertEqual(headerStackView.alignment, .center)
            XCTAssertEqual(headerStackView.axis, .horizontal)
            XCTAssertEqual(headerStackView.distribution, .equalSpacing)
            XCTAssert(headerStackView.isLayoutMarginsRelativeArrangement)
            
            XCTAssertEqual(handelLabel.textAlignment, .right)
            XCTAssertEqual(handelLabel.font.pointSize, 14)
            
            XCTAssertNotNil(checkmarkImageView.image)
            XCTAssert(checkmarkImageView.isHidden)
            
            XCTAssertEqual(nameLabel.font.pointSize, 12)
            
            XCTAssertEqual(tweetTimeLabel.textAlignment, .right)
            XCTAssertEqual(tweetTimeLabel.font.pointSize, 12)
            
            XCTAssertEqual(tweetTextLabel.font.pointSize, 12)
            XCTAssertEqual(tweetTextLabel.numberOfLines, 0)
        }
    }
}
