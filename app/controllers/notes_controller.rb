class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.notes_per_user(current_user.id)  
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end
  
  # GET /notes/new
  def new
    @note = Note.new
    @books =  my_books
  end

  # GET /notes/1/edit
  def edit
    @books =  my_books
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        @books =  my_books
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        @books =  my_books
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note 
      @note = Note.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render :'errors/invalid_id', status: :bad_request, :layout => false
      else
        if(@note.book.user_id != current_user.id)
          render :'errors/403', status: :forbidden, :layout => false
        end
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:name, :content, :book_id)
    end

    def my_books
      current_user.books.map{|book| [book.name, book.id]}
    end 
end