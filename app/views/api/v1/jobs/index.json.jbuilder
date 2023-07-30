json.array! @jobs do |job|
  json.extract! job, :id, :title, :field, :company, :location
end
