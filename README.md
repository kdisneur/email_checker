# EmailChecker

[![Circle CI](https://circleci.com/gh/kdisneur/email_checker/tree/master.svg?style=svg)](https://circleci.com/gh/kdisneur/email_checker/tree/master)

Simple library checking the validity of an email. Checks are performed in the
following order:

* REGEX: validate the emails has a good looking format
* MX: validate the domain sever contains MX records
* SMTP: validate the SMTP behind the MX records knows this email address (no
email sent)

:warning: That's rare but, some SMTP define a catchall email address. Meaning
all emails using this domain seems valid even if they are not.

### Installation

```elixir
# mix.exs
def application do
  [mod: {YourModule, []},
   applications: [
     # other applications...
     :email_checker,
     # other applications...
     ]
  ]
end

def deps do
  [
    # other dependencies...
    {:email_checker, "~> 0.0.3"}
    # other dependencies...
  ]
end
```

### Configuration

```elixir
# config/config.exs -- default
config :email_checker,
  default_dns: :system,
  also_dns: [],
  validations: [Format,MX,SMTP],
  smtp_retries: 2,
  timeout_milliseconds: :infinity
```

In the test environment, we need to manually load DNS records to validate if an
MX exists or not. When we load the library Erlang doesn't have its DNS record
list yet. So to avoid any problem, we define a default DNS. By default the value
for the test environment is : `{8,8,8,8}`, which is Google's primary public
DNS server. If you find that you have odd failures in name resolution, you may
have to specify a default DNS server.

In the case you need to load more DNS servers manually after the default one, you
can set a list of more DNS server IPs in the `also_dns` setting.

Please note that the IP address is represented as a tuple separated by commas.

The default validations setting should be suitable for most cases. If you use
fake but valid-looking email addresses in your own tests, you may need to set
the validations to just `[Format]`, and MX and SMTP testing will then not be
used in that configuration.

The SMTP validation strategy will attempt 2 retries, by default.

The MX and SMTP validation strategies, each in their own way, use the same
default timeout for net connections as the underlying Erlang library calls. It
is important to note that this value is `:infinity`, and the call will take as
long as the call takes. You likely want to set to a sensible timeout in
milliseconds. Please note that:

 * For the MX validation, this is the timeout of the call to the DNS server for
   MX records.
 * For the SMTP validation, the timeout is divided by the number of retries.

```elixir
# config/config.exs -- example personalized configuration
config :email_checker,
  default_dns: {8, 8, 8, 8},
  smtp_retries: 1,
  timeout_milliseconds: 6000
```

### Usage

```elixir
EmailChecker.valid?("kevin@disneur.me")
#=> true
EmailChecker.valid?("non-existing@disneur.me")
#=> false
```

### CHANGELOG

[CHANGELOG](https://github.com/kdisneur/email_checker/blob/master/CHANGELOG)

### LICENSE

[MIT](https://github.com/kdisneur/email_checker/blob/master/LICENSE)
