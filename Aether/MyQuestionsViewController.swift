//
//  MyQuestionsViewController.swift
//  Aether
//
//  Created by Karan Mehta on 6/21/15.
//  Copyright (c) 2015 karohan. All rights reserved.
//

import UIKit

class MyQuestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var questionView: UITableView!
    let textCellIdentifier = "QuestionCell"
    
    
    var first = false
    var myBlogs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionView.dataSource = self
        questionView.delegate = self
        myBlogs = mainInstance.myQs
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func reloadData(){
        if(questionView != nil){
            questionView.reloadData()
        }
        questionView.reloadData()
            println(myBlogs.count)
            //println(myBlogs[0])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        mainInstance.question = myBlogs[row]
        self.performSegueWithIdentifier("moveMyToQ", sender: self)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return myBlogs.count
    }
    
    
        
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.preservesSuperviewLayoutMargins = false
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        let row = indexPath.row
        cell.textLabel?.text = myBlogs[row]
            
        
        return cell
    }
    
    @IBAction func indexChanged(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            sender.selectedSegmentIndex = 0
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                println("ur mom")
            })
            
            break;
        case 1:
            break;
        default:
            break;
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
