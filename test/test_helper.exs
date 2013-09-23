Dynamo.under_test(DynamoFirebase.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule DynamoFirebase.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
