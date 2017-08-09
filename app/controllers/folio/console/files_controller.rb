require_dependency 'folio/application_controller'

module Folio
  class Console::FilesController < Console::BaseController
    before_action :find_file, except: [:index, :create, :new]

    def index
      @images = Folio::Image.all
      @documents = Folio::Document.all
    end

    def new
      if params[:file_type] == 'image'
        @file = Image.new
      else
        @file = Document.new
      end
    end

    def create
      @files = []
      file_params[:files].each do |file|
        @files << Folio::File.create(file: file, type: file_params[:type])
      end
      respond_with @files, location: console_files_path
    end

    def update
      @file.update(file_params)
      respond_with @file, location: console_files_path
    end

    def destroy
      @file.destroy
      respond_with @file, location: console_files_path
    end

  private
    def find_file
      @file = Folio::File.find(params[:id])
    end

    def file_params
      params.require(:file).permit(:file, :type, files: [])
    end
  end
end
