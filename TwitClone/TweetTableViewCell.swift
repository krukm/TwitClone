import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var showCheckMark: Bool = false
    
    private lazy var tweetStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemTeal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "tweet_stack_view"
        return stackView
    }()
    
    private lazy var tweetCard: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.layoutMargins = equalEdgeInsets(inset: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 8
        stackView.layer.masksToBounds = true
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "tweet_card"
        return stackView
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(color: .lightGray)?.rounded?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: 0))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "profile_image_view"
        return imageView
    }()
    
    private lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .top
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "body_stack_view"
        return stackView
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 2, bottom: 10, right: 2)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "header_stack_view"
        return stackView
    }()
    
    lazy var handleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "handle_stack_view"
        return stackView
    }()
    
    lazy var handleLabel: UILabel = {
        let label = UILabel()
        label.font.withSize(12)
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "handel_label"
        return label
    }()
    
    lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "twitter_verified")
        imageView.isHidden = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "check_mark_image_view"
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font.withSize(10)
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "name_label"
        return label
    }()
    
    lazy var tweetTimeLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "tweet_time_label"
        return label
    }()
    
    lazy var tweetTextLabel: UILabel = {
        let label = PaddedLabel(top: 0, left: 0, bottom: 8, right: 5)
        label.font = label.font.withSize(16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "tweet_text_label"
        return label
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupViews()
        setupConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemTeal
        contentView.addSubview(tweetStackView)
        tweetStackView.addSubview(tweetCard)
        tweetCard.addArrangedSubview(profileImageView)
        tweetCard.addArrangedSubview(bodyStackView)
        bodyStackView.addArrangedSubview(headerStackView)
        bodyStackView.addArrangedSubview(tweetTextLabel)
        handleStackView.addArrangedSubview(handleLabel)
        handleStackView.addArrangedSubview(checkmarkImageView)
        headerStackView.addArrangedSubview(handleStackView)
        headerStackView.addArrangedSubview(nameLabel)
        headerStackView.addArrangedSubview(tweetTimeLabel)
        
        handleLabel.sizeToFit()
        nameLabel.sizeToFit()
    }
    
    private func setupConstraints() {
        var constraints = tweetStackView.fill(superview: contentView)
        
        constraints.append(tweetCard.leadingAnchor.constraint(equalTo: tweetStackView.leadingAnchor, constant: 10))
        constraints.append(tweetCard.trailingAnchor.constraint(equalTo: tweetStackView.trailingAnchor, constant: -10))
        constraints.append(tweetCard.topAnchor.constraint(equalTo: tweetStackView.topAnchor, constant: 10))
        constraints.append(tweetCard.bottomAnchor.constraint(equalTo: tweetStackView.bottomAnchor, constant: -10))

        
        constraints.append(headerStackView.leadingAnchor.constraint(greaterThanOrEqualTo: bodyStackView.leadingAnchor))
        constraints.append(headerStackView.trailingAnchor.constraint(equalTo: bodyStackView.trailingAnchor))
        constraints.append(headerStackView.widthAnchor.constraint(equalTo: bodyStackView.widthAnchor))
        
        constraints.append(handleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 14))
        
        constraints.append(checkmarkImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 14))
        constraints.append(checkmarkImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 14))
                                        
        constraints.append(tweetTextLabel.widthAnchor.constraint(equalTo: tweetCard.widthAnchor, multiplier: 0.85))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    public func limitStringLength(_ string: String, length: Int) -> String {
        let nsString = string as NSString
        if nsString.length >= length {
            return nsString.substring(with: NSRange(location: 0, length: length))
        } else {
            return string
        }
    }
    
    public func formatTweetTime(currentDate: Date, timeStamp: String?) -> String {
        if let twitterTimeStamp = timeStamp {
            let twitterDateFormatter = DateFormatter()
            twitterDateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
            twitterDateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let currentCalendar = Calendar.current
            let currentCalendarComponents = currentCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentDate)
            
            if let date = twitterDateFormatter.date(from: twitterTimeStamp) {
                let userCalendarDate = Calendar.current
                let userCalendarComponent = userCalendarDate.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                
                
                let dateComponentdiff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: userCalendarComponent, to: currentCalendarComponents)
                guard let year = dateComponentdiff.year else { return "a" }
                guard let month = dateComponentdiff.month else { return "b" }
                guard let day = dateComponentdiff.day else { return "c" }
                guard let hour = dateComponentdiff.hour else { return "d" }
                guard let minute = dateComponentdiff.minute else { return "e" }
                guard let second = dateComponentdiff.second else { return "f" }
                
                if year == 0 && month == 0 && day == 0 && hour == 0 && minute == 0 {
                    return "\(String(second))s"
                } else if year == 0 && month == 0 && day == 0 && hour == 0 {
                    return "\(String(minute))m"
                } else if year == 0 && month == 0 && day == 0 {
                    return "\(String(hour))h"
                } else if year == 0 && month == 0 {
                    return "\(String(day))d"
                } else if year == 0 {
                    return "\(String(month))mo"
                } else {
                    return "\(String(year))y"
                }
            }
        }
        return "g"
    }
}

class PaddedLabel: UILabel {
    
    var padding: UIEdgeInsets
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let height = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
    
    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
