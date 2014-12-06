//
//  ProjectViewController.m
//  Projects On The Go
//
//  Created by Samir Bhide on 17/06/13.
//  Copyright (c) 2013 raweng. All rights reserved.
//

#import "ProjectViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "AppConstants.h"
#import "CreateProjectViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UsersTableViewController.h"
#import "Food.h"

/* ProjectViewController
    Lists all the projects from 'project' class.
 
 */


@interface ProjectViewController ()<UITableViewDataSource, UIAlertViewDelegate, UITextFieldDelegate, CreateProjectDelegate>

@end

@implementation ProjectViewController

-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"piquant";
        //self.enablePullToRefresh = YES;
        self.fetchLimit = 10;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refresh];
    [self.navigationController setNavigationBarHidden:NO];\
    
    if (self.isAdmin) {//if user is admin show create project button
        UIBarButtonItem *addProject = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(addProject:)];
//        [self.navigationItem setRightBarButtonItem:addProject];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are we admin?"
//                                                        message:@"Yes we are!"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
    }
    // Commented this out
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]]];
    
    // Create text field near center (not perfect) and add to current view
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x * .1, self.view.center.y - 100, 285, 50)];
    tf.textColor = [UIColor whiteColor];
    tf.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    tf.backgroundColor=[UIColor colorWithRed:145.0/255.0 green:179.0/255.0 blue:73.0/255.0 alpha:1.0f];
    UIColor *color = [UIColor whiteColor];
    tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"What did you eat?" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:tf];
    self.textF = tf;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(self.view.center.x - 15, self.view.center.y - 50, 50, 30);
    [btn setTitle:@"Go!" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:179.0/255.0 blue:73.0/255.0 alpha:1.0f];
    [[btn layer] setBorderWidth:2.0f];
    [[btn layer] setBorderColor:[UIColor whiteColor].CGColor];
    [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *profileBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    profileBtn.frame = CGRectMake(20, 460, 50, 50);
    profileBtn.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:179.0/255.0 blue:73.0/255.0 alpha:1.0f];
    [profileBtn setTitle:@"Pro" forState:UIControlStateNormal];
    [profileBtn addTarget:self action:@selector(proBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:profileBtn];
    
}

- (IBAction)proBtnSelected:(UIButton *)proBtn {
    UsersTableViewController *profile = [[UsersTableViewController alloc] initWithStyle:UITableViewStylePlain withClassUID:@"profile"];
    [self.navigationController pushViewController:profile animated:YES];
}

- (IBAction)btnSelected:(UIButton *)btn {
    /*
    self.recDict = [[NSMutableDictionary alloc] init];
    self.recDict[@"pie"] = @"You should counteract that sugar with some vegetables!";
    self.recDict[@"coffee"] = @"You should counteract that caffeine with some water!";
    self.recDict[@"chicken burrito"] = @"You should counteract the carbs with a run!";
    self.recDict[@"yam"] = @"You deserve a desert!";
    self.recDict[@"pizza"] = @"Eat some cherries, blueberries or purple grapes - the dark fruit contains tons of antioxidants that help fight the damage of high-fat foods!";
    self.recDict[@"cheesecake"] =@"Eat some cherries, blueberries or purple grapes - the dark fruit contains tons of antioxidants that help fight the damage of high-fat foods!";
    self.recDict[@"soda"] = @"You should counteract that with a 40-minute walk!";
    self.recDict[@"chocolate"] = @"You should perhaps look into eating dark chocolate or cacao beans.";

    */

    NSString *query = [@"?results=0%%3A1&fields=*&appId=f515c7d7&appKey=7469e9a1154284f8692fcb7bf20b3335" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(query);
    //NSString * url = [NSString stringWithFormat:@"%@%@%@", @"http://api.nutritionix.com/v1_1/search/", [[NSString alloc] initWithFormat:@"%@",self.textF.text], query];
    
    NSString * url = [NSString stringWithFormat:@"%@%@%@", @"http://api.nutritionix.com/v1_1/search/", [[NSString alloc] initWithFormat:@"%@",self.textF.text], @"?results=0%%3A1&fields=*&appId=f515c7d7&appKey=7469e9a1154284f8692fcb7bf20b3335"];
    NSLog(url);
    
    //NSURL *dataURL = [NSURL URLWithString: [self URLEncodeString:url]];
    //NSURL* dataURL = [NSURL URLWithString:[url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //NSURL* dataURL = [NSURL URLWithString:url];
    
    
    NSString* webStringURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(webStringURL);
    NSURL* dataURL = [NSURL URLWithString:webStringURL];
    
    //NSURL* dataURL = [NSURL URLWithString:url];
    
    /*
    NSLog(@"DataURL:");
    NSLog(dataURL);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:dataURL] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            //[self.delegate fetchingGroupsFailedWithError:error];
            NSLog(@"error: %@", error);
        } else {
            //[self.delegate receivedGroupsJSON:data];
            NSLog(@"No Error!");
        }
    }];
    */
    
    if (dataURL == nil) {
        NSLog(@"Nil URL");
    }
    /*
    NSLog(@"DataURL:");
    NSLog(dataURL);
    */
    NSError *error = nil;
    
    /*
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:dataURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30] returningResponse:nil error:&error];
    
    if (error) {
        NSLog(@"error: %@", error);
    } else {
        
    }
    */
    
    NSURLRequest* request = [NSURLRequest requestWithURL:dataURL];
    NSHTTPURLResponse* response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    } else {
        NSLog(@"Connection passed");
    }
    
    NSLog(@"NSURL");
    
    NSError *error1 = nil;
    //[NSURLConnection sendAsynchronousRequest:request queue:(NSOperationQueue *)queue completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler];
    NSData* jsonData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:dataURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30] returningResponse:nil error:&error1];
    
    
    //NSData *jsonData = [NSData dataWithContentsOfURL:dataURL options:NSDataReadingUncached error:&error1];
    NSLog(@"NSData");
    if (error1) {
        NSLog(@"error: %@", error1);
    } else {
        NSLog(@"No error on NSURLRequest");
    }
    if (jsonData == nil) {
      NSLog(@"Nil NSData");  
    }
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error: &error];
    
    NSLog(@"Dictionary");
    
    NSLog(@"%@", [dataDictionary allKeys]);
    NSLog(@"Keys printed");
    NSArray *array = [dataDictionary objectForKey:@"hits"];
    NSLog(@"%d", [array count]);
    NSDictionary *ingredients = [[array objectAtIndex: 0] objectForKey:@"fields"];
    
    NSLog([ingredients objectForKey:@"nf_calories"]);
    if ([ingredients objectForKey:@"nf_polysaturated_fat"] == [NSNull null]) {
        NSLog(@"Null");
    }
    NSLog([ingredients objectForKey:@"nf_polysaturated_fat"]);
    
    Food *food = [[Food alloc] initWithData:ingredients andDate:[NSDate date]];
    [self.eatenFoods addObject:food];
    
    NSString *msg = @"Default";
    /*
    if (self.recDict[self.textF.text] == NULL) {
        msg = @"What you ate is not in our database. We'll get back to you when we get it!";
    }
    else {
        msg = [[NSString alloc] initWithFormat:@"%@", [dataDictionary objectForKey:[@"nf_calories"];
    }
    */
    UIAlertView *infoAlert = [[UIAlertView alloc]initWithTitle:@"Recommendation"
                                                       message: msg
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"OK", nil];
    
    [infoAlert show];
}



//UIAlertView with textfield to input the name of the project
- (void)addProject:(id)sender{
    UIAlertView *projectNameAlert = [[UIAlertView alloc]initWithTitle:@"Enter Project Name"
                                                              message:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:@"OK", nil];
    [projectNameAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [projectNameAlert setTag:1];
    [projectNameAlert setDelegate:self];
    [projectNameAlert show];
}

#pragma mark
#pragma mark CreateProjectDelegate

//refresh after project is created so that the newly created project appears in the table
-(void)didCreateProject{
    [self refresh];
}

#pragma mark
#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            CreateProjectViewController *createProject = [[CreateProjectViewController alloc]init];
            [createProject setDelegate:self];
            UINavigationController *createProjectNavigationController = [[UINavigationController alloc]initWithRootViewController:createProject];
            [createProjectNavigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
            createProject.title = [alertView textFieldAtIndex:0].text;
            [self presentViewController:createProjectNavigationController animated:YES completion:nil];
        }
    }
}

#pragma mark
#pragma mark BuiltUITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath builtObject:(BuiltObject *)builtObject{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"bullet_black"];
    cell.textLabel.text = [builtObject objectForKey:@"name"];
    
    return cell;
}

#pragma mark
#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewController *viewController = [[ViewController alloc]init];
    viewController.builtObject = [self builtObjectAtIndexPath:indexPath];
    viewController.projectViewController = self;
    [[AppDelegate sharedAppDelegate].nc pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
