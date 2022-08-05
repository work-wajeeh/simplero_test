class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy join ]

  def index
    @groups = Group.all.includes(:user_groups)
  end

  def show
  end

  def new
    @group = current_user.groups.new
  end

  def edit
    redirect_to group_url(@group), notice: "You can't edit this group." unless @group.creator?(current_user)
  end

  def create
    @group = current_user.groups.create(group_params.merge(creator_id: current_user.id))
    respond_to do |format|
      if @group.present?
        format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def join
    joined = @group.add_user(current_user)
    respond_to do |format|
      if joined
        format.html { redirect_to group_url(@group), notice: "You have joined the group successfully." }
      else
        format.html { redirect_to groups_url, notice: "There was an error in joining this group." }
      end
    end
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, :access)
    end
end
