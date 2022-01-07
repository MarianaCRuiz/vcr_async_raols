class FileManager
  attr_accessor :full_address, :category, :code, :name

  def initialize(name: 'reportexample', category: :report_default)
    @name = name
    @category = category
    self.code = @code = Report.generate_code
    @report_path = CreateFolder.setting_report_folder(category)
    self.full_address = @full_address = Rails.root.join(@report_path, "#{name}#{@code}.html")
  end

  def create_file
    ReportContentManager.new(full_address: full_address, code: code, category: category, name: name).create
  end

  def self.destroy_file(report)
    FileUtils.rm_rf(report.address)
  end

  def self.destroy_all_files
    path = Rails.configuration.report_generator[:reports_folder]
    Dir[Rails.root.join("#{path}/**/*.html")].each { |f| FileUtils.rm_rf(f) }
  end
end