# Middleman Template

**NOTE: This project is no longer maintained.**

---

A nice default project template for [Middleman](http://middlemanapp.com), the static site building tool.

Middleman-Template is maintained by [Infinite Red](http://infinite.red), a web and mobile development company based in Portland, OR and San Francisco, CA.

## Dependencies

- [Middleman](http://middlemanapp.com)
- [Slim](http://slim-lang.com/) templates
- [Sass](http://sass-lang.com/) with [Bourbon](http://bourbon.io/) & [Neat](http://neat.bourbon.io/)
- [CoffeeScript](http://coffeescript.org/) with [jQuery](http://jquery.com/)
- [Livereload](https://github.com/middleman/middleman-livereload)
- [PNGcrush](http://pmt.sourceforge.net/pngcrush/)
- [OptiPNG]()
- [JPEGoptim]()

## Setup

Quick setup:

```
rake setup
bundle exec middleman
```

Manual setup:

```
brew install pngcrush optipng jpegoptim
bundle
rake build:source
rake setup:update
bundle exec middleman
```

## Usage

**Template usage below...replace with your own usage**

Clone this repo into your `~/.middleman` directory as clearsight

    git clone git@github.com:clearsightstudio/middleman-template.git ~/.middleman/clearsight

Now you can simply init new projects with the ClearSight template:

    middleman init -T=clearsight my-project

Just don't forget to update `~/.middleman/clearsight` every now and then.
