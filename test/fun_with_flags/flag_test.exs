defmodule FunWithFlags.FlagTest do
  use ExUnit.Case, async: true
  # import FunWithFlags.TestUtils

  alias FunWithFlags.Flag

  describe "new(name, bool)" do
    test "it returns a new flag struct" do
      assert %Flag{name: :pear, boolean: true} = Flag.new("pear", true)
      assert %Flag{name: :pear, boolean: true} = Flag.new(:pear, true)

      assert %Flag{name: :pear, boolean: false} = Flag.new("pear", false)
      assert %Flag{name: :pear, boolean: false} = Flag.new(:pear, false)
    end
  end

  describe "enabled?(flag)" do
    setup do
      flag = Flag.new(:banana, true)
      {:ok, flag: flag}
    end

    test "it returns true if the flag has a boolean value = true", %{flag: flag} do
      assert Flag.enabled?(flag)
    end

    test "it returns false if the flag has a boolean value = false", %{flag: flag} do
      flag = %Flag{flag | boolean: false}
      refute Flag.enabled?(flag)
    end
  end

  describe "to_redis(flag) returns data ready to be flushed into redis" do
    test "when the flag has just a boolean value" do
      flag = Flag.new(:ananas, true)
      assert {:ananas, ["boolean", true]}

      flag = Flag.new(:ananas, false)
      assert {:ananas, ["boolean", false]}
    end
  end
end