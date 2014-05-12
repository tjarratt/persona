require 'open-uri'
require 'time'
require 'yajl'
require 'zlib'

module Persona
  class Github

    def initialize
      @committers = []
      @handles = []
      @repos = []
    end

    def random_committer
      @committers.to_a.sample
    end

    def random_handle
      @handles.to_a.sample
    end

    def random_repo
      @repos.to_a.sample
    end

    def fetch_today
      fetch_day(DateTime.now.to_date)
    end

    def fetch_yesterday
      fetch_day(DateTime.now.to_date - 1)
    end

    def fetch_day(date)
      raise ArgumentError unless date.kind_of? Date

      failures = 0

      0.upto(23).each do |hour|
        begin
          gz = open("http://data.githubarchive.org/#{date.to_s}-#{hour}.json.gz")
          js = Zlib::GzipReader.new(gz).read

          Yajl::Parser.parse(js) do |event|
            if event['actor'] && event['repository']
              @repos << event['repository']['name']
              @handles << event['actor']
              @committers << event['actor_attributes']['name']
            elsif event['type'] == 'GistEvent' || event['type'] == 'CreateEvent'
              next
            else
              failures += 1
              next
            end
          end
        rescue Exception => e
          puts "whoops! #{e.inspect}"
        end
      end

      puts "there were #{failures} events we could not parse"
    end
  end
end
