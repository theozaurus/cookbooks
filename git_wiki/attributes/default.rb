git_wiki Mash.new unless attribute?("git_wiki")

git_wiki[:name] = "wiki" unless git_wiki.has_key?(:name)
git_wiki[:user] = git_wiki[:name] unless git_wiki.has_key?(:user)
git_wiki[:path] = "/home/#{git_wiki[:user]}/#{git_wiki[:name]}" unless git_wiki.has_key?(:path)
git_wiki[:ssh_keys] = [] unless git_wiki.has_key?(:ssh_keys)

