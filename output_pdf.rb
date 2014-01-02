#!/usr/bin/env ruby

require 'fileutils'

WIDTH = ARGV[0] || 500
HEIGHT = (WIDTH * 1.414).to_i

options = [
  '--print',
  "--paper-width=#{WIDTH}",
  "--paper-height=#{HEIGHT}",
  '--output-filename=pdf/chuork01-booklet.pdf',
]

FileUtils.mkdir_p('pdf')

system('rabbit', *options)
