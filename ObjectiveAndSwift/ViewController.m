//
//  ViewController.m
//  ObjectiveAndSwift
//
//  Created by Stefanos Neofytidis on 31/12/21.
//

#import "ViewController.h"
#import "ObjectiveAndSwift-Swift.h"

@interface ViewController ()
@property (nonatomic,weak) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction) getTokenFromSwiftClass
{
    ObjectiveAndSwift *signinClass = [ObjectiveAndSwift new];
    self.textView.text = [signinClass getToken];
    
}

@end
