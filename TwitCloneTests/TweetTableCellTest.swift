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
        let tweetCard = view.findViewByAccessibilityId("tweet_card") as? UIStackView
        let profileImageView = view.findViewByAccessibilityId("profile_image_view") as? UIImageView
        let bodyStackView = view.findViewByAccessibilityId("body_stack_view") as? UIStackView
        let headerStackView = view.findViewByAccessibilityId("header_stack_view") as? UIStackView
        let handleStackview = view.findViewByAccessibilityId("handle_stack_view") as? UIStackView
        let handelLabel = view.findViewByAccessibilityId("handel_label") as? UILabel
        let checkmarkImageView = view.findViewByAccessibilityId("checkmark_image_view") as? UIImageView
        let nameLabel = view.findViewByAccessibilityId("name_label") as? UILabel
        let tweetTimeLabel = view.findViewByAccessibilityId("tweet_time_label") as? UILabel
        let tweetTextLabel = view.findViewByAccessibilityId("tweetTextLabel") as? UILabel
        
        if let tweetStackView = tweetStackView, let tweetCard = tweetCard,
            let profileImageView = profileImageView, let bodyStackView = bodyStackView,
            let headerStackView = headerStackView, let handleStackView = handleStackview,
            let handelLabel = handelLabel, let checkmarkImageView = checkmarkImageView,
            let nameLabel = nameLabel, let tweetTimeLabel = tweetTimeLabel,
            let tweetTextLabel = tweetTextLabel {
            
            XCTAssertFalse(view.showCheckMark)
            
            XCTAssertEqual(tweetStackView.alignment, .top)
            XCTAssertEqual(tweetStackView.axis, .horizontal)
            XCTAssertEqual(tweetStackView.backgroundColor, .systemTeal)
            
            XCTAssertEqual(tweetCard.alignment, .top)
            XCTAssertEqual(tweetCard.axis, .horizontal)
            XCTAssertEqual(tweetStackView.layer.cornerRadius, 8)
            XCTAssert(tweetCard.layer.masksToBounds)
            XCTAssertEqual(tweetCard, UIColor.white)
            
            XCTAssertNotNil(profileImageView.image)
            
            XCTAssertEqual(bodyStackView.alignment, .top)
            XCTAssertEqual(bodyStackView.axis, .vertical)
            XCTAssertEqual(bodyStackView.distribution, .fillProportionally)
            
            XCTAssertEqual(headerStackView.alignment, .center)
            XCTAssertEqual(headerStackView.axis, .horizontal)
            XCTAssertEqual(headerStackView.distribution, .equalSpacing)
            XCTAssert(headerStackView.isLayoutMarginsRelativeArrangement)
            
            XCTAssertEqual(handleStackView.alignment, .fill)
            XCTAssertEqual(handleStackView.axis, .horizontal)
            XCTAssertEqual(handleStackview?.spacing, 5)
            
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
    
    func testFormatTweetTime() {
        let view = TweetTableViewCell()
        let mockTimeStamp = "Fri Apr 09 12:53:54 +0000 2020"
        
        let date1 = MockCurrentDate(year: 2021, month: 10, day: 31, hour: 9, minute: 54).getMockDateObject()
        let tweetTime1 = view.formatTweetTime(currentDate: date1, timeStamp: mockTimeStamp)
        XCTAssertEqual(tweetTime1, "1y")
        
        let date2 = MockCurrentDate(year: 2021, month: 1, day: 22, hour: 4, minute: 32).getMockDateObject()
        let tweetTime2 = view.formatTweetTime(currentDate: date2, timeStamp: mockTimeStamp)
        XCTAssertEqual(tweetTime2, "9mo")
        
        let date3 = MockCurrentDate(year: 2020, month: 4, day: 13, hour: 9, minute: 54).getMockDateObject()
        let tweetTime3 = view.formatTweetTime(currentDate: date3, timeStamp: mockTimeStamp)
        XCTAssertEqual(tweetTime3, "4d")
        
        let date4 = MockCurrentDate(year: 2020, month: 4, day: 09, hour: 9, minute: 54, second: 12).getMockDateObject()
        let tweetTime4 = view.formatTweetTime(currentDate: date4, timeStamp: mockTimeStamp)
        XCTAssertEqual(tweetTime4, "1h")
        
        let date5 = MockCurrentDate(year: 2020, month: 4, day: 09, hour: 9, minute: 00).getMockDateObject()
        let tweetTime5 = view.formatTweetTime(currentDate: date5, timeStamp: mockTimeStamp)
        XCTAssertEqual(tweetTime5, "6m")
        
        let date6 = MockCurrentDate(year: 2020, month: 4, day: 09, hour: 8, minute: 54, second: 12).getMockDateObject()
        let tweetTime6 = view.formatTweetTime(currentDate: date6, timeStamp: mockTimeStamp)
        XCTAssertEqual(tweetTime6, "18s")
    }
}

class MockCurrentDate {
    let dateComponents: DateComponents
    let calendar = Calendar(identifier: .gregorian)
    
    init(year: Int = 0, month: Int = 0, day: Int = 0, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        self.dateComponents = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    func getMockDateObject() -> Date {
        return calendar.date(from: dateComponents)!
    }
}
