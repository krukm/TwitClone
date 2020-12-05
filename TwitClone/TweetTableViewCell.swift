import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var showCheckMark: Bool = false
    
    private lazy var tweetStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.layer.cornerRadius = 8
        stackView.layer.masksToBounds = true
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "tweet_stack_view"
        return stackView
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(color: .lightGray)?.rounded?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
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
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "header_stack_view"
        return stackView
    }()
    
    lazy var handleLabel: UILabel = {
        let label = PaddedLabel(top: 0, left: 0, bottom: 0, right: 5)
        label.textAlignment = .right
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "handel_label"
        return label
    }()
    
    lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "twitter_verified")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "check_mark_image_view"
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = PaddedLabel(top: 5, left: 5, bottom: 5, right: 5)
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "name_label"
        return label
    }()
    
    lazy var tweetTimeLabel: UILabel = {
        let label = PaddedLabel(top: 5, left: 30, bottom: 5, right: 5)
        label.textAlignment = .right
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "tweet_time_label"
        return label
    }()
    
    lazy var tweetTextLabel: UILabel = {
        let label = PaddedLabel(top: 10, left: 0, bottom: 10, right: 15)
        label.font = label.font.withSize(18)
        label.numberOfLines = 0
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
        tweetStackView.addArrangedSubview(profileImageView)
        tweetStackView.addArrangedSubview(bodyStackView)
        bodyStackView.addArrangedSubview(headerStackView)
        bodyStackView.addArrangedSubview(tweetTextLabel)
        headerStackView.addArrangedSubview(handleLabel)
        headerStackView.addArrangedSubview(checkmarkImageView)
        headerStackView.addArrangedSubview(nameLabel)
        headerStackView.addArrangedSubview(tweetTimeLabel)
    }
    
    private func setupConstraints() {
        var constraints = tweetStackView.fill(superview: contentView, withLayoutMargins: true)
        
        constraints.append(checkmarkImageView.heightAnchor.constraint(equalToConstant: 20))
        constraints.append(checkmarkImageView.widthAnchor.constraint(equalToConstant: 20))
        
        constraints.append(tweetTextLabel.widthAnchor.constraint(equalTo: tweetStackView.widthAnchor, multiplier: 0.8))
        constraints.append(tweetTextLabel.trailingAnchor.constraint(equalTo: tweetStackView.trailingAnchor))
        
        constraints.append(headerStackView.widthAnchor.constraint(equalTo: tweetTextLabel.widthAnchor))
        
        NSLayoutConstraint.activate(constraints)
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
