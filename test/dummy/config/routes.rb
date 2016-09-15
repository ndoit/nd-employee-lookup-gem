Rails.application.routes.draw do

  mount LdcQuery::Engine => "/ldc_query"
end
