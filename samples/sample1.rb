# -*- coding: utf-8 -*-
require 'json'
require File.expand_path('../../knuplot.rb', __FILE__)

KNUPLOT_SAMPLE_JSON_STR = '
{
    "xlabel": "x",
    "ylabel": "y",
    "xrange": "[0:10]",
    "yrange": "[0:10]",
    "set_command_list": [
        "size ratio 1",
        "grid"
    ],
    "data_set_list": [
        {"title": "dots", "x": [7, 8.3, 7.5], "y": [2.1, 1, 3], "with": "points pointsize 3.0"},
        {"title": "lp", "x": [4, 5, 6, 5], "y": [4, 5, 6, 7], "with": "lp"},
        {"title": "xyerror_lines", "x": [1,2,3],"y": [1,2,3],"xdelta":[0.1,0.1,0.1],"ydelta":[0.2,0.2,0.2], "with": "xyerrorlines"}
    ]
}
'.freeze

if $0 == __FILE__
  hash = JSON.parse(KNUPLOT_SAMPLE_JSON_STR, :symbolize_names => true)
  hash[:set_command_list] << "terminal postscript eps enhanced color"
  hash[:output] = File.expand_path('../sample1.eps', __FILE__)
  knuplot(hash)
end
