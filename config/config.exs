import Config

case config_env() do
  :dev ->
    config :mix_test_interactive, clear: true

  :test ->
    config :bypass, enable_debug_log: true

  _ ->
    nil
end