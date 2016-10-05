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

The included AJAX-enabled views will almost certainly not work without taking
care of this.

4) make arrangements to load any assets in your &lt;head&gt;

The engine precompiles some CSS and Javascript assets, but as it cannot be
responsible for your app's layout, it won't be able to go back and add things
to the `head` tag of a page after it's already been rendered.  So, this line
inside of the `head` tag in `layouts/nd.html.erb` will let the engine provide
them:

```
<%= yield(:header) if content_for? :header %>
```

It will not be necessary to include any javascript or link stylesheets from
within the gem by hand.

I think that's all you need... good luck!

--Kingdon
