require 'yaml'

module Chuork01
  module Booklet
    def talk_row(id)
      talk = talk_by_id(id)

      "#{talk['title'] || comming_soon}, #{talk['speaker']['name']}"
    end

    def talk_by_id(id)
      talks.detect {|talk| talk['id'] == id } || raise("Missing talk: id='#{id}'")
    end

    def comming_soon
      "(('tag:italic:(近日公開予定)'))"
    end

    def talks
      @talks ||= YAML.load(File.read('data/talks.yml'))
    end
  end
end
