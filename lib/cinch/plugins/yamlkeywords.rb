require 'yaml'

module Cinch
  module Plugins
    class YamlKeywords
      include Cinch::Plugin

      def initialize(*args)
        super
        if File.exist?('keywords.yaml')
          @keywords = YAML.load_file('keywords.yaml')
        else
          @keywords = {}
        end
      end

      match(/keywords/, method: :keywords)
      def keywords(m)
        if @keywords.size > 0
          m.reply "Keywords start:"
          @keywords.each{|k,v| m.reply "'#{k}': '#{v}'." }
          m.reply "Keywords end."
        else
          m.reply "No keywords defined yet."
        end
      end

      match(/keyword (\S+) (.+)$/,  method: :keyword_define)
      match(/keyword '(.*)' (.+)$/, method: :keyword_define)
      match(/keyword "(.*)" (.+)$/, method: :keyword_define)
      def keyword_define(m, keyword, definition)
        if @keywords[keyword]
          m.reply "Redefining '#{keyword}' from: '#{@keywords[keyword]}' to: '#{definition}'."
        else
          m.reply "Defining '#{keyword}' with: '#{definition}'."
        end
        @keywords[keyword] = definition
        update_store
      end

      match(/keyword (\S+)$/, method: :keyword_check)
      def keyword_check(m, keyword)
        if @keywords[keyword]
          m.reply "'#{keyword}' is defined as: '#{@keywords[keyword]}'."
        else
          m.reply "'#{keyword}' is not defined."
        end
      end

      listen_to :channel
      def listen(m)
        if keyword = @keywords.keys.find{|k| Regexp.new(k).match(m.message) }
        then
          m.reply @keywords[keyword]
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
