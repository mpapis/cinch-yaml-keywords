require 'yaml'

module Cinch
  module Plugins
    class YamlKeywords
      include Cinch::Plugin

      def initialize(*args)
        super
        if File.exist?('keywords.yaml')
        then @keywords = YAML.load_file('keywords.yaml')
        else @keywords = {}
        end
      end

      def keywords(m)
        if
          @keywords.size > 0
        then
          m.reply "Keywords start:"
          @keywords.each{|k,v| m.reply "'#{k}': '#{v}'." }
          m.reply "Keywords end."
        else
          m.reply "No keywords defined yet."
        end
      end

      def keyword_define(m, keyword, definition)
        if @keywords[keyword]
        then m.reply "Redefining '#{keyword}' from: '#{@keywords[keyword]}' to: '#{definition}'."
        else m.reply "Defining '#{keyword}' with: '#{definition}'."
        end
        @keywords[keyword] = definition
        update_store
      end

      def keyword_check(m, keyword)
        if @keywords[keyword]
        then m.reply "'#{keyword}' is defined as: '#{@keywords[keyword]}'."
        else m.reply "'#{keyword}' is not defined."
        end
      end

      def keyword_forget(m, keyword)
        if
          @keywords[keyword]
        then
          m.reply "'#{keyword}' was defined as: '#{@keywords[keyword]}'."
          @keywords.delete(keyword)
          update_store
        else
          m.reply "'#{keyword}' is not defined."
        end
      end

      def find_keyword(m)
        @keywords.keys.map{|keyword|
          Regexp.new(keyword).match(m.message)
        }.compact.sort_by{|matchdata|
          matchdata.begin(0)
        }.each{|matchdata|
          m.reply @keywords[matchdata[0]]
        }
      end

      listen_to :channel
      def listen(m)
        case
          m.message
        when /^!keywords/
          keywords(m)
        when /^!keyword '([^']+)' (.+)$/, /^!keyword "([^"]+)" (.+)$/, /^!keyword (\S+) (.+)$/
          keyword_define(m, $1, $2)
        when /^!keyword (\S+)$/, /^!keyword\? (.+)$/
          keyword_check(m, $1)
        when /^!forget (.+)$/
          keyword_forget(m, $1)
        else
          find_keyword(m)
        end
      end

      def update_store
        synchronize(:update) do
          File.open('keywords.yaml', 'w') do |fh|
            YAML.dump(@keywords, fh)
          end
        end
      end

    end
  end
end
