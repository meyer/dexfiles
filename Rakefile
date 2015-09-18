#!/usr/bin/env ruby
# encoding: utf-8

require 'yaml'
require 'stringio'

desc "Symlink dexfiles directory to ~/.dex"
task :install_dexfiles do
	FileUtils.ln_s Dir.pwd, File.join(Dir.home, ".dex")
end

class Array
	def to_sentence
		if self.length <= 2
			self.join(' and ')
		else
			self.push(self.pop(2).join(", and ")).join(", ")
		end
	end
end

desc "Generate updated README"
task :update_readme do
	authors = YAML::load_file 'authors.yaml'
	toc = []
	guts = []

	# Ignore gitignored folders
	gitignore = []
	File.open('.gitignore').read.gsub!(/\r?\n/, "\n").each_line do |f|
		gitignore.push f
	end

		Dir.glob("{global/,utilities/,*.*/}").each do |folder|
			# Check for /folder/
			next if gitignore.include? folder

			guts << "## #{folder[0...-1]}\n\n"

			unless ['global/','utilities/'].include? folder
				# TODO: Make sure this is how Github slugifies headings
				slug = folder[0...-1].downcase.strip.gsub(/\s+/,'-').gsub(/[^\w-]/,'')
				toc << "- [#{folder[0...-1]}](##{slug})"
			end

			Dir.glob("#{folder}*/").each do |subfolder|
				# Check for /folder/subfolder/
				next if gitignore.include? subfolder
				begin
					info = YAML::load_file("#{subfolder}info.yaml") || {}
				rescue Errno::ENOENT
					puts "No `info.yaml` file was found in `/#{subfolder}`."
					info = {}
				end

				# Title comes from the folder name
				title = subfolder.split('/')[1]

				guts << "- **[#{title}](#{subfolder})**"

				if info.has_key? 'Author' and info['Author'] != 'Mike Meyer'
					guts << ' by '
					guts << info['Author'].split(/(?:\s*[\/,\&]\s*)/).map! do |a|
						authors.has_key?(a) ? "[#{a}](#{authors[a]})" : a
					end.to_sentence
				end

				guts << " — "

				if info.has_key? 'Description'
					guts << info['Description']
					guts << '.' unless '.?!'.include? info['Description'][-1]
				else
					guts << "*No description provided.*"
				end

				if info.has_key? 'URL'
					guts << " [View source page](#{info['URL']})."
				end

				guts << "\n"
			end
			guts << "\n"
		end

	File.open('README.md', 'w+') do |f|
		f.write <<-README
# dexfiles

Sites I’ve tweaked with **[Dex](https://github.com/meyer/dex)**.

#{toc.join("\n")}

---

#{guts.join}
		README
	end

	puts "Updated dat README"
end