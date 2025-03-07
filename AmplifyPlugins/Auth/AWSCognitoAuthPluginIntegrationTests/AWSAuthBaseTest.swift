//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import Amplify
import AWSCognitoAuthPlugin
@testable import AmplifyTestCommon

class AWSAuthBaseTest: XCTestCase {
    
    let networkTimeout = TimeInterval(10)
    var email = UUID().uuidString + "@" + UUID().uuidString + ".com"
    var email2 = UUID().uuidString + "@" + UUID().uuidString + ".com"
    
    let amplifyConfigurationFile = "testconfiguration/AWSCognitoAuthPluginIntegrationTests-amplifyconfiguration"
    let credentialsFile = "testconfiguration/AWSCognitoAuthPluginIntegrationTests-credentials"
    
    func initializeAmplify() {
        do {
            let credentialsConfiguration = try TestConfigHelper.retrieveCredentials(forResource: credentialsFile)
            email = credentialsConfiguration["test_email_1"] ?? email
            email2 = credentialsConfiguration["test_email_2"] ?? email2
            let configuration = try TestConfigHelper.retrieveAmplifyConfiguration(
                forResource: amplifyConfigurationFile)
            let authPlugin = AWSCognitoAuthPlugin()
            try Amplify.add(plugin: authPlugin)
            try Amplify.configure(configuration)
            print("Amplify configured with auth plugin")
        } catch {
            print(error)
            XCTFail("Failed to initialize Amplify with \(error)")
        }
    }
}
