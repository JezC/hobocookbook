class ManualController < ApplicationController
  
  caches_page :index, :manual_section
  
  TITLES = ActiveSupport::OrderedHash.new [['to-do',      "To Do List"],
                                           ['dryml-guide',"The DRYML Guide"]]
  
  def manual_section
    section      = params[:section].gsub('[^a-z_]', '')
    filename     = "#{RAILS_ROOT}/manual/#{section}.markdown"
    @title       = TITLES[section]
    @content     = HoboFields::MarkdownString.new(File.read(filename))
    @last_update = last_update filename
  end

  private
  
  def last_update(filename)
    date_s = `git log -1 manual/dryml-guide.markdown`.match(/^Date:\s*(.*)$/)[1]
    Date.parse(date_s)
  end
  
end
