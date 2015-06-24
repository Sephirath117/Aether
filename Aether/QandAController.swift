//
//  QandAController.swift
//  
//
//  Created by Karan Mehta on 6/21/15.
//
//

import UIKit

class QandAController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let textCellIdentifier = "AnswerCell"
    
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet var textBox: UITextField!
    
    @IBOutlet var answerView: UITableView!
    
    @IBOutlet var questionLabel1: UILabel!
    
    var ref = Firebase(url: "https://aetherbase.firebaseio.com")
    
    var question = ""
    var answers:[String]!
    var refreshControl = UIRefreshControl()
    
    var first:Bool!
    override func viewWillAppear(animated: Bool) {
        //refreshCount = 0
        
        //refreshControl.beginRefreshing()
        //answers.removeAll(keepCapacity: false)
        answers = ["Swipe down to refresh."]
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        if(!first){
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "refresh:", userInfo: nil, repeats: true)
            first = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        first = false
        
        answers = [String]()
        submitButton.layer.borderColor = UIColor.whiteColor().CGColor
        submitButton.layer.borderWidth = 1
        submitButton.layer.cornerRadius = 10
        question = mainInstance.question
        questionLabel1.text = question
        
        answerView.dataSource = self
        answerView.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        //refresh(refreshControl)
        
        //CControl)
        
        answerView.addSubview(refreshControl)
        
        answers = mainInstance.answers
        println(answers)
        NSTimer.scheduledTimerWithTimeInterval(0.00001, target: self, selector: "reloadData", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        textBox.endEditing(true)
        
    }
    
    func refresh(refreshControl: UIRefreshControl){
        answers = [String]()
        answers.removeAll(keepCapacity: false)
        
        var answerRef = ref.childByAppendingPath("allQuestions").childByAppendingPath(question).childByAppendingPath("answers")
        var count = 0
        answerRef.observeEventType(.Value, withBlock: { snapshot in
            for child in snapshot.children.allObjects as! [FDataSnapshot] {
                if(count < (snapshot.children.allObjects as! [FDataSnapshot]).count){
                    
                    self.answers.append(child.value as! String)
                    println(child.value)
                    count++
                }
                
            }
            
            
        })
        
        //self.answers.removeAtIndex(0)
        //answerRef.removeAllObservers()
        
        self.refreshControl.endRefreshing()
    }
    
    
    func reloadData(){
        answerView.reloadData()
    }

    @IBAction func submitButtonAction(sender: UIButton) {
       var answerRef = ref.childByAppendingPath("allQuestions").childByAppendingPath(question).childByAppendingPath("answers").childByAutoId()
        if(textBox.text != ""){
            answerRef.setValue(textBox.text)
            textBox.text = ""
        }
        refresh(refreshControl)
        NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "dismissView", userInfo: nil, repeats: true)
    }
    
    func dismissView(){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        
    }
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.preservesSuperviewLayoutMargins = false
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        let row = indexPath.row
        if(row < answers.count){
            cell.textLabel?.text = answers[row]
        }
        
        
        return cell
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
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
