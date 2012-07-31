require 'listen'

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
    Listen.to(@options[:path]) do |mod, add, del|
      trigger(mod + add + del)
    end
	end

private

	def trigger(paths)
		# return if paths.any? { |p| exclude? p }
		return unless time_elapsed?

		puts "Changed %s" % [paths]
		
		if paths.any? { |p| include? p }
			run_script paths if @options[:script]
			run_command paths if @options[:cmd]
			@last_update = Time.now
		end
	end

	# def exclude? (path)
	# 	return false unless @options[:exclude]
	# 	File.fnmatch(@options[:exclude], path)
	# end

	def include? (path)
		return true unless @options[:pattern]
		File.fnmatch(@options[:pattern], path)
	end

	def time_elapsed?
		return true unless @options[:time]

		@last_update + @options[:time] <= Time.now
	end

	def run_script(change_paths)
		puts "Triggered '%s'" % [@options[:script]]
		fork do
			exec("%s %s" % [@options[:script], change_paths.join(' ')])
		end
	end

	def run_command(change_paths)
		puts "Triggered '%s'" % [@options[:cmd]]
		fork do
			exec(@options[:cmd] % [change_paths.join(' ')])
		end
	end

end