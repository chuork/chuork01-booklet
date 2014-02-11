# -*- coding: utf-8 -*-
#
# Copyright (C) 2014  Masafumi Yokoyama <myokoym@gmail.com>
#
# License: GPLv2 or later
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

require 'fileutils'
require 'open-uri'
require 'erb'
require 'poppler'
require 'cairo'

base_dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(base_dir, "lib"))
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

task :create_pdf do
  options = [
    '--print',
    "--paper-width=#{WIDTH}",
    "--paper-height=#{HEIGHT}",
    "--output-filename=#{PDF_PATH}",
  ]
  FileUtils.mkdir_p('pdf')
  system('rabbit', *options)
end

task :edit_pdf do
  width = WIDTH * 2
  height = HEIGHT
  columns = 2
  page_order = [3, 0, 1, 2]

  document = Poppler::Document.new(PDF_PATH)
  pages = page_order.collect {|i| document[i] }

  #aspect_ratio = 1.0 * width / height
  #x_ratio = 1.0 * aspect_ratio / columns
  #y_ratio = 1.0 / aspect_ratio

  Cairo::PDFSurface.new("#{PDF_PATH}.tmp", width, height) do |surface|
    Cairo::Context.new(surface) do |context|
      pages.each_with_index do |page, i|
        column = i % columns
        x = width / columns * column
        context.save do
          context.translate(x, 0)
          #context.scale(x_ratio, y_ratio)
          context.render_poppler_page(page)
        end
        context.show_page if column == (columns - 1)
      end
    end
  end
  FileUtils.mv("#{PDF_PATH}.tmp", PDF_PATH)
end

desc "PDFを生成し、印刷用に編集: #{PDF_PATH}"
task :pdf => [:create_pdf, :edit_pdf]

task :default => :preview
