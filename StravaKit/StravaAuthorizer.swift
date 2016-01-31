
public struct StravaAuthorizer {

    let clientId: String
    let clientSecret: String
    private let template = StravaAuthorizationTemplate()
}

public extension StravaAuthorizer {

    func requestAccessWithRedirectURL(url: String) {
        UIApplication.sharedApplication().openURL(template.requestAccess(clientId: clientId, redirectUri: url).URL!)
    }

    func exchangeTokenWithAuthorizationCode(authorizationCode: String, onSuccess successHandler: (String) -> ()) {
        let parameters = Parameters()
            .add("client_id", clientId)
            .add("client_secret", clientSecret)
            .add("code", authorizationCode)

        Request<(String, Athlete)>(method: .POST, url: template.exchangeToken(), parameters: parameters) { json in
                return (json["access_token"].string!, json["athlete"].athlete)
            }
            .onSuccess { accessToken, athlete in
                successHandler(accessToken)
            }
    }
}