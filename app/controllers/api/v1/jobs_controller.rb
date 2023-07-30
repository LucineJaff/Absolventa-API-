class Api::V1::JobsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [:index, :show]
  before_action :set_job, only: [:show, :update, :destroy]

  def index
    @jobs = policy_scope(Job)
  end

  def show
  end

  def update
    if @job.update(job_params)
      render :show
    else
      render_error
    end
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    authorize @job
    if @job.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @job.destroy
    head :no_content
  end

  private

  def set_job
    @job = Job.find(params[:id])
    authorize @job
  end

  def job_params
    params.require(:job).permit(:title, :field, :location, :company)
  end

  def render_error
    render json: { errors: @job.errors.full_messages },
      status: :unprocessable_entity
  end
end
