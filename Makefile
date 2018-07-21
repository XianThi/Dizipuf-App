include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = Dizipuf
Dizipuf_FILES = main.m DPAppDelegate.m DPRootViewController.m DPDiziPuf.m NSDictionary+Verified.m
Dizipuf_FRAMEWORKS = UIKit CoreGraphics Foundation 

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"Dizipuf\"" || true