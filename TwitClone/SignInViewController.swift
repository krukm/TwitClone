import SafariServices
import Swifter
import UIKit

class SignInViewController: UIViewController, SFSafariViewControllerDelegate {
    var swifter: Swifter?
    private var viewModel: AuthorizationViewModel
    
    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let signInView = SignInView()
        view = signInView
        signInView.signInButton.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
    }
    
    @objc private func signInButtonAction() {
        guard let url = URL(string: "TwitClone://") else { return }
        self.swifter = Swifter(consumerKey: viewModel.clientKey, consumerSecret: viewModel.secreteKey)
        self.swifter?.authorize(withCallback: url, presentingFrom: self, success: { accessToken, _ in
            self.viewModel.accessToken = accessToken
            self.authorizeUser()
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    func authorizeUser() {
        
        self.swifter?.verifyAccountCredentials(includeEntities: false, skipStatus: false, includeEmail: true, success: { json in
            self.viewModel.twitterAccessToken = self.viewModel.accessToken?.key ?? "No access key exists"
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.viewModel.accessToken?.key, forKey: "oauth_token")
            userDefaults.set(self.viewModel.accessToken?.secret, forKey: "oauth_token_secret")

            let nextViewController = FeedViewController(authorizationViewModel: self.viewModel)
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
}
