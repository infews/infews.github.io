require "time"
module GitDateHelpers
  def updated_date(source_path)
    time = updated_at(source_path)
    time.strftime("%Y.%m.%d")
  end

  def updated_date_dashed(source_path)
    time = updated_at(source_path)
    time.strftime("%Y-%m-%d")
  end

  def created_date_dashed(source_path)
    time = `git log --pretty=format:"%ad" --date=short --diff-filter=A -- #{git_path(source_path)}`
    if time.empty?
      time = Time.now
      time.strftime("%Y-%m-%d")
    else
      time
    end
  end

  private

  def git_path(full_path)
    full_path.split("/").drop_while { |e| e != "source" }.join("/")
  end

  def updated_at(source_path)
    updated_time = `git log -n 1 --pretty=format:%cI -- #{git_path(source_path)}`
    if updated_time.empty?
      Time.new
    else
      Time.parse(updated_time)
    end
  end
end
