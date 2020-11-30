import Keys
import Swifter
import UIKit

class FeedViewController: UIViewController {
    var swifter: Swifter
    let keys = TwitCloneKeys()
    let authViewModel: AuthorizationViewModel
    
    var tweetFeed: [TweetTableViewCell] = []
    
    lazy var  tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemTeal
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: "tweet_cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    init(authorizationViewModel: AuthorizationViewModel) {
        self.authViewModel = authorizationViewModel
        let oauthToken : String = UserDefaults.standard.value(forKey: "oauth_token") as! String
        let oauthTokenSecret : String  = UserDefaults.standard.value(forKey: "oauth_token_secret") as! String
        self.swifter = Swifter(consumerKey: authViewModel.clientKey, consumerSecret: authViewModel.secreteKey, oauthToken: oauthToken, oauthTokenSecret: oauthTokenSecret)
        super.init(nibName: nil, bundle: nil)
        self.getHomeTimeLine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = tableView.fill(superview: view)
        NSLayoutConstraint.activate(constraints)
    }
    
    func getHomeTimeLine() {
        swifter.getHomeTimeline(count: 10, success: { json in

            self.tweetFeed = []

            if let tweetData = json.array {
                for tweet in tweetData {

                    let tweetTableCell = TweetTableViewCell()

                    if let profileImageURL = tweet["user"]["profile_image_url_https"].string {
                        let imageUrlString = profileImageURL
                        let imageUrl = URL(string: imageUrlString)!
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
                        tweetTableCell.tweetTextView.text = text
                    }

                    if let time = tweet["user"]["created_at"].string {
                        tweetTableCell.tweetTimeLabel.text = time
                    }
                    self.tweetFeed.append(tweetTableCell)

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }, failure: { error in
            print(error.localizedDescription)
        })
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
        cell.tweetTimeLabel.text = "18m"
        cell.tweetTextView.text = tweetFeed[indexPath.row].tweetTextView.text

        if tweetFeed[indexPath.row].showCheckMark {
            cell.checkMarkImageView.isHidden = false
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
