# SWN Sector Generator
Written for use with the [Stars Without Number](http://www.sinenomine-pub.com/?page_id=395) role-playing game by [Sine Nomine Publishing](http://www.sinenomine-pub.com/).

- - -
**Will This Be Updated For The Upcoming Revised Edition of Stars Without Number?**  
Short answer: yes! I am working on the revised edition now. I have created a branch called `revised_edition_working_branch` and this is where I will be merging changes and doing testing. **If you would like to help - please reach out** I will need to update tables and dice rolling rules and may need to add some new tables as well. I could use help both with code changes and with reviews.
- - -

This is the source code for a random galactic sector generator that is hosted on [Linode](https://www.linode.com/). You can play around with it at http://swn.emichron.com/, or fork this repo / pull the container image and host it somewhere else.

The rules for generating this sector are entirely based on the Stars Without Number role-playing game. I created this generator because I loved the game, and really appreciated the insane level of detail that the author put into his tables for rolling up a random galactic sector. I also realized that the rules were _so_ detailed, that it might take a GM quite a while to put their galaxy together.

## Getting Your Head Around This Code

For years I promised myself I would clean this up, or rewrite this in a hip new language. But the problem is that a few of the libraries that I'm using have no analogs in other languages. So, let me just lay out the facts:

1. This tool was written in Perl, using many [CPAN](http://www.cpan.org/) libraries.
2. This tool is at some risk of "bit rot", since the first lines of it were written in 2010.

Still want to know how it works? I salute you. Stiff upper lip and all that. Let's get to it.

### The Front End
The `index.html` file contains the entire user interface and most of the front-end logic, save for the bundled [jQuery](http://jquery.com/) library files. The JavaScript code included in this files handles the nifty UI elements, and also defines three functions that make AJAX (_ooh, how Web 2.0!_) calls back to the web server.

**getRandSeed**  
This function is called when the page loads, and it asks the server for a random seed.

**getSector**  
This function hands the random seed back to the server and receives all of the details of a random galactic sector. Then it renders all of the data for display in the UI.

**Save Sector button**  
An anonymous function bound to this button click collects the current state of the sector as shown in the UI and passes it back to the server for processing. The server turns this data into two versions of a [TiddlyWiki](http://tiddlywiki.com/) file, compresses the files into a .zip, and hands them back to the browser for download.

### The Back End
So far, you're thinking "hey, this reasonably sane JSON-speaking API gives me a good feeling about the back end code." Whelp, here's where you may get panicky.

**Remember [CGI](http://en.wikipedia.org/wiki/Common_Gateway_Interface)?**  
The `CGI` directory in this repo is not a cruel hoax. In order to get this ship sailing, you will need to configure your web server with CGI support.

**seed.cgi**  
Really simple script; calls `SWNUtil::tokenize_seed` on a random number to provide a seed value. This is the back end of `getRandSeed` above.

**sectorgen.cgi**  
This is the main processer. It can both emit and accept a big JSON object that represents an entire galactic sector. It is called by `getSector` and the anonymous Save Sector function.  

**iemap.cgi**  
This CGI handles a (2011) limitation of Internet Explorer, which couldn't handle `data://` URLs.

## Now Containerized!
This app runs great on your own laptop, or in a Kubernetes or OpenShift cluster, thanks to the magic of Linux containers.

If you just want to run your own copy of the published application, install [podman](https://podman.io/) and run:

    podman run -dt -p 8080:8080/tcp quay.io/nhripps/swn

That will download and fire up an instance of this app, listening for web requests on port 8080.

## Legal Notes

* Check out the `LICENSE` file for information on how this app is licensed.

* Before making this tool publicly available, I contacted the game author and agreed to limit the tool's functionality to those rules described in the free version of Stars Without Number. Take care to avoid changing this tool in any way that may infringe the copyrights of Sine Nomine Publishing or any other RPG publishers.
