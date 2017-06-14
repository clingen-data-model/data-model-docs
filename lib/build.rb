#!/env/ruby

require 'git'
require 'yaml'
require 'fileutils'

DOC_REPO_URI =
  "git@github.com:clingen-data-model/clingen-data-model.github.io.git"
DOC_REPO_LOCAL = 'clingen-data-model.github.io'

# load the list of versions
models = YAML.load_file('data/models.yml')

# Create documentation in a staging directory
puts "Cleaning old builds"
FileUtils.rm_rf('build')
FileUtils.rm_rf('stage')
FileUtils.rm_rf(DOC_REPO_LOCAL)
puts "checking out github pages repo"
Git.clone DOC_REPO_URI, DOC_REPO_LOCAL, :depth => 1
puts "building base repo"
`bundle exec middleman build`

FileUtils.rm_rf Dir.glob("#{DOC_REPO_LOCAL}/*") # remove everything except dotfiles (like '.git'...)
FileUtils.cp_r("build/.", DOC_REPO_LOCAL)

FileUtils.mkdir_p('stage')

FileUtils.cd('stage') do
  puts "building models"
  models.each do |k, v|
    puts "building #{k}"
    puts v.to_yaml
    repo = Git.clone(v['repository'], k)
    FileUtils.mkdir_p(File.join('..', DOC_REPO_LOCAL, k))
    FileUtils.cd(k) do
      puts "buliding master"
      repo.checkout('master')
      raise "error installing bundle for master of #{k}" unless system('bundle')
      raise "error building master of #{k}" unless system('bundle', 'exec', 'middleman', 'build')
      target = File.join('..', '..', DOC_REPO_LOCAL, k, 'master')
      FileUtils.mv('build', target)
      FileUtils.cd(File.join('..', '..', DOC_REPO_LOCAL, k)) do
        Dir.glob(File.join('master', '*')).each do |target|
          if File.directory? target
            FileUtils.ln_s target, '.'
          else
            FileUtils.ln target, '.'
          end
        end
      end
      v['versions'].each do |version|
        puts "building #{version}"
        FileUtils.rm_rf('build')
        repo.checkout(version)
        raise "error installing bundle for #{version} of #{k}" unless system('bundle')
        raise "error building #{version} of #{k}" unless system('bundle', 'exec', 'middleman', 'build')
        target = File.join('..', '..', DOC_REPO_LOCAL, k, version)
        FileUtils.mv('build', target)
      end
    end
  end
end

g = Git.open(DOC_REPO_LOCAL)
g.add(:all=>true)

puts "Changes are staged to #{DOC_REPO_LOCAL}, 'git commit' there if you dare..."

# for each version...

## delete old version in DOC_REPO_URI (start clean)

# Assume that /source is a clone of the clingen-data-model.github.io
# repository. If it does not exist, clone that repo into /source
# Otherwise pull the latest commit


# documentation_repo = nil
# if File.exists?('stage')
#   documentation_repo = Git.open('stage')
#   documentation_repo.pull
# else
#   documentation_repo = Git.clone(DOC_REPO_URI, 'stage')
# end
# # Clean out documentation builds, (keep redirect at root index)
# versions.each { |v| FileUtils.rm_rf("stage/#{v}") }
# FileUtils.rm_rf('build')

# # Remove the special case 'development' version
# versions.delete('development')

# ## check out git branch by version (master==development)

# ## run shell to do middleman build for each version of each model repo

# ## copy build output into DOC_REPO_URI

# main_repo = Git.open(Dir.pwd)

# # checkout each version in turn, build the documentation for that version,
# # then copy it into the versioned folder under /stage
# versions.each do |v|
#   main_repo.checkout(v)
#   # TODO check for and handle build errros
#   `bundle exec middleman build`
#   FileUtils.mv('build', "stage/#{v}")
# end

# # Finish by building current docs
# main_repo.checkout
# `bundle exec middleman build`
# FileUtils.mv('build', "stage/development")

# # end version loop

# # Check in and push current build
# documentation_repo.add
# documentation_repo.commit(Time.now)
# documentation_repo.push
