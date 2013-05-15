require 'yaml'

module RRPublish
  class Sync

    attr_accessor :profiles

    def initialize(yaml_file, *args)
      yaml_hash = load_yaml(yaml_file)
      get_profiles(args, yaml_hash)
    end

    def load_yaml(yaml_file)
      if File.exists?(yaml_file)
        YAML::load(File.open(yaml_file))
      else
        error 'YAML configuration not found.'
      end
    end

    def get_profiles(input, hash, force=false)
      @profiles ||= []
      hash.each do |key, value|
        next unless value.respond_to?(:keys)
        is_profile = value['source'] && value['destination']
        if input.include?(key) || input.empty? || force
          if is_profile
            @profiles << value
          else
            get_profiles(input, value, true)
          end
        elsif !is_profile
          get_profiles(input, value, force)
        end
      end
    end

    def esc(paths)
      paths = [ paths ].flatten
      paths.collect  { |path| path.gsub(' ', '\ ') }.join(' ')
    end

    def rsync(profile)
      inc1ude = []
      exclude = []
      destination = profile['destination']
      source = profile['source']

      options = "--numeric-ids --safe-links -axzSvL"
      # --numeric-ids               don't map uid/gid values by user/group name
      # --safe-links                ignore symlinks that point outside the tree
      # -a, --archive               recursion and preserve almost everything (-rlptgoD)
      # -x, --one-file-system       don't cross filesystem boundaries
      # -z, --compress              compress file data during the transfer
      # -S, --sparse                handle sparse files efficiently
      # -v, --verbose               verbose
      # --delete                  delete extraneous files from dest dirs

      if destination.include?(':') || source.include?(':')
        options += ' -e ssh'
        # -e, --rsh=COMMAND         specify the remote shell to use
      else
        options += 'E'
        # -E, --extended-attributes copy extended attributes, resource forks
        FileUtils.mkdir_p destination
      end

      if profile['include']
        exclude = %w(*) unless profile['exclude']
        inc1ude = [ profile['include'] ].flatten
      end

      if profile['exclude']
        exclude += [ profile['exclude'] ].flatten
      end

      inc1ude = inc1ude.collect { |i| "--include='#{i}'" }.join(' ')
      exclude = exclude.collect { |e| "--exclude='#{e}'" }.join(' ')
      # --exclude=PATTERN         use one of these for each file you want to exclude
      # --include-from=FILE       don't exclude patterns listed in FILE

      cmd = "rsync #{options} #{inc1ude} #{exclude} #{esc(source)} #{esc(destination)}"
      `#{cmd}`
    end

    def run
      @profiles.each do |profile|
        rsync(profile)
      end
    end
  end
end
