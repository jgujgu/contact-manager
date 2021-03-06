require 'rails_helper'

RSpec.describe PhoneNumbersController, type: :controller do
  let(:valid_attributes) { {number: "MyString", contact_id: alice.id, contact_type: 'Person'} }
  let!(:valid_person) { Person.create(first_name: 'jeff', last_name: 'gu') }
  let(:alice) { Person.create(first_name: 'Alice', last_name: 'Smith') }
  let(:bob) { Person.create(first_name: 'Bob', last_name: 'Gu') }
  let(:new_attributes) { {number: 'MyNewString', contact_id: valid_person.id} }
  let(:invalid_attributes) { {number: nil, contact_id: nil, contact_type: 'Person'} }
  let(:valid_session) { {} }

  describe "GET #new" do
    it "assigns a new phone_number as @phone_number" do
      get :new, {}, valid_session
      expect(assigns(:phone_number)).to be_a_new(PhoneNumber)
    end
  end

  describe "GET #edit" do
    it "assigns the requested phone_number as @phone_number" do
      phone_number = PhoneNumber.create! valid_attributes
      get :edit, {:id => phone_number.to_param}, valid_session
      expect(assigns(:phone_number)).to eq(phone_number)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PhoneNumber" do
        expect {
          post :create, {:phone_number => valid_attributes}, valid_session
        }.to change(PhoneNumber, :count).by(1)
      end

      it "assigns a newly created phone_number as @phone_number" do
        post :create, {:phone_number => valid_attributes}, valid_session
        expect(assigns(:phone_number)).to be_a(PhoneNumber)
        expect(assigns(:phone_number)).to be_persisted
      end

      it "redirects to the created phone_number" do
        valid_attributes = {number: '555-8888', contact_id: alice.id, contact_type: 'Person'}
        post :create, {:phone_number => valid_attributes}, valid_session
        expect(response).to redirect_to(person_path(alice))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved phone_number as @phone_number" do
        post :create, {:phone_number => invalid_attributes}, valid_session
        expect(assigns(:phone_number)).to be_a_new(PhoneNumber)
      end

      it "re-renders the 'new' template" do
        post :create, {:phone_number => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {number: '999'} }

      it "updates the requested phone number" do
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => new_attributes}, valid_session
        phone_number.reload
        expect(phone_number.number).to eq('999')
      end

      it "assigns the requested phone number as @phone number" do
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => valid_attributes}, valid_session
        expect(assigns(:phone_number)).to eq(phone_number)
      end

      it "redirects to the phone number" do
        valid_attributes = {number: '555-8888', contact_id: bob.id, contact_type: 'Person'}
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => valid_attributes}, valid_session
        expect(response).to redirect_to(bob)
      end
    end

    context "with invalid params" do
      it "assigns the phone_number as @phone_number" do
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => invalid_attributes}, valid_session
        expect(assigns(:phone_number)).to eq(phone_number)
      end

      it "re-renders the 'edit' template" do
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested phone number" do
      phone_number = PhoneNumber.create! valid_attributes
      expect {
        delete :destroy, {:id => phone_number.to_param}, valid_session
      }.to change(PhoneNumber, :count).by(-1)
    end

    it "redirects to the phone numbers list" do
      phone_number = PhoneNumber.create! valid_attributes
      person = phone_number.contact
      delete :destroy, {:id => phone_number.to_param}, valid_session
      expect(response).to redirect_to(person)
    end
  end

end
