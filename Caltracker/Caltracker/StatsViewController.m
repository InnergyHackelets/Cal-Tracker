//
//  StatsViewController.m
//  Innergy
//
//  Created by Nave's on 06/12/14.
//  Copyright (c) 2014 HPM. All rights reserved.
//

#import "StatsViewController.h"

@interface StatsViewController () <UITabBarControllerDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *fitbitStatsTableView;
@property (strong, nonatomic) IBOutlet UITableView *suggestionsTableView;
@property (strong,nonatomic) NSMutableArray *statsTitleList;
@property (strong,nonatomic) NSMutableArray *statsDetailsList;
@property (strong,nonatomic) NSMutableArray *suggestionsTitleList;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"Today's Stats"];
    
    self.fitbitStatsTableView.delegate = self;
    self.fitbitStatsTableView.dataSource = self;
    self.fitbitStatsTableView.tableHeaderView = nil;
    self.fitbitStatsTableView.tableFooterView = nil;
        //self.fitbitStatsTableView.contentInset = UIEdgeInsetsMake(-20.0f, 0.0f, 0.0f, 0.0);
    
    self.suggestionsTableView.delegate = self;
    self.suggestionsTableView.dataSource = self;
    self.suggestionsTableView.tableHeaderView = nil;
    self.suggestionsTableView.tableFooterView = nil;
        //self.suggestionsTableView.contentInset = UIEdgeInsetsMake(-20.0f, 0.0f, 0.0f, 0.0);
    
    self.statsTitleList = [[NSMutableArray alloc] init];
    [self.statsTitleList addObject:@"Walking (3.5mph)"];
    [self.statsTitleList addObject:@"Breakfast"];
    [self.statsTitleList addObject:@"Lunch"];
    [self.statsTitleList addObject:@"Cycling(10mins)"];
    
    self.statsDetailsList = [[NSMutableArray alloc] init];
    [self.statsDetailsList addObject:@"100 cal in 20 min"];
    [self.statsDetailsList addObject:@"400 cal, 5.0 total fat"];
    [self.statsDetailsList addObject:@"600 cal, 6.0 total fat"];
    [self.statsDetailsList addObject:@"300 cal"];
    
    self.suggestionsTitleList = [[NSMutableArray alloc] init];
    [self.suggestionsTitleList addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"75",@"Minute",@"Walking",@"activity", nil]];
    [self.suggestionsTitleList addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"23",@"Minute",@"Jogging",@"activity", nil]];
    [self.suggestionsTitleList addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"35",@"Minute",@"Swimming",@"activity", nil]];
    [self.suggestionsTitleList addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"45",@"Minute",@"Cycling",@"activity", nil]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     if (tableView.tag == 1) {
         
    return 70.0;
     }
    return 48.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return [self.statsTitleList count];
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (tableView.tag == 1) {
        NSString *cellIdentifier = @"StatCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (! cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentifier];
        }
        
  
        
        
        [self configureCell:cell atIndexPath:indexPath];
    } else {
        NSString *cellIdentifier = @"cellTime";
        
        
        
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (! cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentifier];
        }
        UIImageView *imageCircle=(UIImageView *)[cell viewWithTag:9];
//        imageCircle.backgroundColor=[UIColor orangeColor];
//        imageCircle.layer.cornerRadius=20.0f;
//     
       UILabel *labelMin=[[UILabel alloc] init];
        labelMin.numberOfLines=0;
        labelMin.font=[UIFont systemFontOfSize:17];
        labelMin.frame=CGRectMake(5, 0, 30, 30);
             labelMin.textAlignment=NSTextAlignmentCenter;
            //   @"75 Mins",@"Minute",@"Walking",@"activity"
        labelMin.text=[[self.suggestionsTitleList objectAtIndex:indexPath.row] valueForKey:@"Minute"];
        labelMin.textColor=[UIColor whiteColor];
        labelMin.font=[UIFont boldSystemFontOfSize:15];
        [imageCircle addSubview:labelMin];
        
        
        UILabel *labelName=(UILabel *)[cell viewWithTag:8];
        labelName.text=[[self.suggestionsTitleList objectAtIndex:indexPath.row] valueForKey:@"activity"];
        
        
            //  [self configureCell:cell atIndexPath:indexPath];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -
#pragma mark Helper methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.row == 0 || indexPath.row == 3) {
        cell.imageView.image=[UIImage imageNamed:@"icon_burnCalories.png"];
    } else {
        cell.imageView.image=[UIImage imageNamed:@"icon_breakFast"];
    }
    cell.textLabel.text = [self.statsTitleList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.statsDetailsList objectAtIndex:indexPath.row];
}

@end
