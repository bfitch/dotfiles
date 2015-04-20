function! OpenSpecFile()
  ruby <<EOF
    class FileWrapper
      def initialize(path)
        @path = path
      end

      def absolute_path
        File.expand_path(@path)
      end

      def name
        name = File.basename(@path, extension)
        if name.include? '.js'
          name.split('.').first
        else
          name
        end
      end

      def extension
        File.extname(@path)
      end

      def ==(object)
        comparison_string == object.comparison_string
      end
      alias_method :eql?, :==

      def comparison_string
        common_path.gsub('_', '').gsub('.','').downcase
      end

      private

      def common_path
        common_directories + filename + extension
      end

      def common_directories
        path = (File.dirname(absolute_path).clone.split('/') - Dir.pwd.split('/') - blacklisted_directories)
        path.join('/')
      end

      def blacklisted_directories
        ["app", "assets", "spec", "konacha", "javascripts", "coffee"]
      end

      def filename
        case name
          when /spec/i then name
          else name + "spec" end
      end
    end

    class SpecFinder
      def initialize(current_file)
        @current_file = current_file
        @files ||= Dir.glob("**/spec/**/*").map { |path| FileWrapper.new(path) }
      end

      def open
        if file = spec_file
          VIM::command ":vsplit #{file.absolute_path}"
        else
          puts "No spec found for: #{@current_file.absolute_path}."
        end
      end

      def spec_file
        @files.select { |file| file == @current_file }.first
      end
    end

    current_file = FileWrapper.new(VIM::evaluate("expand('%:p')"))
    SpecFinder.new(current_file).open
EOF
endfunction
