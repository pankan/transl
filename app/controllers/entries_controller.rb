class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :destroy]
  #Bing Translator client and credentials
  @@translator_client = BingTranslator.new('Qube_translate', '83w9saKc30/5IWhphrRKwzgyPeme2kMm0bBtVKDTNWY=')
  
  # This snippet is not supported in rails 4. Find the subsitute language_list.rb in initializers
  # available_lang_codes = @translator_client.supported_language_codes
  # $language_list = available_lang_codes.each do 
  #   |lang_code|
  #   [@@translator_client.language_names(lang_code), lang_code]
  # end
  
  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/:id
  # GET /entries/:id.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # translation
  def translate
    @entry.from = @@translator_client.detect(@entry.input)  if @entry.from == ""
    @entry.output = @@translator_client.translate @entry.input, from: @entry.from, to: @entry.to
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
    translate
    respond_to do |format|
      if @entry.save
        format.html { redirect_to root_path, notice: 'Successfully translated.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end  
  end

  # DELETE /entries/:id
  # DELETE /entries/:id.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Translation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Parameter white listing.
    def entry_params
      params.require(:entry).permit(:input, :from, :to)
    end
end
