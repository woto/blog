class PostsController < ApplicationController

  # GET /posts
  # GET /posts.xml
  def index
    @tags = Post.tag_counts
    @posts = Post.paginate :page => params[:page], :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @post.visible = true
    @post.date = Time.now

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.user = current_user

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  def filter
    #scope = Post.by_category.tagged_with(params[:id], :on => :tags)
    scope = Post.tagged_with(params[:id], :on => :tags)
    @posts = scope.paginate(:page => params[:page], :order => 'created_at DESC')
    @tags = scope.tag_counts

    flash.now[:notice] = "Fitlering by #{params[:id]}"
   
    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @cakes }
    end
  end 

  def auto_complete_for_post_tag_list
    @tags = Tag.find(:all, :conditions => ['name LIKE ?', "#{params[:post][:tag_list]}%"]) 
    render :inline => "<%= auto_complete_result(@tags, 'name') %>", :layout => false 
  end

end
