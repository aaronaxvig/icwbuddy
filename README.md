# icwbuddy
This repository contains the webpage code and backing data to show which mile of the AICW you are closest to.  Feel free to use the data for your own projects.  If you use the data for a popular app it would be nice (not at all required) to see a shout-out on your licensing page and let me know when it is there!

As an example alternate use of the data, you could import the GPX files into your chart plotter to easily see the mile markers pass by as you travel.

## Data
### Description
The data is a set of GPX files.  Each one contains 100 data points which are located approximately one mile apart on the Atlantic Intracoastal Waterway.  Data for other waterway mile markers is available from USACE, seemingly for all inland waterways and west coast.  The closest that I was able to find for the AICW was line segments covering the whole route, but it still would have required some process to divide it up into one mile chunks and would probably not line up with the five mile marks that are on NOAA charts.

Data points are named AICW 0, AICW 1, etc.  For the Dismal Swamp route there are additional data points "AICW DS 8" through "AICW DS 81".

### Coverage
The data includes miles 0-1153 of the AICW, and includes the alternate route through the Dismal Swamp.  I am not very familiar with the routes past mile 1153 in the Keys so have not attempted to mark those miles out.  The Hawk Channel could easily be measured out and marked as AICW Hawk 1201 for example and I will probably do that sometime.

I have also added some data for areas north of mile 0.  I am not aware of an official description of a designated waterway there so used my own judgement to pick the route.  Some factors in choosing the route were protection, directness, and draft (above and below).  So the route goes up the Chesapeake Bay, through the C&D Canal, down the Delaware River, through the NJ waterway, through the East River in New York into Long Island Sound, through the Cape Cod Canal, through the Blynman Canal (near Gloucester), and through some of the thoroughfares in Maine.

### Accuracy
The miles are traced on the magenta line from each five-mile marker that is shown on the NOAA raster (RNC) charts.  Starting at mile 0 for example, the next four points are each one mile "south" along the magenta line.  The space between the fourth and fifth mile markers of any given section often varies short or long by up to 0.15 miles, and rarely up to 0.5 miles off.  I felt that this approach was good because it gives the most spans that are actually one mile in length and was easy to implement.

### Methodology
I use OpenCPN with the NOAA raster charts to manually drop markers for each mile.  The process went like this:

1. Download some charts.  Downloading all the charts in a region/state oftentimes results in charts being shown which don't have the magenta line.  This can be fixed by hiding those particular charts.  Downloading only the ones that are described as "Intracoastal \<something\>" is another easy solution.
1. Place a marker at mile 0 with the Ctrl+M hotkey and then double click on it to change the name to "AICW 0". 
1. Press Ctrl+R to start creating a route. 
1. Create points for the route along the magenta AICW line until the route totals 1.00mi in length.  You must have OpenCPN configured for statute miles.
1. Press Ctrl+M to drop a mark.
1. No action was taken to stop creating the route, so proceed tracing with the route until 2.00mi and drop another mark there.
1. Repeat for 3.00mi and 4.00mi, then press Esc to stop creating the route (or keep tracing to see how far off the NOAA marks are--the last mile will typically be up to 0.15 miles long or short).
1. At 5.0mi it rounds to the nearest tenth mile so the accuracy is not good enough.  Plus there is a mark every five miles on the NOAA chart so just drop the marker there and repeat the whole process for the next four points.
1. At some point go back and fill in all the names "AICW 1", "AICW 2", etc.
1. Open the Route and Mark Manager in OpenCPN and delete all the routes that you don't need anymore.
1. Select all of the waypoints and export them.

There is a lot of data in the exported GPX that probably isn't necessary.  I plan to write a script to clean those up.