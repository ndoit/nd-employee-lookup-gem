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
then the `NdEmployeeLookup::ApplicationController` will be protected as well.

2) styling and javascript assets from foundation

Though not mandatory, it is strongly recommended that your app implements the
`nd_foundation` layout, so you probably already have a `layout 'nd'` statement
in your ApplicationController.  If not, you should follow the instructions at
https://github.com/ndwebgroup/nd_foundation -- `foundation-rails` itself is
required by the views, so make sure `app/assets/javascripts/application.js`
requires `nd_employee_lookup`, and that you invoke javascript `foundation()`.
This will also (automatically) require `jquery-rails` and load those assets.

(FIXME: This step will probably eventually be shortened by a generator.)

In `app/assets/javascripts/application.js`, for example:
```
//= require nd_employee_lookup
//= require_tree .
$(function(){
  $(document).foundation();
    });
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
The engine requires `foundation-rails` and `jquery-rails`, and provides these
assets as needed (but you must require the `nd_employee_lookup` engine's
assets to make this happen, as above.)  These are for basic layout and
AJAX-enabled views which will not work otherwise.

You may also want to `rake assets:precompile`.

- - -

For automated testing:

Run `rake` before pushing to master.  The default rake task runs RSpec.

To bundle install the native extensions required by the rspec rake task:

https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit#centos-67
```
sudo yum install epel-release
sudo yum install qt5-qtwebkit-devel
QMAKE=/usr/lib64/qt5/bin/qmake bundle install
```
The custom capybara-webkit from github.com/kingdonb exists to work around a
deprecation warning that is probably completely harmless, but annoying.  It
will probably go away soon when the pull request is merged upstream.

If using another operating system or distribution, there are more instructions
to get the qt-webkit dependencies for building capybara-webkit on that page.

For regular testing:

If you don't have patience for this, or if you just want to run the sample app
and you don't care about the RSpec tests, or if `bundle install` doesn't work,
you may remove the `capybara-webkit` dependency from the gemspec.  This will
mean that you will not be able to execute the rspec or pre-commit hooks, but
you can still start the dummy app:
```
cd spec/dummy
rails s
```

Lookups will not actually work without an API server.  The API server may be
using a self-signed certificate, or your ruby may not come pre-installed with
an SSL web-of-trust.  (Mine didn't.)  Set the variables in `.env.local`:
```
HRPY_API_KEY: 1234567ab0987654cd9282932ef27382
HRPY_API_BASE=https://hrpy-api-internal-dev.oit.nd.edu
SSL_CERT_FILE=./cacert.pem
```
(this is an example API KEY, you will have to request a real one).

When requesting an API key, please contact Brandon Rich <brich@nd.edu> and ask
for the [Something] permission set.  (FIXME: don't know exactly what specific
permissions the requestor's API key will need.)

I think that's all you need... good luck!

--Kingdon

TMEYER2 Addition 4/25/2018

Added a quick lookup for employees in the employee_lookup_controller.rb.
Added javascript to generate an employee autocomplete text field.
Added javascript to get employee information from an id.
```
Add the class active_employee_net_id_input to your input field
Call set_active_employee_net_id_autocomplete in document ready
Select and change will call a function named
select_active_employee_net_id_input (net_id_field, net_id)  if it is available
```
An example of using this functionality is available in spec/dummy/views/employees/select_example.html.erb.
