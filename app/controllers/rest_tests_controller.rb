class RestTestsController < ApplicationController
  # GET /rest_tests
  # GET /rest_tests.xml
  def index
    @rest_tests = RestTest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rest_tests }
    end
  end

  # GET /rest_tests/1
  # GET /rest_tests/1.xml
  def show
    @rest_test = RestTest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rest_test }
    end
  end

  # GET /rest_tests/new
  # GET /rest_tests/new.xml
  def new
    @rest_test = RestTest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rest_test }
    end
  end

  # GET /rest_tests/1/edit
  def edit
    @rest_test = RestTest.find(params[:id])
  end

  # POST /rest_tests
  # POST /rest_tests.xml
  def create
    @rest_test = RestTest.new(params[:rest_test])

    respond_to do |format|
      if @rest_test.save
        format.html { redirect_to(@rest_test, :notice => 'RestTest was successfully created.') }
        format.xml  { render :xml => @rest_test, :status => :created, :location => @rest_test }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rest_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rest_tests/1
  # PUT /rest_tests/1.xml
  def update
    @rest_test = RestTest.find(params[:id])

    respond_to do |format|
      if @rest_test.update_attributes(params[:rest_test])
        format.html { redirect_to(@rest_test, :notice => 'RestTest was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rest_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rest_tests/1
  # DELETE /rest_tests/1.xml
  def destroy
    @rest_test = RestTest.find(params[:id])
    @rest_test.destroy

    respond_to do |format|
      format.html { redirect_to(rest_tests_url) }
      format.xml  { head :ok }
    end
  end
end
