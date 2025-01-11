function path_append
  set -l newpath $argv[1]
  for p in $PATH
    if [ $p = $newpath ]
      return
    end
  end
  if [ ! -d $newpath ]
    echo "Path does not exist: $newpath"
  end
  set PATH $PATH $newpath
end

function source_if_exists
  set -l filename $argv[1]
  if [ -f $filename ]
    source $filename
  end
end

function source_with_platform_if_exists
  set -l fullpath $argv[1]

  set -l components (string split '.' "$fullpath")
  set -l extension $components[-1]
  set -l filename (string join '.' $components[1..-2])

  set -l platform (uname)

  set -l platform_file "$filename-$platform.$extension"

  source_if_exists $fullpath
  source_if_exists $platform_file
end
