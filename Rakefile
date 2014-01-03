require 'fileutils'

WIDTH = ENV['width'] || 500
HEIGHT = ENV['height'] || (WIDTH * 1.414).to_i
PDF_PATH = 'pdf/chuork01-booklet.pdf'

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
