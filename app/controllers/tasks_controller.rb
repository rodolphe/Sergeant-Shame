class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.xml
  def index
    redirect_to "/" unless session.has_key? :user_id
    @user = User.find session[:user_id]
    @tasks = @user.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])
    @check_ins = @task.check_ins

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new
    redirect_to "/" unless session.has_key? :user_id
    @user = User.find session[:user_id]
    @checkins = MiniFB.get(@user.fb_access_token, 'me/checkins')
    @places = {}
    @checkins['data'].each do |checkin|
      @places[checkin['place']['name']] = checkin['place']['id']
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])
    redirect_to "/" unless session.has_key? :user_id
    @user = User.find session[:user_id]

    respond_to do |format|
      if @task.save
        @task.user = @user
        @task.save
        format.html { redirect_to(@task, :notice => "I'll see what I can do you dirty ape.") }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@task, :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
end
