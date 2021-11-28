# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @currencies = Currency.all
  end
end
