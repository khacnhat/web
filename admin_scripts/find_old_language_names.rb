
# First post-LinuxPaas-refactoring script to use
# the app/models classes to navigate the domain

require File.expand_path(File.dirname(__FILE__)) + '/domain_lib'

disk = OsDisk.new
git = Git.new
runner = DockerRunner.new
paas = LinuxPaas.new(disk, git, runner)
format = 'json'
dojo = paas.create_dojo(CYBERDOJO_HOME_DIR, format)

languages_names = dojo.languages.collect {|language| language.name}

missing = { }
count = 0
dojo.katas.each do |kata|
  print '.'
  count += 1
  begin
    if !languages_names.include? kata.language.name
      missing[kata.language.name] ||= [ ]
      missing[kata.language.name] << kata.id
    end
  rescue SyntaxError => error
    puts "SyntaxError from kata #{kata.id}"
    puts error.message
  rescue Encoding::InvalidByteSequenceError => error
    puts "Encoding::InvalidByteSequenceError from kata #{kata.id}"
    puts error.message
  end
end
print "\n"
print "\n"
print "#{count} katas examined"
print "\n"
print "\n"
missing.keys.sort.each do |name|
  print "#{name} - #{missing[name].length}\n"
end
print "\n"
print "\n"
