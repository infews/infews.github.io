require 'json'
require 'yaml'

# Fetch repository data from GitHub CLI
json = `gh repo list --json name,description,url,pushedAt,isFork,isArchived,parent,isPrivate --limit 1000`
repos = JSON.parse(json)
repos.sort_by! { |repo| repo["pushedAt"] }.reverse!

# Process and enrich each repo entry
processed = repos.map do |repo|
  is_fork = repo['isFork']
  parent_url = nil

  if is_fork && repo['parent']
    owner = repo['parent']['owner']['login']
    parent_name = repo['parent']['name']
    parent_url = "https://github.com/#{owner}/#{parent_name}"
  end

  {
    'name' => repo['name'],
    'description' => repo['description'],
    'url' => repo['url'],
    'pushedAt' => repo['pushedAt'],
    'isFork' => is_fork,
    'isArchived' => repo['isArchived'],
    'parentUrl' => parent_url,
    'isPrivate' => repo['isPrivate']
  }
end

# Group by isFork and sort each group by pushedAt (descending)
forks, non_forks = processed.partition { |r| r["isFork"] }
grouped = {
  'nonForks' => non_forks,
  'forks'    => forks
}

# Output to YAML
File.write("data/repos.yaml", grouped.to_yaml)

puts "✅ YAML grouped by isFork and sorted by pushedAt saved to repos.yaml"
