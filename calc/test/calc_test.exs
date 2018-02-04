defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "Test1" do
    assert Calc.eval("2+3") == "5"
  end
  test "Test2" do
    assert Calc.eval("2-3") == "-1"
  end
  test "Test3" do
    assert Calc.eval("2*3") == "6"
  end
  test "Test4" do
    assert Calc.eval("6/3") == "2"
  end
  test "Test5" do
    assert Calc.eval("24/6+(5-4)") == "5"
  end
  test "Test6" do
    assert Calc.eval("1+3*3+1") == "11"
  end
  test "Test7" do
    assert Calc.eval("10+8-10") == "8"
  end
  test "Test8" do
    assert Calc.eval("2*2/2+2-1") == "3"
  end
  test "Test9" do
    assert Calc.eval("(2+(3*2)/2)") == "5"
  end
end
