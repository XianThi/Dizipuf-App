#import <spawn.h>
#import <UIKit/UIKit.h>

@interface DPRootViewController : UITableViewController
	@property (nonatomic, strong) NSMutableDictionary *dict;
	@property (nonatomic, assign) BOOL streamclick;
	- (void)buttonPressed:(UIButton *)button;
@end