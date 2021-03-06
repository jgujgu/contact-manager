class PhoneNumbersController < ApplicationController
  before_action :find_resource, only: [:edit, :update, :destroy]

  def new
    @phone_number = PhoneNumber.new(contact_id: params[:contact_id], contact_type: params[:contact_type])
  end

  # GET /phone_numbers/1/edit
  def edit
  end

  def create
    @phone_number = PhoneNumber.new(phone_number_params)

    respond_to do |format|
      if @phone_number.save
        format.html { redirect_to @phone_number.contact }
        format.json { render :show, status: :created, location: @phone_number }
      else
        format.html { render :new }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @phone_number.update(phone_number_params)
        format.html { redirect_to @phone_number.contact, notice: 'Phone number was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone_number }
      else
        format.html { render :edit }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    contact = @phone_number.contact
    @phone_number.destroy
    respond_to do |format|
      format.html { redirect_to contact, notice: 'Phone number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_number_params
      params.require(:phone_number).permit(:number, :contact_id, :contact_type)
    end
end
