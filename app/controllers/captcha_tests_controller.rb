class CaptchaTestsController < ApplicationController

  validates_captcha

  # GET /captcha_tests
  # GET /captcha_tests.xml
  def index
    @captcha_tests = CaptchaTest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @captcha_tests }
    end
  end

  # GET /captcha_tests/1
  # GET /captcha_tests/1.xml
  def show
    @captcha_test = CaptchaTest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @captcha_test }
    end
  end

  # GET /captcha_tests/new
  # GET /captcha_tests/new.xml
  def new
    @captcha_test = CaptchaTest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @captcha_test }
    end
  end

  # GET /captcha_tests/1/edit
  def edit
    @captcha_test = CaptchaTest.find(params[:id])
  end

  # POST /captcha_tests
  # POST /captcha_tests.xml
  def create
    @captcha_test = CaptchaTest.new(params[:captcha_test])

    respond_to do |format|
      if @captcha_test.save
        flash[:notice] = 'CaptchaTest was successfully created.'
        format.html { redirect_to(@captcha_test) }
        format.xml  { render :xml => @captcha_test, :status => :created, :location => @captcha_test }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @captcha_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /captcha_tests/1
  # PUT /captcha_tests/1.xml
  def update
    @captcha_test = CaptchaTest.find(params[:id])

    respond_to do |format|
      if @captcha_test.update_attributes(params[:captcha_test])
        flash[:notice] = 'CaptchaTest was successfully updated.'
        format.html { redirect_to(@captcha_test) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @captcha_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /captcha_tests/1
  # DELETE /captcha_tests/1.xml
  def destroy
    @captcha_test = CaptchaTest.find(params[:id])
    @captcha_test.destroy

    respond_to do |format|
      format.html { redirect_to(captcha_tests_url) }
      format.xml  { head :ok }
    end
  end
end
