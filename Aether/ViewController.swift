//
//  ViewController.swift
//  Aether
//
//  Created by Rohan on 6/20/15.
//  Copyright (c) 2015 karohan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var questionView: UITableView!
    let textCellIdentifier = "QuestionCell"
    var swiftBlogs:[String] = [String]()
    var row = 0
    var ref = Firebase(url: "https://aetherbase.firebaseio.com")
    var first:Bool!
    
    var refreshCount = 0
    
    
    @IBOutlet weak var segControl: UISegmentedControl!
    
    var refreshControl = UIRefreshControl()
    
    
    override func viewWillAppear(animated: Bool) {
        //refreshCount = 0
       
        //refreshControl.beginRefreshing()
        swiftBlogs.removeAll(keepCapacity: false)
        swiftBlogs = ["Swipe down to refresh."]
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        if(!first){
            //NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "refresh:", userInfo: nil, repeats: true)
            first = true
        }
    }
    
    func refresh1(){
        //if(refreshCount < 5){
            //refresh(refreshControl)
            refreshCount++
        //}
        
    }
    
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftBlogs = [String]()
        first = false
        NSTimer.scheduledTimerWithTimeInterval(0.00001, target: self, selector: "reloadData", userInfo: nil, repeats: true)
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        if(questionView != nil){
        questionView.addSubview(refreshControl)
            segControl.selectedSegmentIndex = 0
        
        questionView.dataSource = self
        questionView.delegate = self
        }
        
        
        println("urmom");
        //refresh(refreshControl)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData(){
        if(questionView != nil){
            questionView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        row = indexPath.row
        
        
        
        mainInstance.question = swiftBlogs[row]
        self.performSegueWithIdentifier("moveToQ", sender: self)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftBlogs.count
    }
    
    func refresh(refreshControl: UIRefreshControl){
        swiftBlogs.removeAll(keepCapacity: false)
        //swiftBlogs = [String]()
        
        var readRef = ref.childByAppendingPath("allQuestions")
        var count = 0
        readRef.observeEventType(.Value, withBlock: { snapshot in
            for child in snapshot.children.allObjects as! [FDataSnapshot] {
                if(count < (snapshot.children.allObjects as! [FDataSnapshot]).count){
                    
                    self.swiftBlogs.append(child.key as! String)
                    //println(child.key)
                    count++
                }
            }
            
        })
        
        self.refreshControl.endRefreshing()
        
        
        
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.backgroundColor = UIColor(red: 52/255.0 , green: 73/255.0, blue: 94/255.0, alpha: 1.0)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        let row = indexPath.row
        if(row < swiftBlogs.count){
            cell.textLabel?.text = swiftBlogs[row]
        }
        
        return cell
    }
    
    @IBAction func indexChanged(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            break;
        case 1:
            self.performSegueWithIdentifier("moveToMyQs", sender: self)
            break;
        default:
            break;
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "moveToQ"){
        var answerRef = ref.childByAppendingPath("allQuestions").childByAppendingPath(swiftBlogs[row]).childByAppendingPath("answers")
        
        answerRef.observeEventType(.Value, withBlock: { snapshot in
            for child in snapshot.children.allObjects as! [FDataSnapshot] {
                mainInstance.answers.append(child.value as! String)
                println(child.value)
            }
            
        })
        
        mainInstance.question = swiftBlogs[row]
        }

    }
    
    


}

