import Keys
import Swifter

class AuthorizationViewModel {
    var clientKey = TwitCloneKeys().twitterAPIClientKey
    var secreteKey = TwitCloneKeys().twitterAPIClientSecret
    var accessToken: Credential.OAuthAccessToken?
    var twitterAccessToken = ""
}
