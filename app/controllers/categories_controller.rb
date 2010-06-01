class CategoriesController < ApplicationController

  load_and_authorize_resource

  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.all

    #default_url_options(params[:format] => :iframe)

    respond_to do |format|
      format.html # index.html.erb
      format.iframe { render("index.html.erb", :layout => 'iframe.html.haml') }
      format.xml  { render :xml => @categories }
      format.js {render :layout => nil}
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.iframe { render "show.html.erb", :layout => 'iframe.html.haml' }
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.iframe { render "new.html.erb", :layout => 'iframe.html.haml' }
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html
      format.iframe { render "edit.html.erb", :layout => 'iframe.html.haml' }
    end
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:cat])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(@category) }
        format.iframe { redirect_to(category_path(@category, :format => :iframe)) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.iframe { render "new.html.erb", :layout => 'iframe.html.haml' }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:cat])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(@category) }
        format.xml  { head :ok }
        format.iframe { redirect_to(@category, :format => :iframe) }
      else
        format.html { render :action => "edit" }
        format.iframe { render "edit.html.erb", :layout => 'iframe.html.haml' }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.iframe { redirect_to(categories_url(:format => :iframe)) }
      format.xml  { head :ok }
    end
  end
end
