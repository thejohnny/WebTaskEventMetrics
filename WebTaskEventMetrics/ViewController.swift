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
        switch sender.tag {
        case 0:
            incrementMetric("button1Tapped")
        case 1:
            incrementMetric("button2Tapped")
        default:
            return
        }
    }

    func incrementMetric(metric: String) {
        let baseURL = NSURL(string: "http://localhost:8080/")
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

