//
//  HeroTableViewController.swift
//  Dota2InTheBag
//
//  Created by Lu Lu on 9/6/15.
//  Copyright (c) 2015 Lu Lu. All rights reserved.
//

import UIKit

class HeroTableViewController: UITableViewController, UITableViewDelegate {
    
    var heroDatabase = SingletonDotaHeroDatabase.sharedInstance
    var heroType: String?
    var heroesOfCurrentType = [DotaHero]()
    var heroSelected: DotaHero?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load hero info.
        if heroType != nil {
          heroesOfCurrentType = heroDatabase.getHeroesOfType(heroType!)
        }
        
        tableView.estimatedRowHeight = 144

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return heroesOfCurrentType.count + 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HeroTableCell", forIndexPath: indexPath) as! HeroTableViewCell

        // Configure the cell...
        let row = indexPath.row
        if row < heroesOfCurrentType.count {
            cell.heroImage.image = UIImage(named: heroesOfCurrentType[row].imageURL)
            cell.heroNameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2)
            cell.heroNameLabel.text = heroesOfCurrentType[row].officialName
        } else {
            // Return button
            cell.heroImage.image = UIImage(named: "back.png")
            cell.heroNameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2)
            cell.heroNameLabel.text = "return to hero search"
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row < heroesOfCurrentType.count {
            heroSelected = heroesOfCurrentType[indexPath.row]
            self.performSegueWithIdentifier("returnedFromHeroTableToLineupSegue", sender: self)
        } else {
            heroSelected = nil
            self.performSegueWithIdentifier("returnedFromHeroTableToHeroSearchSegue", sender: self)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
