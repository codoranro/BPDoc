class UserBusinessRolesController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :get_user_business_role, :only => [:destroy, :edit, :update]
  before_filter :authenticate_user!, :except => [:show, :create]
  
  def show
  	#@u = User.find(params[:id])
  	#respond_with(@business_roles = @u.business_user_roles)
    redirect_to :back
  end

  def new
    @user_business_role = UserBusinessRole.new(date_from:  Date.today.strftime("%d.%m.%Y"), date_to: Date.today.change(:month => 12, :day => 31).strftime("%d.%m.%Y"))
  end

  def create
    @user_business_role = UserBusinessRole.create(params[:user_business_role])
    @business_role = BusinessRole.find(@user_business_role.business_role_id)
    flash[:notice] = "Successfully created user_business_role." if @user_business_role.save
    begin
      UserBusinessRoleMailer.user_create_role(@user_business_role, current_user).deliver    # оповестим нового исполнителя
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:alert] = "Error sending mail to #{@user_business_role.user.email}"
    end
    respond_with(@business_role)
  end

  def destroy
    @user_business_role.destroy
    begin
      UserBusinessRoleMailer.user_delete_role(@user_business_role, current_user).deliver    # оповестим бывшего исполнителя
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:alert] = "Error sending mail to #{@user_business_role.user.email}"
    end
    respond_with(@business_role)
  end

  def edit
    respond_with(@business_role)
  end

  def update
    flash[:notice] = "Successfully updated user_business_role." if @user_business_role.update_attributes(params[:user_business_role])
    respond_with(@business_role)
  end

private
  def get_user_business_role
    @user_business_role = UserBusinessRole.find(params[:id])
    @business_role = BusinessRole.find(@user_business_role.business_role_id)
  end

end
