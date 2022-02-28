class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]

  def index
    @q = Company.ransack(params[:q])
    @companies = @q.result(distinct: true).includes(:job_applications,
                                                    :interviewed_applicants, :interviews).page(params[:page]).per(10)
  end

  def show
    @job_application = JobApplication.new
  end

  def new
    @company = Company.new
  end

  def edit; end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to @company, notice: "Company was successfully created."
    else
      render :new
    end
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: "Company was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_url, notice: "Company was successfully destroyed."
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :sector)
  end
end
