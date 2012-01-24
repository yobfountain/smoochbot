class SmoocheesController < ApplicationController
  
  #protect edit and unsubscribe methods
  before_filter :must_have_confirmation_code, :except => [:new, :create, :index]
  
  # GET /smoochees
  # GET /smoochees.xml
  def index
    if user_signed_in?
      @smoochees = Smoochee.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @smoochees }
      end
    else
      flash[:notice] = 'Please log in first!'
      redirect_to root_path
    end
  end

  # GET /smoochees/1
  # GET /smoochees/1.xml
  def show
    @smoochee = Smoochee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @smoochee }
    end
  end

  # GET /smoochees/new
  # GET /smoochees/new.xml
  def new
    @smoochee = Smoochee.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @smoochee }
    end
  end

  # GET /smoochees/1/edit
  def edit
    if params[:id]
      @smoochee = Smoochee.find(params[:id])
    elsif params[:confirmation_code]
      @smoochee = Smoochee.find_by_confirmation_code(params[:confirmation_code])
    end
  end
  
  # POST /smoochees
  # POST /smoochees.xml
  def create
    @smoochee = Smoochee.new(params[:smoochee])
    # I added the 3 lines below
    @smoochee.active = false
    @smoochee.email_verified = false
    @smoochee.confirmation_code

    respond_to do |format|
      if @smoochee.save
        # Not sure if I structured this line below correctly
        Notifications.confirmation(@smoochee, request.host_with_port).deliver
        flash[:notice] = 'Check your email!'
        format.html { redirect_to('/') }
        # format.xml  { render :xml => @smoochee, :status => :created, :location => @smoochee }
      else
        format.html { render :action => "new" }
        # format.xml  { render :xml => @smoochee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /smoochees/1
  # PUT /smoochees/1.xml
  def update
    @smoochee = Smoochee.find(params[:id])

    respond_to do |format|
      if @smoochee.update_attributes(params[:smoochee])
        format.html { redirect_to(@smoochee, :notice => 'Smoochee was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @smoochee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /smoochees/1
  # DELETE /smoochees/1.xml
  def destroy
    @smoochee = Smoochee.find(params[:id])
    @smoochee.destroy

    respond_to do |format|
      format.html { redirect_to(smoochees_url) }
      format.xml  { head :ok }
    end
  end
  
  # special method for editing from email
    def webedit
      @smoochee = Smoochee.find_by_confirmation_code(params[:confirmation_code])
    end
  
  def confirm
    # TODO add error handling here for no confirmation code
    @smoochee = Smoochee.find_by_confirmation_code(params[:confirmation_code])
    @smoochee.active = true
    @smoochee.email_verified = true
    @smoochee.save
    token = @smoochee.confirmation_code    
    
    if @smoochee.save
      flash[:notice] = 'Your account has been activated. Please take a moment to customize your account.'
      #send first email
      Notifications.article(@smoochee, Article.get_random_article, request.host_with_port).deliver
      # redirect to update
      redirect_to "/update/#{token}"
    end    
  end
  
  # need a confirm page view
  def unsub
    if params[:confirmation_code]
      Smoochee.deactivate_by_confirmation_code!(params[:confirmation_code])
      flash[:notice] = 'You have been unsubscribed. Smoochbot is sad.'
      redirect_to home_url
    end
  end
  
  def deactivate
    # TODO add a function to Smoochee like (deactivate) where you capture this logic
    smoochee = Smoochee.find_by_email(params[:smoochee][:email])
    if smoochee and smoochee.deactivate
        flash[:notice] = 'You have been unsubscribed. Smoochbot is sad.'
        redirect_to home_url 
    else
      flash[:error] = "That e-mail doesn't exist in our system"
      redirect_to unsub_url
    end
  end
  
  def must_have_confirmation_code
    #retrieve smoochee by confirmation_code
    @smoochee = Smoochee.find_by_confirmation_code(params[:confirmation_code])    
    # ensure they exist
    if @smoochee.nil?
      #that user does not exist
      flash[:error] = "That smoochee does not exist"
      redirect_to root_url
    end
  end
     
end
