#!/usr/bin/env python3

from bokeh.plotting import figure

from bokeh.io import export_svgs

plot = figure(width=400, height=300, output_backend="svg")
plot.line(x=[0, 1, 2, 3, 4, 5], y=[0, 1, 0, 0, -1, 0])
export_svgs(plot, 'svg_plot_1.svg')
plot.line(x=[0, 1, 2, 3, 4, 5], y=[0, 2, 0, 0, -2, 0])
export_svgs(plot, 'svg_plot_2.svg')
