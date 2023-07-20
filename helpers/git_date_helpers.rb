require "time"
module GitDateHelpers
  def updated_at(source_path)
    relative_file_path_in_git = source_path.split("/").drop_while { |e| e != "source" }.join("/")
    Time.parse(`git log -n 1 --pretty=format:%cI -- #{relative_file_path_in_git}`)
  end

  def updated_date(source_path)
    time = updated_at(source_path)
    time.strftime("%Y.%m.%d")
  end

  def updated_date_dashed(source_path)
    time = updated_at(source_path)
    time.strftime("%Y-%m-%d")
  end

  def created_date_dashed(source_path)
    path = git_path(source_path)
    time = Time.parse(` git log --pretty=format:"%ad" --date=short --diff-filter=A -- #{path}`)
    time.strftime("%Y-%m-%d")
  end

  private

  def git_path(full_path)
    full_path.split("/").drop_while { |e| e != "source" }.join("/")
  end
end
