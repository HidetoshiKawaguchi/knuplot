# -*- coding: utf-8 -*-
require 'json'
require File.expand_path('../../knuplot.rb', __FILE__)

KNUPLOT_SAMPLE_JSON_STR = '
{
    "xlabel": "x",
    "ylabel": "y",
    "xrange": "[0:15]",
    "yrange": "[0:15]",
    "set_command_list": [
        "size ratio 1",
        "terminal postscript eps enhanced color",
        "grid"
    ],
    "data_set_list": [
        {"title": "hoge1", "x": [1, 2, 3], "y": [1, 2, 3]},
        {"title": "hoge2", "x": [4, 5, 6, 5], "y": [4, 5, 6, 7], "with": "lp"},
        {"title": "xyerror_lines", "x": [1,2,3],"y": [1,2,3],"xdelta":[0.1,0.1,0.1],"ydelta":[0.2,0.2,0.2], "with": "xyerrorlines"}
    ]
}
'.freeze

if $0 == __FILE__
  hash = ARGV[0] ? JSON(File.read(ARGV[0])) : JSON(KNUPLOT_SAMPLE_JSON_STR)
  p hash
  filepath = ARGV[1] ? ARGV[1] : File.expand_path('../hoge.eps', __FILE__)
  knuplot(filepath, hash)
end

