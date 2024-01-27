defmodule GptAgent.Types do
  @moduledoc """
  Defines the generic types used throughout the library and provides common validation for those types.

  You can `use GptAgent.Types` in other modules to import the validation
  functions and automatically set up both `TypedStruct` and `Domo` for your
  module.
  """

  import Domo, only: [precond: 1]

  @type nonblank_string() :: String.t()
  precond nonblank_string: &validate_nonblank_string/1

  @type assistant_id() :: nonblank_string()
  @type message_id() :: nonblank_string()
  @type run_id() :: nonblank_string()
  @type thread_id() :: nonblank_string()

  @type success() :: :ok
  @type success(t) :: {:ok, t}
  @type error(t) :: {:error, t}
  @type result(error_type) :: success() | error(error_type)
  @type result(success_type, error_type) :: success(success_type) | error(error_type)

  @doc """
  Validation for the `nonblank_string()` type
  """
  @spec validate_nonblank_string(String.t()) :: result(String.t())
  def validate_nonblank_string(value) when is_binary(value) do
    case String.trim(value) do
      "" -> {:error, "must not be blank"}
      _ -> :ok
    end
  end

  defmacro __using__(opts) do
    quote do
      use TypedStruct
      use Domo, unquote(opts)

      import GptAgent.Types
    end
  end
end
