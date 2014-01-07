require 'fileutils'
require 'open-uri'
require 'erb'
require 'chuork01/booklet'

include Chuork01::Booklet

WIDTH = ENV['width'] || 500
HEIGHT = ENV['height'] || (WIDTH * 1.414).to_i
PDF_PATH = 'pdf/chuork01-booklet.pdf'
TALKS_URI = 'https://raw.github.com/chuork/chuork01/master/data/talks.yml'

desc '講演詳細を同期'
task :sync do
  FileUtils.mkdir_p('data')
  File.open('data/talks.yml', 'w') do |file|
    file.puts(open(TALKS_URI).read)
  end
end

desc 'PDFのソースファイルを生成'
task :generate => :sync do
  rabbit_source_path = 'timetable-and-introduction.rab'
  erb = ERB.new(File.read("#{rabbit_source_path}.erb"))
  File.open(rabbit_source_path, 'w') do |file|
    file.puts(erb.result)
  end
end

desc 'プレビューを表示'
task :preview do
  options = [
    "--width=#{WIDTH}",
    "--height=#{HEIGHT}",
  ]
  system('rabbit', *options)
end

desc "PDFを生成: #{PDF_PATH}"
task :pdf do
  options = [
    '--print',
    "--paper-width=#{WIDTH}",
    "--paper-height=#{HEIGHT}",
    "--output-filename=#{PDF_PATH}",
  ]
  FileUtils.mkdir_p('pdf')
  system('rabbit', *options)
end

task :default => :preview
