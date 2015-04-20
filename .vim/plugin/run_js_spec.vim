function! RunJsSpec()
  ruby <<EOF
    def absolute_path
      File.expand_path VIM::evaluate("expand('%:p')")
    end

    def filename
      File.basename(absolute_path)
    end

    def konacha_path
      path = (File.dirname(absolute_path).clone.split('/') - blacklisted_directories)
      path.join('/')
    end

    def blacklisted_directories
      ["Users", "brian", "src", "icisstaff", "spec", "konacha"]
    end

    def konacha_spec
      (konacha_path + "/#{filename}").gsub(/^\//,"")
    end

    # VIM::command "!zeus rake konacha:run SPEC=#{konacha_spec}"
    VIM::command "ConqueTermSplit zeus rake konacha:run SPEC=#{konacha_spec}"
EOF
endfunction
