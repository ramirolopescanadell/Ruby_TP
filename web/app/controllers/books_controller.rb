class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.books_per_user(current_user.id)
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @notes = Note.notes_per_book(@book.id)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if @book.name != "Global"
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to @book, notice: 'Book was successfully updated.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to books_url, alert: "Can't edit Global book" }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if @book.name != "Global"
      @book.destroy
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      @book.empty
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully empty.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :note_id)
    end
end
