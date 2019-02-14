# ad_bind

### What is this?

These are all of the components needed to bind a Mac to Active Directory using Munki and a configuration profile.

Additionally, the included installcheck_script will allow Munki to detect if the binding is broken, and will prompt the user to fix it by reinstalling through Managed Software Center.

I wrote more about this on [my blog](https://mikesolin.com/2018/04/14/binding-macs-to-ad-using-munkis-configuration-profile-support/).

### Requirements

* An Active Directory Server
* Munki 2.2 or greater
* macOS 10.9 or greater

### Instructions

Of course, you'll need to customize all of these files for your environment (see the "Credit" section for help doing this). Once you've done that, open the Terminal and run `munkiimport.sh`.

### Credit

* [Graham Gilbert's tutorial](https://grahamgilbert.com/blog/2014/04/01/binding-to-active-directory-with-munki/), which started this project
* [Armin Briegel's tutorial](http://scriptingosx.com/2015/01/connect-to-active-directory-with-a-profile/), which helped me move this from a script to a profile