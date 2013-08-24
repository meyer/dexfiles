#!/usr/bin/env ruby
# encoding: utf-8

require 'yaml'

require 'stringio'

# http://thinkingdigitally.com/archive/capturing-output-from-puts-in-ruby/
module Kernel
	def capture_stdout
		out = StringIO.new
		$stdout = out
		yield
		return out
	ensure
		$stdout = STDOUT
	end
end

authors = YAML::load_file 'authors.yaml'

toc = "# dexfiles\n\nSites I’ve tweaked with [Dex](https://github.com/meyer/dex).\n\n"

out = capture_stdout do
	puts "\n\n"
	Dir.glob("*/").each do |folder|
		puts "## #{folder[0...-1]}\n\n"
		toc << "*#{folder[0...-1]}*\n"
		Dir.glob("#{folder}*/").each do |subfolder|
			if File.exists? "#{subfolder}info.yaml"
				info = YAML::load_file "#{subfolder}info.yaml"
			else
				info = {}
			end

			print "* "

			title = ''
			if info.has_key? 'Title'
				title = info['Title']
			else
				title = subfolder.split('/')[1].gsub(/\w+/){|w| w.capitalize}
			end
			puts "### #{title} [↩](#{subfolder})"

			# TODO: Make sure this is how Github slugifies headings
			slug = title.downcase.strip.gsub(/\s+/,'-').gsub(/[^\w-]/,'')
			toc << "* [#{title}](##{slug})\n"

			if info.has_key? 'Description'
				print "\n\t"+info['Description']
			else
				print "\n\tNo `info.yaml` provided."
			end

			puts "\n\n"

			if info.has_key? 'Author'
				print "\t"
				if authors.has_key? info['Author']
					print '['
					print info['Author']
					print ']('
					print authors[info['Author']]
					print ')'
				else
					print info['Author']
				end
				print ' made this.'
			end

			if info.has_key? 'URL'
				puts "\n\t[Source](#{info['URL']})"
			end

			puts "\n\n"
		end
		puts "\n\n"
	end
end

# puts out.string # yeah i do

# puts toc + out.string

File.open('README.md', 'w+') {|f| f.write(toc + out.string) }

puts "Updated dat README"