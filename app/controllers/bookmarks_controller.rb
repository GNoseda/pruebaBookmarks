class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[ show edit update destroy ]

  # GET /bookmarks or /bookmarks.json
  def index
    #Index info
    @bookmarks = Bookmark.all
    
    #Form info
    @bookmark = Bookmark.new
    
    #Category Options
    @category_options = Category.all
    @kind_options = Kind.all

  end
  
  def stats
    #Graphic options
    @category_bmk = BookmarkCategory.group(:category_id).count()
    total = @category_bmk.inject(0) { |acc, (k,v)| acc+= v }
    @category_bmk = @category_bmk.map{|k,v| ["#{Category.find(k).title}: #{v} (#{percent(v,total)}%)", v] }.to_h
    
    @kind_bmk = BookmarkKind.group(:kind_id).count()
    total = @kind_bmk.inject(0) { |acc, (k,v)| acc+= v }
    @kind_bmk = @kind_bmk.map{|k,v| ["#{Kind.find(k).title}: #{v} (#{percent(v,total)}%)", v] }.to_h
  end

  # GET /bookmarks/1 or /bookmarks/1.json
  def show
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # GET /bookmarks/1/edit
  def edit
    #Category Options
    @category_options = Category.all
    @kind_options = Kind.all

  end

  # POST /bookmarks or /bookmarks.json
  def create
    @bookmark = Bookmark.new(bookmark_params)
    respond_to do |format|
      if @bookmark.save
        @bookmarks = Bookmark.all
        @category_options = Category.all
        @kind_options = Kind.all
        format.js { render nothing: true, notice: "Bookmark was successfully created." }
        format.html { redirect_to @bookmark, notice: "Bookmark was successfully created." }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookmarks/1 or /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to @bookmark, notice: "Bookmark was successfully updated." }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /bookmarks/1 or /bookmarks/1.json
  def destroy
    @bookmark.destroy_dependant
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: "Bookmark was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bookmark_params
      params.require(:bookmark).permit(:title, :url, category_ids:[], kind_ids:[])
    end

    def percent(v,total)
      ((v.to_f/total.to_f)*100).round(2)
    end
end
