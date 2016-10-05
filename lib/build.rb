#!/env/ruby

require 'git'
require 'yaml'
require 'fileutils'

DOC_REPO_URI =
  "git@github.com:clingen-data-model/clingen-data-model.github.io.git"

# load the list of versions
versions = YAML.load_file('data/versions.yml')

# for each version...

## delete old version in DOC_REPO_URI (start clean)

# Assume that /source is a clone of the clingen-data-model.github.io
# repository. If it does not exist, clone that repo into /source
# Otherwise pull the latest commit
documentation_repo = nil
if File.exists?('stage')
  documentation_repo = Git.open('stage')
  documentation_repo.pull
else
  documentation_repo = Git.clone(DOC_REPO_URI, 'stage')
end
# Clean out documentation builds, (keep redirect at root index)
versions.each { |v| FileUtils.rm_rf("stage/#{v}") }
FileUtils.rm_rf('build')

# Remove the special case 'development' version
versions.delete('development')

## check out git branch by version (master==development)

## run shell to do middleman build for each version of each model repo

## copy build output into DOC_REPO_URI

main_repo = Git.open(Dir.pwd)

# checkout each version in turn, build the documentation for that version,
# then copy it into the versioned folder under /stage
versions.each do |v|
  main_repo.checkout(v)
  # TODO check for and handle build errros
  `bundle exec middleman build`
  FileUtils.mv('build', "stage/#{v}")
end

# Finish by building current docs
main_repo.checkout
`bundle exec middleman build`
FileUtils.mv('build', "stage/development")

# end version loop

# Check in and push current build
documentation_repo.add
documentation_repo.commit(Time.now)
documentation_repo.push
