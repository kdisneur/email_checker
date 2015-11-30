use Mix.Config

# We need to configure the DNS servers in the test environment, because the
# test system loads and runs so quickly, that the DNs subsystem hasn't quite come
# up yet.

config :email_checker,
  default_dns: {8,8,8,8},
  also_dns: [{8,8,4,4}],
  validatons: [Format,MX,SMTP],
  smtp_retries: 2,
  timeout_milliseconds: :infinity
