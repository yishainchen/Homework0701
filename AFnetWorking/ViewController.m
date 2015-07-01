//
//  ViewController.m
//  AFnetWorking
//
//  Created by yishain on 6/24/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <MessageUI/MessageUI.h>
#import "DateTableViewController.h"
@interface ViewController ()
{
    UIImage *image;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDate *date = [calendar dateWithEra:0 year:2015 month:3 day:3 hour:18 minute:20 second:3 nanosecond:0];
//    [self getDataString:date];
    
}
- (IBAction)btnTime:(id)sender {
    NSLog(@"hi");
    NSDate *dateSelect = _DatePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    NSLog(@"%@", [dateFormatter stringFromDate:dateSelect]);
}
- (IBAction)btnQuickTime:(id)sender {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *dateSelect = [calendar nextDateAfterDate:[_DatePicker date] matchingHour:9 minute:30 second:0 options:NSCalendarMatchNextTime];
    [self getDataString:dateSelect];
    
//    dateSelect = [calendar nextDateAfterDate:[_DatePicker date] matchingUnit:NSCalendarUnitHour value:2 options:NSCalendarMatchNextTime];
}

- (IBAction)btnNextTime:(id)sender {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [_DatePicker date];
    NSDate *tomorrow = [calendar dateByAddingUnit:NSCalendarUnitMinute
                                            value:200
                                           toDate:now
                                          options:0];
    
    [self getDataString:tomorrow];
    
   
}
- (IBAction)showTime:(id)sender {
    NSDate *date = [_DatePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年M月d日"];
    NSString *str = [dateFormatter stringFromDate:date];
    NSLog(@"str %@", str);
    [self getDataString:date];
}

- (IBAction)btnNextSunday:(id)sender {


NSCalendar *calendar = [NSCalendar currentCalendar];
NSDate *nextTime = [_DatePicker date];

nextTime = [calendar nextDateAfterDate:[_DatePicker date] matchingUnit:NSCalendarUnitWeekday value:1 options:NSCalendarMatchNextTime];
      [self getDataString:nextTime];
}

- (IBAction)btnTimeDetail:(id)sender {
    
    NSDate *date = [_DatePicker date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger era, year, month, day;
    [calendar getEra:&era year:&year month:&month day:&day fromDate:date];
    NSLog(@"%ld %ld %ld", year, month, day);
    [self getDataString:date];
}

- (IBAction)btnPreSunday:(id)sender {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextTime = [_DatePicker date];
    
    nextTime = [calendar nextDateAfterDate:[_DatePicker date] matchingUnit:NSCalendarUnitWeekday value:1 options:NSCalendarSearchBackwards];
    [self getDataString:nextTime];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendEmail:(id)sender {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc]init];
        [mailController setSubject:@"Swift程式設計入門"];
        [mailController setToRecipients:@[@"diligent1230@hotmail.com"]];
        mailController.mailComposeDelegate = self;
        [mailController setMessageBody:@"一定要買\n不買會後悔" isHTML:NO];
        [self presentViewController:mailController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    NSLog (@"mail finished");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)getDataString:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    dateFormatter.timeStyle = NSDateFormatterLongStyle;
    NSString *str = [dateFormatter stringFromDate:date];
    NSLog(@"str %@", str);

}

@end
