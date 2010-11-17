Twenty One Day Habit
====================

Twenty One Day Habit is a website located at [http://twentyonedayhabit.heroku.com/](http://twentyonedayhabit.heroku.com/). Go there if you want to know what the site is about. This document is about the technical implementation.

Versions
--------
* **0.1**: Facebook authentication is boring (private beta) 11/13/2010 Implemented initial structure, facebook authentication.
* **1.0**: Sleep is for the weak (public release) 11/14/2010 Initial release, stayed up too late, added habits.
* **1.1**: Too many chicken wings 11/15/2010 Improved styles, added additional login, refactored Facebook authentication, ate a shit ton of chicken wings, allowed merging of users.
* **1.2**: Facebook friend caching, memcache, session caching

Wish list
---------
* Add social features
* Figure out what to do when a user finishes their habit
* iPhone app - going to need an API
* Firefox compatibility (-moz and stuff)
* Show past habits if they exist
* Index database
* Look into integrating with other sites (Facebook posting?)
* Fade in X on toggle_day
* Allow admin to delete users
* Allow admin to reset password
* Make a logo, put it on jeffdickey.info
* Allow facebook login to redirect on FbGraph::Exception
