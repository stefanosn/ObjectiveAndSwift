//
//  AppDelegate.h
//  ObjectiveAndSwift
//
//  Created by Stefanos Neofytidis on 31/12/21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

