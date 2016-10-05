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

2) styling and javascript assets from foundation

Though not mandatory, it is strongly recommended that your app implements the
`nd_foundation` layout, so you probably already have a `layout 'nd'` statement
in your ApplicationController.  If not, you should follow the instructions at
https://github.com/ndwebgroup/nd_foundation -- `foundation-rails` itself is
required by the views, so make sure `app/assets/javascripts/application.js`
requires `nd_employee_lookup`, and that you invoke javascript `foundation()`.
This will also (automatically) require `jquery-rails` and load those assets.

In `app/assets/javascripts/application.js`, for example:
```
//= require nd_employee_lookup
//= require_tree .
$(document).foundation();
```

and in `app/assets/stylesheets/application.css`:
```
/*
 *= require nd_employee_lookup
 *= require nd_foundation
 *= require foundation_overrides
 *= require_self
 *= require_tree .
 */
```

By doing this, the engine will require needed foundation-rails and jquery-rails
gems and assets that are included as dependencies of the gem.  Without them the
layout and AJAX-enabled views would certainly not work.

I think that's all you need... good luck!

--Kingdon
