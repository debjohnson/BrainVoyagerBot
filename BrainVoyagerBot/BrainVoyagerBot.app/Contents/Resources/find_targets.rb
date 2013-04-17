subject_dirs    = ARGV[0]
target_search_string = ARGV[1]

subject_dirs = subject_dirs.split("%%%")

# subjects = []
#
# subject_dirs.each do |dir|
#   subjects << { :base_path => dir }
# end
#
#
# subjects.each do |subject|
#   dir_entries = Dir.entries(subject[:base_path])
#   subject[:target_file] = dir_entries.grep(Regexp.new(target_search_string)) { |match| File.join(subject[:base_path], match) }
# end
#
# target_files = []
#
# subjects.each do |subject|
#   target_files << subject[:target_file]
# end
#
# print target_files.join("&&")

subjects = []
target_files = []
error_dirs = []
subject_dirs.each do |dir|
    subjects << { :base_path => dir }
end

subjects.each do |subject|
    dir_entries = Dir.entries(subject[:base_path])
    matching_files = dir_entries.grep(Regexp.new(target_search_string)) { |match| File.join(subject[:base_path], match) }
    if matching_files.one?
        subject[:target_file] = matching_files
        target_files << subject[:target_file]
        else
        subject[:error_dir] = matching_files
        error_dirs << subject[:error_dir]
    end
end

if error_dirs.flatten.size == 0
    print target_files.join("&&")
else
    print "ERROR"
end
