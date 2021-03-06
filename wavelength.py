#!/usr/bin/env python3
import argparse
import math

class ArgumentParserWithDefaults(argparse.ArgumentParser):
	def add_argument(self, *args, help=None, default=None, **kwargs):
		if help is not None:
			kwargs['help'] = help
		if default is not None and args[0] != '-h':
			kwargs['default'] = default
			if help is not None:
				kwargs['help'] += ' Default: {}'.format(default)
		super().add_argument(*args, **kwargs)

parser = ArgumentParserWithDefaults(
	formatter_class=argparse.RawTextHelpFormatter
)

parser.add_argument('-f', '--freq', type=float, default=450e6, help='freq')
parser.add_argument('-o', '--output', type=str, default="in", help='output format: cm, m, in, ft')
parser.add_argument('-s', '--spacing', type=float, default="0.33", help='spacing factor for DOA arrays')

args = parser.parse_args()


c = 299792458 # speed of light meters / second

def freq_to_lambda(freq):
	return c / freq

def cm_to_in(cm):
	return cm * 0.39370

wavelength = freq_to_lambda(args.freq)

if args.output == "m":
	wl = wavelength
	output_format = "m"
elif args.output == "cm":
	wl = wavelength*100
	output_format = "cm"
elif args.output == "in":
	wl = cm_to_in(wavelength*100)
	output_format = "in"
elif args.output == "ft":
	wl = cm_to_in(wavelength*100)/12
	output_format = "ft"
else:
	print("error with format, using inches")
	wl = cm_to_in(wavelength*100)
	output_format = "in"


wl2 = float(wl/2)
wl4 = float(wl/4)


interelement_spacing = wl * args.spacing
array_radius = (wl * args.spacing) / math.sqrt(2)
array_diameter = array_radius * 2

print("--------------------")
print("Frequency: %s" % args.freq)
print("Spacing Factor: %s" % args.spacing)
print("Wavelength (%s): %.4f" % (output_format, wl))
print("Half Wavelength (%s): %.4f" % (output_format, wl2))
print("Quarter Wavelength (%s): %.4f" % (output_format, wl4))

print("--------------------")
print("ULA Spacing (%s): %.4f" % ( output_format, interelement_spacing))
print("--------------------")
print("UCA Diamter (%s): %.4f" % ( output_format, array_diameter))
print("UCA Radius (%s): %.4f" % ( output_format, array_radius))
print("UCA inter-element Spacing (%s): %.4f" % ( output_format, interelement_spacing))
print("--------------------")
