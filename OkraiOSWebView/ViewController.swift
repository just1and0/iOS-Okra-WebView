//
//  ViewController.swift
//  iOSOkraWebView
//
//  Created by Oluwatobi Shokunbi on 19/11/2021.
//

import UIKit
import WebKit;

class ViewController: UIViewController {

    let  webview: WKWebView = {
        
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }()
    
    let short_url = ""
    
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
                  short_url: 'uOxqP-u9n',
                  onSuccess: function (data) {
                    // let response = {event: 'option success', data};
                    // window.ReactNativeWebView.postMessage(JSON.stringify(response));
                  },
                  onClose: function () {
                    // let response = {event: 'option close'};
                    // window.ReactNativeWebView.postMessage(JSON.stringify(response));
                  },
                });
              }
            </script>
          </body>
        </html>
    """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(webview) 
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        webview.frame = view.bounds
    }
}
