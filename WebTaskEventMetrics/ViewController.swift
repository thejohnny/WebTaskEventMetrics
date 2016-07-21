//
//  ViewController.swift
//  WebTaskEventMetrics
//
//  Created by John Carlin on 7/20/16.
//  Copyright © 2016 thejohnny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    let vendorId = UIDevice.currentDevice().identifierForVendor!.UUIDString as String

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(sender: UIButton) {
        var color: UIColor
        
        switch sender.tag {
        case 0:
            incrementMetric("button0Tapped")
            color = UIColor(red: 1, green: 229 / 255.0, blue: 134.0 / 255.0, alpha: 1)
        case 1:
            incrementMetric("button1Tapped")
            color = UIColor(red: 117.0 / 255.0, green: 202.0 / 255.0, blue: 1, alpha: 1)
        default:
            return
        }
        
        UIView.animateWithDuration(0.4) {
            self.view.backgroundColor = color
        }
    }

    func incrementMetric(metric: String) {
        let baseURL = NSURL(string: "https://webtask.it.auth0.com/api/run/wt-thejohnny-gmail_com-0/incrementMetric")
        let request = NSURLRequest(URL: NSURL(string: "?vendorId=\(vendorId)&metricName=\(metric)", relativeToURL: baseURL)!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let data = data {
                let response = NSString(data: data, encoding: NSUTF8StringEncoding)
                print(response)
            }
        }
        task.resume()
    }
}

