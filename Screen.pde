import deadpixel.keystone.*;  // to modify keystone lib and then make a jar file: jar cvf keystone.jar .

//////
// projector is 1920 x 1080
// to figure out pixel height of cube => 1080 * (7'/12.5') = 604.5
// so max pixels of cube will be 600 high (and since it's a cube, 600 wide), so 600 x 600 pixels
// so the biggest video resolution if you split the video across two screens will be 1200 x 600,  which close to the common resolution 1280x720
// unless you wanted it to spread across all 4, and then it's 1920x1080, but you'll have to crop out 1/2 of the video height

// conclusion: max video resolution can be is 1280x720
// reducing some, like to 920x540, will save some processing
int screenW = 600;
int screenH = 600;

int sphereW = 400;
int topScreenW = 600;
int topScreenH = 500;
//////
Keystone ks;
int keystoneNum = 0;
CornerPinSurface [] surfaces;

Screen [] screens;
