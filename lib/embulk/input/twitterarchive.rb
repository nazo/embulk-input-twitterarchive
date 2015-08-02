require 'json'
require 'time'

module Embulk
  module Input

    class TwitterarchiveInputPlugin < InputPlugin
      # input plugin file name must be: embulk/input/<name>.rb
      Plugin.register_input('twitterarchive', self)

      def self.transaction(config, &control)
        directory = config.param('directory', :string, default: nil)
        index_file = File.read(File.join(directory, 'data/js/tweet_index.js'))
        files = []
        JSON.parse(index_file.gsub(/var tweet_index =  /, '')).each do |file_meta|
          files.push(file_meta['file_name'])
        end
        task = {
          'files' => files,
          'directory' => directory
        }

        columns = [
          Column.new(0, 'id', :long),
          Column.new(1, 'text', :string),
          Column.new(2, 'source', :string),
          Column.new(3, 'in_reply_to_status_id', :long),
          Column.new(4, 'created_at', :timestamp),
        ]

        resume(task, columns, files.length, &control)
      end

      def self.resume(task, columns, count, &control)
        puts "Twitter Archive input started."
        commit_reports = yield(task, columns, count)
        puts "Twitter Archive input finished. Commit reports = #{commit_reports.to_json}"

        next_config_diff = {}
        return next_config_diff
      end

      def initialize(task, schema, index, page_builder)
        super
        @file = task['files'][index]
        @directory = task['directory']
      end

      def run
        puts "Twitter Archive input thread #{@index}..."

        tweet_file = File.read(File.join(@directory, @file))
        JSON.parse(tweet_file.gsub(/Grailbird\.data\.tweets_[0-9]+_[0-9]+ = /, '')).each do |tweet|
          @page_builder.add([tweet['id'], tweet['text'], tweet['source'], tweet['in_reply_to_status_id'], Time.parse(tweet['created_at'])])
        end
        @page_builder.finish  # don't forget to call finish :-)

        commit_report = {}
        return commit_report
      end
    end

  end
end
