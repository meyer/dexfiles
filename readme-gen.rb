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

toc = "# dexfiles\n\n"

toc << "**Sites I’ve tweaked with [Dex](https://github.com/meyer/dex)**\n\n"

n = 0

out = capture_stdout do
	puts "\n\n"
	Dir.glob("{*.*/,global/,utilities/}").each do |folder|
		puts "## #{folder[0...-1]}\n\n"

		unless ['global/','utilities/'].include? folder
			slug = folder[0...-1].downcase.strip.gsub(/\s+/,'-').gsub(/[^\w-]/,'')
			toc << "- **[#{folder[0...-1]}](##{slug})**\n"
		end

		Dir.glob("#{folder}*/").each do |subfolder|
			no_yaml = true
			if File.exists? "#{subfolder}info.yaml"
				info = YAML::load_file "#{subfolder}info.yaml"
				no_yaml = false
			else
				info = {}
			end

			title = ''
			if info.has_key? 'Title'
				title = info['Title']
			else
				title = subfolder.split('/')[1].gsub(/\w+/){|w| w.capitalize}
			end

			# TODO: Make sure this is how Github slugifies headings
			# slug = title.downcase.strip.gsub(/\s+/,'-').gsub(/[^\w-]/,'')
			# n += 1
			# slug << "-#{n}"

			# toc << "  - #{title}\n"

			print "- **[#{title}](#{subfolder})** "

			if info.has_key? 'Author'
				print 'by '
				if authors.has_key? info['Author']
					print '['
					print info['Author']
					print ']('
					print authors[info['Author']]
					print ')'
				else
					print info['Author']
				end
			end

			print " — "

			if info.has_key? 'Description'
				print info['Description']
				print '.' unless '.?!'.include? info['Description'][-1,1]
			else
				if no_yaml
					print "No `info.yaml` file was found in `/#{subfolder}`."
				else
					print "No description provided."
				end
			end

			if info.has_key? 'URL'
				print " [View source page](#{info['URL']})."
			end

			puts
		end
		puts "\n"
	end
end

# puts out.string # yeah i do

# puts toc + out.string

File.open('README.md', 'w+') {|f| f.write(toc + "\n\n---\n\n" + out.string) }

puts "Updated dat README"