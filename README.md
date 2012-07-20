# Cinch YAML keywords plugin

A Cinch plugin to define keywords and display description when keyword matches, keywords are saved in yaml file for persistence.

## Installation

First install the gem by running:

```bash
gem install cinch-yaml-keywords
```

Then load it in your bot:

```ruby
require "cinch"
require "cinch/plugins/yamlkeywords"

bot = Cinch::Bot.new do
  configure do |c|
    c.plugins.plugins = [Cinch::Plugins::YamlKeywords]
  end
end

bot.start
```

## Commands

```irc
!keywords                         # list all definitions
!keyword <keyword>                # show single definition
!keyword <keyword> <definition>   # define without spaces
!keyword '<keyword>' <definition> # define with spaces
!keyword "<keyword>" <definition> # define with spaces
!forget <keyword>                 # remove definition
<keyword>                         # display definition
```

## Example

    <mpapis>: !keyword 'gist it' Please use https://gist.github.com for anything longer then 2 lines of text.
    <user8549586> I get error 4838948: fkjfdlg
    <mpapis>: gist it all so I can see the context
    <smfbot>: Please use https://gist.github.com for anything longer then 2 lines of text.

## Development

Run the `./test-run.sh` script to play with results of your changes in channel listed in `example/config.yaml`
