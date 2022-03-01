//
//  ViewController.swift
//  WKWebViewDemoApp
//
//  Created by Raymond Kim on 3/4/18.
//  Copyright © 2018 Raymond Kim. All rights reserved.
//
import UIKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        // Add script message handlers that, when run, will make the function
        // window.webkit.messageHandlers.test.postMessage() available in all frames.
        userContentController.add(self, name: "test")
        
        config.userContentController = userContentController
        config.defaultWebpagePreferences = prefs

        let webView = WKWebView(frame: .zero, configuration: config)

        view.addSubview(webView)

        let layoutGuide = view.safeAreaLayoutGuide

        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true

        // Make sure in Info.plist you set `NSAllowsArbitraryLoads` to `YES` to load
        // URLs with an HTTP connection. You can run a local server easily with services
        // such as MAMP.
        
        let html_content = """
            <!DOCTYPE html>
            <html lang="en">
              <head>
                <meta charset="UTF-8" />
                <meta http-equiv="X-UA-Compatible" content="ie=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Okra React Native SDK</title>
              </head>
              <body
                onload="buildWithShortUrl()"
                style="background-color: #fff; height: 100vh"
              >
                <script src="https://cdn.okra.ng/v2/bundle.js"></script>
                <script type="text/javascript">
                  window.onload = buildWithShortUrl;
                  function buildWithShortUrl() {
                    Okra.buildWithShortUrl({
                      short_url: 'core-flow',
                      onSuccess: function (data) {
                     window.webkit.messageHandlers.test.postMessage({status:'success', response:data})
                      },
                      onClose: function () {
                                        window.webkit.messageHandlers.test.postMessage({status:'close', response:null})
                      },
                      onEvent: function(data){
                                                window.webkit.messageHandlers.test.postMessage({status:'onEvent', response:data})
                        }
                    });
                  }
                </script>
              </body>
            </html>
        """
        webView.loadHTMLString(html_content, baseURL: nil)
    }
}

extension ViewController: WKScriptMessageHandler {
    // Capture postMessage() calls inside loaded JavaScript from the webpage. Note that a Boolean
    // will be parsed as a 0 for false and 1 for true in the message's body. See WebKit documentation:
    // https://developer.apple.com/documentation/webkit/wkscriptmessage/1417901-body.
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
         print(">>>>>>>>>testing", message.body )
//        showUser(status: message.body)
//        if let data = message.body as? [String : String],
//
//             let response = data["response"], let status = data["status"] {
//            print(response)
//            print(status)
//            print(">>>>>>>>>uytrerrtyuiytr")
//          showUser(status: status, response: response)
//         }
    }

}
