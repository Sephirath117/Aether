//
//  QuestionViewController.swift
//  Aether
//
//  Created by Rohan on 6/20/15.
//  Copyright (c) 2015 karohan. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var ref = Firebase(url: "https://aetherbase.firebaseio.com")
    var text:String = ""
    
    @IBOutlet var textBox: UITextView!
    @IBOutlet var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.borderColor = (UIColor.whiteColor()).CGColor
        println()
        //var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        //view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitAction(sender: UIButton) {
        //add verification
        text = textBox.text
        
        if(text != ""){
            var nref = ref.childByAppendingPath("allQuestions").childByAppendingPath(text).childByAppendingPath("text")
            nref.setValue(text)
            
            mainInstance.myQs.append(text)
            //performSegueWithIdentifier("returnToView", sender: self)
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                println("done")
            })
        }
        
        
    }
    
    //func DismissKeyboard(){
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        textBox.endEditing(true)

    }
        //Causes the view (or one of its embedded text fields) to resign the first responder status.

    @IBAction func backButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    

}
