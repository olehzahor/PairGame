//
//  WebViewController.swift
//  PairGame
//
//  Created by jjurlits on 4/29/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, Storyboarded, Coordinated {
    weak var coordinator: Coordinator?
    var url: URL? = URL(string: webViewUrl)
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var goForwardButton: UIButton!
    
    @IBOutlet weak var webView: WKWebView! {
        didSet { webView.navigationDelegate = self }
    }
    @IBAction func navigateBack(_ sender: Any) {
        coordinator?.navigateBack()
    }
    
    @IBAction func navigateBackInWebView(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func navigateForwardInBackView(_ sender: Any) {
        webView.goForward()
    }
    
    private func setupButtons() {
        goBackButton.isEnabled = webView.canGoBack
        goForwardButton.isEnabled = webView.canGoForward
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            webView.load(URLRequest(url: url))
        }
        setupButtons()
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
        setupButtons()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinner.startAnimating()
    }
}
