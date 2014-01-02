#!/usr/bin/env ruby

require 'fileutils'

FileUtils.mkdir_p('pdf')

system('rabbit',
       '--print',
       '--slides-per-page=2',
       '--output-filename=pdf/chuork01-booklet.pdf')
