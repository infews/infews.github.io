require "time"
module GitDateHelpers
  def updated_date(source_path)
    updated_time(source_path)
      .strftime("%Y.%m.%d")
  end

  def updated_date_dashed(source_path)
    updated_time(source_path)
      .strftime("%Y-%m-%d")
  end

  def created_date_dashed(source_path)
    created_time(source_path)
      .strftime("%Y-%m-%d")
  end

  def updated_time(source_path)
    updated_time = `git log -n 1 --pretty=format:%cI -- #{git_path(source_path)}`
    now_if_empty(updated_time)
  end

  def created_time(source_path)
    created_time = `git log --pretty=format:%aI --diff-filter=A -- #{git_path(source_path)}`
    now_if_empty(created_time)
  end

  private

  def git_path(full_path)
    full_path.split("/").drop_while { |e| e != "source" }.join("/")
  end

  def now_if_empty(time)
    if time.empty?
      Time.now
    else
      Time.parse(time)
    end
  end
end
