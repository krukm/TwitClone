import Keys
import Swifter
import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate {
    var swifter: Swifter
    let keys = TwitCloneKeys()
    let authViewModel: AuthorizationViewModel
    
    var tweetFeed: [TweetTableViewCell] = []
    private var isLoading: Bool = false
    
    lazy var  tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemTeal
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: "tweet_cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    init(authorizationViewModel: AuthorizationViewModel) {
        self.authViewModel = authorizationViewModel
        let oauthToken : String = UserDefaults.standard.value(forKey: "oauth_token") as! String
        let oauthTokenSecret : String  = UserDefaults.standard.value(forKey: "oauth_token_secret") as! String
        self.swifter = Swifter(consumerKey: authViewModel.clientKey, consumerSecret: authViewModel.secreteKey, oauthToken: oauthToken, oauthTokenSecret: oauthTokenSecret)
        super.init(nibName: nil, bundle: nil)
        self.getHomeTimeLine() { }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        let constraints = tableView.fill(superview: view)
        NSLayoutConstraint.activate(constraints)
    }
    
    func getHomeTimeLine(completion: () -> ()?) {
        swifter.getHomeTimeline(count: 10, success: { [weak self] json in
            
            var tempTweetFeed = [TweetTableViewCell]()

            if let tweetData = json.array {
                for tweet in tweetData {

                    let tweetTableCell = TweetTableViewCell()

                    if let profileImageURL = tweet["user"]["profile_image_url_https"].string {
                        let imageUrlString = profileImageURL
                        guard let imageUrl = URL(string: imageUrlString) else { return }
                        let image = try? UIImage(withContentsOfUrl: imageUrl)
                        tweetTableCell.profileImageView.image = image?.rounded?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
                    }

                    if let name = tweet["user"]["screen_name"].string {
                        tweetTableCell.nameLabel.text = name
                    }

                    if let checkMark = tweet["user"]["verified"].bool {
                        tweetTableCell.showCheckMark = checkMark
                    }

                    if let handle = tweet["user"]["name"].string {
                        tweetTableCell.handleLabel.text = handle
                    }

                    if let text = tweet["text"].string {
                        let string = tweetTableCell.limitStringLength(text, length: 280)
                        tweetTableCell.tweetTextLabel.text = string
                    }

                    if let time = tweet["created_at"].string {
                        let string = tweetTableCell.formatTweetTime(currentDate: Date(), timeStamp: time)
                        let timeString = tweetTableCell.limitStringLength(string, length: 4)
                        tweetTableCell.tweetTimeLabel.text = timeString
                    }
                    tempTweetFeed.append(tweetTableCell)
                }
            }
            
            self?.tweetFeed.append(contentsOf: tempTweetFeed)
            self?.isLoading = false
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isLoading {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if (scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                tableView.tableFooterView = loadSpinner()
                isLoading = true
                getHomeTimeLine() { tableView.tableFooterView = nil }
            }
        }
    }
    
    private func loadSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweet_cell", for: indexPath) as! TweetTableViewCell
        cell.profileImageView.image = tweetFeed[indexPath.row].profileImageView.image
        cell.handleLabel.text = tweetFeed[indexPath.row].handleLabel.text
        cell.nameLabel.text = tweetFeed[indexPath.row].nameLabel.text
        cell.tweetTimeLabel.text = tweetFeed[indexPath.row].tweetTimeLabel.text
        cell.tweetTextLabel.text = tweetFeed[indexPath.row].tweetTextLabel.text

        if tweetFeed[indexPath.row].showCheckMark {
            cell.checkmarkImageView.isHidden = false
        }

        return cell
    }
}

extension UIImage {
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
        
        self.init(data: imageData)
    }
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 15, height: 15)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
