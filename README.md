Twenty One Day Habit
====================

Twenty One Day Habit is a website located at [http://twentyonedayhabit.com/](http://twentyonedayhabit.com/). Go there if you want to know what the site is about. This document is about the technical implementation.

Versions
--------
* **0.1**: Facebook authentication is boring (private beta) 11/13/2010 Implemented initial structure, facebook authentication.
* **1.0**: Sleep is for the weak (public release) 11/14/2010 Initial release, stayed up too late, added habits.
* **1.1**: Too many chicken wings 11/15/2010 Improved styles, added additional login, refactored Facebook authentication, ate a shit ton of chicken wings, allowed merging of users.

Wish list
---------
* Add memcached support
* Add social features
* Figure out what to do when a user finishes their habit
* iPhone app - going to need an API
* Firefox compatibility (-moz and stuff)
* Add hook on user to clear memcache
* Add hook on user to refresh cache
* Show past habits if they exist
* Add destroy hook on user to clear old data
* Index database
* Look into integrating with other sites (Facebook posting?)
* Cache friends
* Find out a way to cache habit listing (be careful since toggle days should invalidate that)
* Cache everything on a worker on login
* Fade in X on toggle_day
* Allow admin to delete users
* Allow admin to reset password
* Make a logo, put it on jeffdickey.info
* Put this on: http://developers.facebook.com/docs/reference/plugins/like-box using http://www.facebook.com/apps/application.php?id=165102360190591
* Allow facebook login to redirect on FbGraph::Exception
* Notifications (email, sms, google calendar, ics) with a time
* If shit gets hairy: LINODE