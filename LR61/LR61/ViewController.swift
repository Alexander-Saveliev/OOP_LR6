//
//  ViewController.swift
//  LR61
//
//  Created by Marty on 19/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlText: UITextField!
    
    @IBOutlet weak var protocolLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var docLabel: UILabel!
    @IBOutlet weak var portLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func parseButtpnWasPressed(_ sender: UIButton) {
        protocolLabel.text = ""
        hostLabel.text     = ""
        docLabel.text      = ""
        portLabel.text     = ""
        errorLabel.text    = ""

        do {
            let parser = try HttpUrl(withUrl: urlText.text ?? "")
            protocolLabel.text = parser.urlProtocol.rawValue
            hostLabel.text = parser.urlHost
            docLabel.text  = parser.urlDoc
            portLabel.text = String(parser.urlPort)
        } catch HttpUrlError.incorrectUrl {
            errorLabel.text = "Incorrect URL"
        } catch HttpUrlError.incorrectPort(let port) {
            errorLabel.text = "Incorrect Port \(port)"
        } catch HttpUrlError.incorrectProtocol(let urlProtocol) {
            errorLabel.text = "Incorrect Protocol \(urlProtocol)"
        } catch HttpUrlError.incorrectHost {
            errorLabel.text = "Incorrect Host"
        } catch {
            errorLabel.text = "Unexpected error"
        }
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        urlText.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

