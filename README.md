# NdEmployeeLookup

Your app is expected by this plugin to handle some things:

1) authentication, the NdEmployeeLookup::ApplicationController inherits from
::ApplicationController, so if your app uses rack-cas and has code like below
in `app/controllers/application_controller.rb` the main ApplicationController:

```
class ApplicationController < ActionController::Base
  before_action :authenticate
  def authenticate
    render status: 401, text: "" unless request.session.key?("cas")
  end
end
```

then the NdEmployeeLookup::ApplicationController will be protected as well.

2) a mount point, for example in `config/routes.rb`:

```
Rails.application.routes.draw do
  mount NdEmployeeLookup::Engine, at: "/employee-lookup"
end
```

If you add this route then you can access the view for `employee_lookup#new` at
/employee-lookup/search, and you can read JSON results by sending get requests
into the `employee_lookup#search` method directly via /employee-lookup/employee

3) styling and javascript assets from foundation

It's expected that your app implements nd_foundation, so you probably have a
`layout 'nd'` in the ApplicationController, or you've followed the instructions
at https://github.com/ndwebgroup/nd_foundation and also advisable to make sure
your `app/assets/javascripts/application.js` has the directives for jquery and
friends, and that you invoke javascript `foundation()` on your document:

```
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require foundation
//= require_tree .
$(document).foundation();
```

4) let plugin assets inform your application's layout page

Put this line in your `<head>` tag (probably in `app/views/layouts/nd.html.erb`
so the page-specific javascripts that aren't part of can be included before the rest of the page
tries to use them on document load.

```
<%= yield(:header) if content_for? :header %>
```

I think that's all you need... good luck!

--Kingdon
