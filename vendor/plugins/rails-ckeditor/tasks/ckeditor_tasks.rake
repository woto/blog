namespace :ckeditor do
  def setup
    require "config/environment"
    require 'fileutils'

    directory = File.join(RAILS_ROOT, '/vendor/plugins/rails-ckeditor/')
    require "#{directory}lib/ckeditor"
    require "#{directory}lib/ckeditor/version"
    require "#{directory}lib/ckeditor/utils"
  end

  desc 'Install the CKEditor components'
  task :install do
    setup
    puts "** Installing CKEditor Plugin version #{Ckeditor::Version.current}..."

    Ckeditor::Utils.destroy_and_install

    puts "** Successfully installed CKEditor Plugin version #{Ckeditor::Version.current}"
  end

  desc 'Uninstall the CKEditor components'
  task :uninstall do
    setup
    puts "** Uninstalling CKEditor Plugin version #{Ckeditor::Version.current}..."
    Ckeditor::Utils.destroy

    puts "** Uninstalling Rails CKEditor Plugin Files..."
    Ckeditor::Utils.rm_plugin
    puts "** Successfully Uninstalled CKEditor Plugin version #{Ckeditor::Version.current}"
  end
  
  desc "Generate configuration"
  task :config do
    directory = File.join(RAILS_ROOT, '/vendor/plugins/rails-ckeditor/')
    require "#{directory}lib/ckeditor/config"
    Ckeditor::Config.create_yml
  end

  def fetch(path)
    response = Net::HTTP.get_response(URI.parse(path))
    case response
    when Net::HTTPSuccess     then
      response
    when Net::HTTPRedirection then
      puts "** Redirected to #{response['location']}"
      fetch(response['location'])
    else
      response.error!
    end
  end

  desc "Update the CKEditor code to the latest nightly build"
  task :download do
    require 'net/http'
    require 'zip/zipfilesystem'

    setup
    version = ENV['VERSION'] || "Nightly"
    installed_version = "3.0"

    puts "** Current CKEditor version: #{installed_version}..."
    puts "** Downloading #{version} (please be patient)..."

    rails_tmp_path = File.join(RAILS_ROOT, "/tmp/")
    tmp_zip_path = File.join(rails_tmp_path, "ckeditor_#{version}.zip")

    # Creating tmp dir if it doesn't exist
    Dir.mkdir(rails_tmp_path) unless File.exists? rails_tmp_path

    # Download nightly build (http://download.cksource.com/CKEditor/CKEditor/Nightly%20Build/ckeditor_nightly.zip)
    # Releases (http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.0/ckeditor_3.0.zip)
    nightly = version=='Nightly' ? true : false
    domain = "http://download.cksource.com"
    path = nightly ? "/CKEditor/CKEditor/Nightly%20Build/ckeditor_nightly.zip" : "/CKEditor/CKEditor/CKEditor%203.0/ckeditor_#{version}.zip"

    puts "** Download from #{domain}#{path}"
    #Net::HTTP.start(domain) { |http|
      response = fetch("#{domain}#{path}")

      open(tmp_zip_path, "wb") { |file|
        file.write(response.body)
      }
    #}
    puts "** Download successful"

    puts "** Extracting CKeditor"
    Zip::ZipFile.open(tmp_zip_path) do |zipfile|
      zipfile.each do |entry|
        filename = File.join(rails_tmp_path, entry.name)
        FileUtils.rm_f(filename)
        FileUtils.mkdir_p(File.dirname(filename))
        entry.extract(filename)
      end
    end

    puts "** Backing up existing CKEditor install to /public/javascripts/ckeditor_bck"
    Ckeditor::Utils.backup_existing

    puts "** Shifting files to /public/javascripts/ckeditor"
    FileUtils.cp_r File.join(RAILS_ROOT, "/tmp/ckeditor/"), File.join(RAILS_ROOT, "/public/javascripts/")

    puts "** Clean up"
    FileUtils.remove_file(tmp_zip_path, true)
    FileUtils.remove_entry(File.join(rails_tmp_path, "ckeditor/"), true)

    puts "** Successfully updated to CKEditor version: #{version}..."
  end
end

