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

desc "Symlink dexfiles directory to ~/.dex"
task :install_dexfiles do
	FileUtils.ln_s Dir.pwd, File.join(Dir.home, ".dex")
end

desc "Generate updated README"
task :update_readme do

	authors = YAML::load_file 'authors.yaml'

	toc = "# dexfiles\n\n"

	toc << "Sites I’ve tweaked with **[Dex](https://github.com/meyer/dex)**.\n\n"

	n = 0

	# Ignore gitignored folders
	gitignore = []
	File.open('.gitignore').read.gsub!(/\r?\n/, "\n").each_line do |f|
		gitignore.push f
	end

	out = capture_stdout do
		puts "\n"
		Dir.glob("{global/,utilities/,*.*/}").each do |folder|
			# Check for /folder/
			next if gitignore.include? folder

			puts "## #{folder[0...-1]}\n\n"

			unless ['global/','utilities/'].include? folder
				# TODO: Make sure this is how Github slugifies headings
				slug = folder[0...-1].downcase.strip.gsub(/\s+/,'-').gsub(/[^\w-]/,'')
				toc << "- [#{folder[0...-1]}](##{slug})\n"
			end

			Dir.glob("#{folder}*/").each do |subfolder|
				# Check for /folder/subfolder/
				next if gitignore.include? subfolder
				no_yaml = true
				if File.exists? "#{subfolder}info.yaml"
					info = YAML::load_file "#{subfolder}info.yaml"
					no_yaml = false
				else
					info = {}
				end

				# Title comes from the folder name
				title = subfolder.split('/')[1]

				print "- **[#{title}](#{subfolder})**"

				if info.has_key? 'Author' and info['Author'] != 'Mike Meyer'
					print ' by '
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

	File.open('README.md', 'w+') {|f| f.write(toc + "\n\n---\n\n" + out.string) }

	puts "Updated dat README"
end