#import "DPRootViewController.h"
#import "DPDiziPuf.h"
#import "NSDictionary+Verified.h"

@interface DPRootViewController(){
	NSMutableArray *myObject;
	NSMutableArray *oldObject;
	UIView *footerView;
}
@end


@implementation DPRootViewController
@synthesize dict = _dict;
@synthesize streamclick = _streamclick;
- (void)loadView
{
    [super loadView];
    CGRect frame = CGRectMake(5, 5, 100, 30);
	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
	[button sizeToFit];
	button.frame = frame;
	[button setTitle:(NSString *)@"<- Back" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(buttonPressed:) 
    forControlEvents:UIControlEventTouchUpInside];
	
	//create a footer view on the bottom of the tabeview
	footerView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 280, 100)];
	[footerView addSubview:button];
	self.tableView.tableFooterView = footerView; 
	[footerView release];
    // set the title
    self.title = @"Dizipuf - Reklamsız İzle";
	self.streamclick = 0;

}

- (void)buttonPressed:(UIButton *)button {
	//[self customAlert:@"clicked"];
    [myObject removeAllObjects];
	myObject = [oldObject mutableCopy];
	[self.tableView reloadData];
}
	

- (void)customAlert:(NSString *)msg{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert title"
                                                message: msg
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:@"ok",nil];
	[alert show];
	[alert release];
}

 
- (void)loadDataFromUrl:(NSString *)url{
	[myObject removeAllObjects];
    NSData *jsonData = [NSData dataWithContentsOfURL:
		[NSURL URLWithString:[NSString stringWithFormat:@"https://dizipuf.com/bot/index.php?url=%@&ref=&type=json",url]]];
	
	NSString* myString;
	myString = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
	//[self customAlert:myString];
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    //[self customAlert:[NSString stringWithFormat:@"%ld",(long)[jsonObjects count]]];
	// values in foreach loop
	
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *title = [dataDict objectForKey:@"title"];
		NSString *logox = [[NSString alloc] init];
		if (([dataDict checkKey:@"logo_30x30" className:NSStringFromClass(self.class)]) || ([dataDict verifiedObjectForKey:@"logo_30x30"] != nil)) {
			logox = [dataDict objectForKey:@"logo_30x30"];
			if([logox isEqualToString:@"null"]){
			logox = @"<img src=\"https://dizipuf.com/bot/30x30.png\"/>";				
			}
			if([logox isEqualToString:@"search"]){
			logox = @"<img src=\"https://dizipuf.com/bot/30x30.png\"/>";				
			}
		}else{
			logox = @"<img src=\"https://dizipuf.com/bot/30x30.png\"/>";
		}
		NSString *descx = [[NSString alloc] init];
		if (([dataDict checkKey:@"description" className:NSStringFromClass(self.class)]) || ([dataDict verifiedObjectForKey:@"description"] != nil)) {
			descx = [dataDict objectForKey:@"description"];
			if([descx isEqualToString:@"null"]){
				descx = @"/>IMDB PUANI: ";				
			}
			if([descx isEqualToString:@"Modulde aramak icin TEXT butonuna basin"]){
				descx = @"/>IMDB PUANI: ";				
			}
		}else{
			descx = @"test";
		}
		NSString *urlx = [[NSString alloc] init];
		if([dataDict objectForKey:@"playlist_url"] != nil) {
			urlx = [dataDict objectForKey:@"playlist_url"];
			if([urlx isEqualToString:@"null"]){
				urlx = @"x";				
			}
		}
		if([dataDict objectForKey:@"stream_url"] != nil) {
			urlx = [dataDict objectForKey:@"stream_url"];
			self.streamclick = 1;
		}
		NSMutableDictionary *dictx = [[NSMutableDictionary alloc] init];
        [dictx setObject:title forKey:@"title"];
		[dictx setObject:logox forKey:@"logo"];
		[dictx setObject:descx forKey:@"desc"];
		[dictx setObject:urlx forKey:@"url"];
		//[self customAlert:[NSString stringWithFormat:@" %@", dictx]]; 
        [myObject addObject:dictx];
    }
	
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create array to hold dictionaries
    myObject = [[NSMutableArray alloc] init];
	oldObject = [[NSMutableArray alloc] init];
	[self loadDataFromUrl:@""];
	//[self loadDataFromUrl:@"aHR0cDovL3Rydm9kLm1lLzgwL21vZHVsL21vZHVsLnBocD9zaXRlPWJpY2FwcyZ0dXI9ZiZ1cmw9aHR0cCUzQSUyRiUyRnd3dy5iaWNhcHMubmV0JTJGaGlnaGVyLXBvd2VyLTIwMTgtdHVya2NlLWFsdHlhemlsaS0xMDgwcC1oZCUyRiZ0aXRsZT1IaWdoZXIrUG93ZXIrMjAxOCtUJUMzJUJDcmslQzMlQTdlK0FsdHlheiVDNCVCMWwlQzQlQjErMTA4MHArSEQ="];
}

//#pragma Table View Data Source

// Return the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Return the number of rows for each section in your static table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return myObject.count;
}

// Return the row for the corresponding section and row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
    
    // Similar to UITableViewCell, but 
    DPDiziPuf *cell = (DPDiziPuf *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DPDiziPuf alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
	cell.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
    // Just want to test, so I hardcode the data
	NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
	/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you want to say hello?"
                                                message: [NSString stringWithFormat:@"%@", tmpDict]
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:@"Say Hello",nil];
	[alert show];
	[alert release];*/ 
	cell.titleLabel.text = [tmpDict objectForKey:@"title"];
	NSString *desctext = [tmpDict objectForKey:@"desc"];
	desctext = [desctext substringFromIndex:[desctext rangeOfString:@">"].location+[@">" length]+0];
    if(desctext == nil){
	}else{
		cell.descriptionLabel.text = desctext;
	}
	
	NSData *urldata = [[tmpDict objectForKey:@"url"]
	dataUsingEncoding:NSUTF8StringEncoding];
	//[self customAlert:[NSString stringWithFormat:@"%@",urldata]];
	cell.urlLabel.text = [urldata base64EncodedStringWithOptions:0];
	NSString *imgURL = [tmpDict objectForKey:@"logo"];
	imgURL = [imgURL substringFromIndex:[imgURL rangeOfString:@"src="].location+[@"src=" length]+1];
	imgURL = [imgURL substringToIndex:[imgURL rangeOfString:@"/>"].location-1];
	NSURL *url = [NSURL URLWithString:[imgURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	if (data == nil){
	}else{
		cell.myImageView.image =  [UIImage imageWithData:data];   
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 return 100;
}
//#pragma Table View Delegate

// Customize the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Liste";
}

- (NSString *)b64decode:(NSString *)encodedtext
{
	// NSData from the Base64 encoded str
	NSData *nsdataFromBase64String = [[NSData alloc]
		initWithBase64EncodedString:encodedtext options:0];

	// Decoded NSString from the NSData
	NSString *base64Decoded = [[NSString alloc] 
		initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
	return base64Decoded;
}

// Configure the row selection code for any cells that you want to customize the row selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	DPDiziPuf *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (self.streamclick == 0){
		[oldObject removeAllObjects];
		oldObject = [myObject mutableCopy];
		[self loadDataFromUrl:cell.urlLabel.text];
		[self.tableView reloadData];
	}else{
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self b64decode:cell.urlLabel.text]]];
	}
}


@end