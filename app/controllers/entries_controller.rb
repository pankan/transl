class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # translation
  def translate
    @entry = Entry.new(entry_params)
    translator_client = BingTranslator.new('Qube_translate', '83w9saKc30/5IWhphrRKwzgyPeme2kMm0bBtVKDTNWY=')
    @entry.from = translator_client.detect(@entry.input)  if @entry.from == ""
    @entry.output = translator_client.translate @entry.input, from: @entry.from, to: @entry.to
  end

  # POST /entries
  # POST /entries.json
  def create
    translate
    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Successfully translated.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end  
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:input, :from, :to)
    end
end
