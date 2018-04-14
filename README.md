# ad_bind

### What is this?

These are all of the components needed to bind a Mac to Active Directory using Munki and a configuration profile.

Additionally, the included installcheck_script will allow Munki to detect if the binding is broken, and will prompt the user to fix it by reinstalling through Managed Software Center.

### Requirements

* An Active Directory Server
* Munki 2.2 or greater
* macOS 10.9 or greater

### Instructions

Of course, you'll need to customize all of these files for your environment (see the "Credit" section for help doing this). Once you've done that, open the Terminal and run `munkiimport.sh`.

I recommend using a [Conditional Item](https://github.com/munki/munki/wiki/Conditional-Items) to prevent this from triggering outside of your network (if you have laptop users, and your AD server is only available on your organization's network). We have a well-defined IP range, so I was able to use that.

### Credit

* [Graham Gilbert's tutorial](https://grahamgilbert.com/blog/2014/04/01/binding-to-active-directory-with-munki/), which started this project
* [Armin Briegel's tutorial](http://scriptingosx.com/2015/01/connect-to-active-directory-with-a-profile/), which helped me move this from a script to a profile