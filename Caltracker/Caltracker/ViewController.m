//
//  ViewController.m
//  Innergy
//
//  Created by Nave's on 06/12/14.
//  Copyright (c) 2014 HPM. All rights reserved.
//

#import "ViewController.h"
#import "StatsViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
    // section 1
@property (nonatomic, readwrite) NSMutableArray *sandwichTitleList;
@property (nonatomic, readwrite) NSMutableArray *sandwichDetailList;
    // section 2
@property (nonatomic, readwrite) NSMutableArray *saladTitleList;
@property (nonatomic, readwrite) NSMutableArray *saladDetailList;

@end

@implementation ViewController

-(id) init {
    self = [super init];
    if(!self) {
        return nil;
    }
        // post welocome notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"welcome" object:self];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // hide the navigation bar
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    [self.navigationItem setTitle:@"My Menu"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Sync"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(showStatsPage)];
    item.image = [UIImage imageNamed:@"icon-sync"];
    self.navigationItem.rightBarButtonItem = item;
    
    self.sandwichTitleList = [[NSMutableArray alloc] init];
    [self.sandwichTitleList addObject:@"Black Forest Ham"];
    [self.sandwichTitleList addObject:@"Owen Roasted Chicken"];
    [self.sandwichTitleList addObject:@"Subway Club"];
    [self.sandwichTitleList addObject:@"Veggie Delight"];
    
    self.sandwichDetailList = [[NSMutableArray alloc] init];
    [self.sandwichDetailList addObject:@"290 Calories, 4.5 Total fat"];
    [self.sandwichDetailList addObject:@"320 Calories, 5.0 Total fat"];
    [self.sandwichDetailList addObject:@"310 Calories, 4.5 Total fat"];
    [self.sandwichDetailList addObject:@"230 Calories, 2.5 Total fat"];
    
    self.saladTitleList = [[NSMutableArray alloc] init];
    [self.saladTitleList addObject:@"Chicken Teriyaki Salad"];
    [self.saladTitleList addObject:@"Roasted Beef Salad"];
    [self.saladTitleList addObject:@"Subway Club Salad"];
    [self.saladTitleList addObject:@"Turkey Delight"];
    
    self.saladDetailList = [[NSMutableArray alloc] init];
    [self.saladDetailList addObject:@"220 Calories, 3.0 Total fat"];
    [self.saladDetailList addObject:@"140 Calories, 3.5 Total fat"];
    [self.saladDetailList addObject:@"140 Calories, 3.5 Total fat"];
    [self.saladDetailList addObject:@"110 Calories, 2.0 Total fat"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = nil;
    self.tableView.tableFooterView = nil;
    self.tableView.contentInset = UIEdgeInsetsMake(-50.0f, 0.0f, 0.0f, 0.0);
    
    [self.activityIndicator setHidden:true];
    [self.tableView setHidden:true];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Subway!"
                                                    message:@"Buy 1 Footlong Sub & get a 6 inch Sub absolutely free!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark -
#pragma mark View lifecycle

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     NSString *str;
    if (section==0) {
        str = @"Sandwiches";
    }
    else{
         str = @"Salads";
        
    }
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;

    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 25)];
    [view setBackgroundColor:[UIColor colorWithRed:244.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0]];
    UILabel *labelHeading=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,20)];
    labelHeading.textAlignment=NSTextAlignmentCenter;
    
   
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
        // Set background color, again for entire range
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:232.0/255.0f green:123.0/255.0f blue:0.0 alpha:1.0]
                             range:NSMakeRange(0, [attributedString length])];
    
    labelHeading.attributedText=attributedString;
    [view addSubview:labelHeading];
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sandwichTitleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"MenuItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.activityIndicator startAnimating];
        [self.activityIndicator setHidden:false];
        [self performSelector:@selector(animate) withObject:nil afterDelay:1.0];
    }
}

#pragma mark -
#pragma mark Helper methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row==0||indexPath.row==3) {
            cell.imageView.image=[UIImage imageNamed:@"hamburger-48"];
            cell.contentView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:241.0f/255.0f blue:201.0f/255.0f alpha:1.0];
        }
        else{
            cell.imageView.image=[UIImage imageNamed:@"pie-48"];
            cell.contentView.backgroundColor=[UIColor clearColor];
        }
        
        cell.textLabel.text = [self.sandwichTitleList objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.sandwichDetailList objectAtIndex:indexPath.row];
        cell.detailTextLabel.textColor=[UIColor colorWithRed:85.0/255.0f green:85.0/255.0f blue:85.0/255.0f alpha:1.0];
    } else {
        
        if (indexPath.row==1) {
            cell.imageView.image=[UIImage imageNamed:@"Radish-48"];
            cell.contentView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:241.0f/255.0f blue:201.0f/255.0f alpha:1.0];
        }
        else{
            cell.imageView.image=[UIImage imageNamed:@"fruits-32"];
            cell.contentView.backgroundColor=[UIColor clearColor];
        }
        cell.textLabel.text = [self.saladTitleList objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.saladDetailList objectAtIndex:indexPath.row];
        cell.detailTextLabel.textColor=[UIColor colorWithRed:85.0/255.0f green:85.0/255.0f blue:85.0/255.0f alpha:1.0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
     cell.textLabel.backgroundColor=[UIColor clearColor];
     cell.detailTextLabel.backgroundColor=[UIColor clearColor];
}

-(void)animate {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:true];
    [self.tableView setHidden:false];
    [self.tableView reloadData];
}

-(void)syncAndNavigate
{
    
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:true];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Fitbit data sync is now completed"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [alert show];
    
    [self performSelector:@selector(dismissAlertView:) withObject:alert afterDelay:1.0];
    
  
  
    
}


-(void)dismissAlertView:(UIAlertView *)alertView
{
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    
    StatsViewController *statsPage = [self.storyboard instantiateViewControllerWithIdentifier:@"StatsViewController"];
    [self.navigationController pushViewController:statsPage animated:NO];
    [self.navigationController addChildViewController:statsPage];
    
}



-(void) showStatsPage {
    [self.activityIndicator startAnimating];
    [self.activityIndicator setHidden:false];
    [self performSelector:@selector(syncAndNavigate) withObject:nil afterDelay:3.0];

}

@end
