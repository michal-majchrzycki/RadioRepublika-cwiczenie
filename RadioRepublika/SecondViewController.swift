import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    
    let cal = NSCalendar.currentCalendar()
    let fmt = NSDateFormatter()
    var countDays = [String]()
    
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fmt.dateFormat = "EEEE"
        fmt.locale = NSLocale(localeIdentifier: "pl_PL")
        
        var date = cal.startOfDayForDate(NSDate())
        
        while countDays.count < 7 {
        let weekDay = cal.component(.Weekday, fromDate: date)
            if weekDay != 0 {
                countDays.append(fmt.stringFromDate(date))
            }
            date = cal.dateByAddingUnit(.Day, value: 1, toDate: date, options: NSCalendarOptions(rawValue: 0))!
        }
        print(countDays)
        
        
       tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.navigationController?.navigationBar.clipsToBounds = true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        let swiftBlogs = [countDays[0] + " (dzisiaj)", [String](), countDays[1], [String](), countDays[2], [String](), countDays[3], [String](), countDays[4], [String](), countDays[5], [String](), countDays[6]]
        
        let tableBorderLeft: CGFloat = 50
        let tableBorderRight: CGFloat = 50
        
        var tableRect: CGRect = self.view.frame
        tableRect.origin.x += tableBorderLeft
        tableRect.size.width -= tableBorderLeft + tableBorderRight
        tableView.frame = tableRect
        
       if indexPath.row % 2 == 0 {
        cell.textLabel?.text = swiftBlogs[row] as? String
        cell.contentView.layer.borderColor = UIColor(
            red: 0/255.0,
            green: 24/255.0,
            blue: 136/255.0,
            alpha: 1.0).CGColor
        cell.contentView.layer.borderWidth = 1.5
        cell.contentView.layer.borderColor = UIColor(
            red: 0/255.0,
            green: 24/255.0,
            blue: 136/255.0,
            alpha: 1.0).CGColor
        cell.contentView.layer.cornerRadius = 15.0
        
        cell.textLabel!.highlightedTextColor = UIColor.redColor()
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = UIColor.clearColor()
        cell.selectedBackgroundView = myCustomSelectionColorView
        }
        else {
        cell.textLabel?.hidden = true
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = UIColor.clearColor()
        cell.selectedBackgroundView = myCustomSelectionColorView
            }
        return cell
    }


    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
        return 50.0
        }
        else {
            return 7.7
        }
    }
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.allowsSelection = true
        
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        let str: String = cell.textLabel!.text!
        
        if str.containsString("poniedziałek") {
            performSegueWithIdentifier("segueMonday", sender:self)
        }
        if str.containsString("wtorek") {
            performSegueWithIdentifier("segueTuesday", sender:self)
        }
        if str.containsString("środa") {
            performSegueWithIdentifier("segueWednesday", sender:self)
        }
        if str.containsString("czwartek") {
            performSegueWithIdentifier("segueThursday", sender:self)
        }
        if str.containsString("piątek") {
            performSegueWithIdentifier("segueFriday", sender:self)
        }
        if str.containsString("sobota") {
            performSegueWithIdentifier("segueSaturday", sender:self)
        }
        if str.containsString("niedziela") {
            performSegueWithIdentifier("segueSunday", sender:self)
        }
        else {
            print("nothing")
        }
}
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueMonday" {
            if let mondayViewController = segue.destinationViewController as? MondayViewController {
                mondayViewController.self.nameBar = "Poniedziałek"
                mondayViewController.self.parseSender = NSXMLParser(contentsOfURL:(NSURL(string:"https://dl.dropboxusercontent.com/s/a9nyq2xs2frunke/poniedzialek.rss"))!)!
            }
        }
        if segue.identifier == "segueTuesday" {
            if let mondayViewController = segue.destinationViewController as? MondayViewController {
                mondayViewController.self.nameBar = "Wtorek"
                mondayViewController.self.parseSender = NSXMLParser(contentsOfURL:(NSURL(string:"https://dl.dropboxusercontent.com/s/0om3efefa8aidj4/wtorek.rss"))!)!
            }
        }
        if segue.identifier == "segueWednesday" {
            if let mondayViewController = segue.destinationViewController as? MondayViewController {
                mondayViewController.self.nameBar = "Środa"
                mondayViewController.self.parseSender = NSXMLParser(contentsOfURL:(NSURL(string:"https://dl.dropboxusercontent.com/s/f9voh3h78t9oi05/sroda.rss"))!)!
            }
        }
        if segue.identifier == "segueThursday" {
            if let mondayViewController = segue.destinationViewController as? MondayViewController {
                mondayViewController.self.nameBar = "Czwartek"
                mondayViewController.self.parseSender = NSXMLParser(contentsOfURL:(NSURL(string:"https://dl.dropboxusercontent.com/s/xzl1bx0z58q33aq/czwartek.rss"))!)!
            }
        }
        if segue.identifier == "segueFriday" {
            if let mondayViewController = segue.destinationViewController as? MondayViewController {
                mondayViewController.self.nameBar = "Piątek"
                mondayViewController.self.parseSender = NSXMLParser(contentsOfURL:(NSURL(string:"https://dl.dropboxusercontent.com/s/3vujp9gompwi7sa/piatek.rss"))!)!
            }
        }
        if segue.identifier == "segueSaturday" {
            if let mondayViewController = segue.destinationViewController as? MondayViewController {
                mondayViewController.self.nameBar = "Sobota"
                mondayViewController.self.parseSender = NSXMLParser(contentsOfURL:(NSURL(string:"https://dl.dropboxusercontent.com/s/4uyfd8zm2i64uuz/sobota.rss"))!)!
            }
        }
        if segue.identifier == "segueSunday" {
            if let mondayViewController = segue.destinationViewController as? MondayViewController {
                mondayViewController.self.nameBar = "Niedziela"
                mondayViewController.self.parseSender = NSXMLParser(contentsOfURL:(NSURL(string:"https://dl.dropboxusercontent.com/s/9dnzho5t2zebq2b/niedziela.rss"))!)!
            }
        }
    }
}
