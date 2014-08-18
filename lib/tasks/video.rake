namespace :video do
  desc "Find new videos"
  task new: :environment do
    Admin.scan(Admin::NEW_MODE)
  end

  desc "Refresh all videos"
  task all: :environment do
    Admin.scan(Admin::FULL_MODE)
  end

end
