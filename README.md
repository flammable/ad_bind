# ad_bind

### What is this?

These are all of the components needed to bind a Mac to Active Directory using Munki.

Note that this used to be a script, then it was converted to a profile, and now it's a script again. Installing a configuration profile using the `profiles` command has been deprecated, but unfortunately, binding to AD using a configuration profile (delivered via MDM) is still problematic.

The included installcheck_script will allow Munki to detect if the binding is broken, and will prompt the user to fix it by reinstalling through Managed Software Center.

I wrote more about this on [my blog](https://mikesolin.com/2018/04/14/binding-macs-to-ad-using-munkis-configuration-profile-support/).

### Requirements

* An Active Directory Server
* Munki
* I've tested this with macOS 10.14 and 10.15, but it should work with any recent version of the macOS

### Instructions

Of course, you'll need to customize all of these files for your environment (see the "Credit" section for help doing this). Once you've done that, open the Terminal and run `munkiimport.sh`.

### Credit

* [Graham Gilbert's tutorial](https://grahamgilbert.com/blog/2014/04/01/binding-to-active-directory-with-munki/), which started this project
* [Armin Briegel's tutorial](http://scriptingosx.com/2015/01/connect-to-active-directory-with-a-profile/), which helped me move this from a script to a profile
* DeployStudio, for writing the original binding script.