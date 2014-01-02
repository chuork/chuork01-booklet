#!/usr/bin/env ruby

WIDTH = ARGV[0] || 500
HEIGHT = (WIDTH * 1.414).to_i

options = [
  "--width=#{WIDTH}",
  "--height=#{HEIGHT}",
]

system('rabbit', *options)
