//
//  ViewController.swift
//  ExampleMac
//
//  Created by c on 2018/3/13.
//  Copyright © 2018年 Sedat Gökbek ÇİFTÇİ. All rights reserved.
//

import Cocoa
import SwiftIconFont

class ViewController: NSViewController {

    @IBOutlet weak var label: NSTextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        label?.font = NSFont.icon(from: .fontAwesome, ofSize: 17.0)
        label?.stringValue = String.fontAwesomeIcon("twitter")!

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

