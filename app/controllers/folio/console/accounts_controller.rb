require_dependency 'folio/application_controller'

module Folio
  class Console::AccountsController < Console::BaseController
    before_action :find_account, except: [ :index, :create, :new ]

    def index
      params[:by_is_active] = true if params[:by_is_active].nil?
      @accounts = Account.
                      order(:created_at).
                      filter(filter_params).
                      page(current_page)
      respond_with @accounts
    end

    def new
      @account = Account.new
    end

    def create
      @account = Account.create(account_params)
      respond_with @account, location: console_accounts_path
    end

    def update
      @account.update(account_params)
      respond_with @account, location: console_accounts_path
    end

    def destroy
      @account.destroy
      respond_with @account, location: console_accounts_path
    end

    private

      def find_account
        @account = Account.find(params[:id])
      end

      def filter_params
        params.permit(:by_is_active, :by_query)
      end

      def account_params
        p = params.require(:account).permit(:role, :email, :first_name, :last_name, :password, :is_active)
        p.delete(:password) unless p[:password].present?
        p
      end
  end
end