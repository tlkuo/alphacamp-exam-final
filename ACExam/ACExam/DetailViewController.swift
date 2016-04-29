//
//  DetailViewController.swift
//  ACExam
//
//  Created by martin on 2016/4/29.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var telButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!

    var detailItem: Book?

    func configureView() {
        // Update the user interface for the detail item.
        if let book = self.detailItem {
            nameLabel.text = book.name
            coverImageView.image = book.picture
            addressButton.setTitle("地址：\(book.address)", forState: .Normal)
            telButton.setTitle("電話：\(book.tel)", forState: .Normal)
            websiteButton.setTitle("網站：\(book.website)", forState: .Normal)
            descriptionLabel.text = book.description
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func phoneCall(sender: AnyObject) {

        if let book = detailItem {
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(book.tel)")!)
        }
    }

    @IBAction func openWebSite(sender: AnyObject) {

        if let book = detailItem {
            UIApplication.sharedApplication().openURL(book.website)
        }
    }

}

