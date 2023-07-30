json.extract! @job, :id, :title, :field, :company, :location
json.applications @job.applications do |application|
  json.extract! application, :id, :content
end
