# -*- coding: utf-8 -*-
require 'json'
require File.expand_path('../../knuplot.rb', __FILE__)

if $0 == __FILE__
  hash = JSON.parse(File.read(File.expand_path('../json/sample2.json', __FILE__)), :symbolize_names => true)
  ### epsファイルとして保存したいなら、以下の2行をコメントアウトして実行.同一ディレクトリにsample2.epsファイルが保存される
  # hash[:set_command_list] << "terminal postscript eps enhanced color"
  # hash[:output] = File.expand_path('../sample2.eps', __FILE__)
  knuplot(hash)
end
