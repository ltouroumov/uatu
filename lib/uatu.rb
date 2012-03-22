require 'fssm'

class Uatu

	def self.run(options)
		new(options).run!
	end

	def initialize(options)
		@options = options
	end

	def run!
		unless @options[:cmd] or @options[:script]
			puts "'-s SCRIPT' or '-c CMD' arguments required !"
			exit 1
		end

		puts "Watcher started"
		@last_update = Time.now
		FSSM.monitor(@options[:path]) do |mon|
			mon.update &(trigger_block :update)
			mon.create &(trigger_block :create)
			mon.delete &(trigger_block :delete)
		end
	end

private
	
	def trigger_block(evt)
		proc { |base, rel|
			trigger base, rel, evt
		}
	end

	def trigger(base, rel, evt)
		begin
			path = File.realpath(rel, base)
		rescue
			# if the file does not exist (in case of a deletion)
			path = rel
		end

		return if exclude? path
		return unless time_elapsed?

		puts "Changed %s" % [rel]
		
		if include? path
			run_script path if @options[:script]
			run_command path if @options[:cmd]
			@last_update = Time.now
		end
	end

	def exclude? (path)
		return false unless @options[:exclude]
		File.fnmatch(@options[:exclude], path)
	end

	def include? (path)
		return true unless @options[:pattern]
		File.fnmatch(@options[:pattern], path)
	end

	def time_elapsed?
		return true unless @options[:time]

		@last_update + @options[:time] <= Time.now
	end

	def run_script(change_path)
		puts "Triggered '%s'" % [@options[:script]]
		fork do
			exec("%s %s" % [@options[:script], change_path])
		end
	end

	def run_command(change_path)
		puts "Triggered '%s'" % [@options[:cmd]]
		fork do
			exec(@options[:cmd] % [change_path])
		end
	end

end