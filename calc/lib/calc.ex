defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """
  @doc """
  """

  #Input   : A string aestr of the form "a/b"
  #Returns : A string "c" which is the result of dividing "a" by "b"
  #Effect  : First "a" and "b" to Integer, division is performed and
  #         the result is returned as String
  def divide(aestr) do
    lst = Regex.replace(~r/\//, aestr, " ") |> String.split(" ")
    num1 = hd (lst)
    num2 = hd (tl (lst))
    {n1, _} = Integer.parse(num1)
    {n2, _} = Integer.parse(num2)
    result = Integer.floor_div(n1,n2)
    Integer.to_string(result)
  end

  #Input   : A string aestr of the form "a*b"
  #Returns : A string "c" which is the result of multiplying "a" and "b"
  #Effect  : First "a" and "b" to Integer, multiplication is performed and
  #         the result is returned as String
  def multiply(aestr) do
    lst = Regex.replace(~r/\*/, aestr, " ") |> String.split(" ")
    num1 = hd (lst)
    num2 = hd (tl (lst))
    {n1, _} = Integer.parse(num1)
    {n2, _} = Integer.parse(num2)
    result = n1 * n2
    Integer.to_string(result)
  end

  #Input   : A string aestr of the form "a+b"
  #Returns : A string "c" which is the result of adding "a" and "b"
  #Effect  : First "a" and "b" to Integer, addition is performed and
  #         the result is returned as String
  def add(aestr) do
    lst = Regex.replace(~r/\+/, aestr, " ") |> String.split(" ")
    num1 = hd (lst)
    num2 = hd (tl (lst))
    {n1, _} = Integer.parse(num1)
    {n2, _} = Integer.parse(num2)
    result = n1 + n2
    Integer.to_string(result)
  end

  #Input   : A string aestr of the form "a-b"
  #Returns : A string "c" which is the result of subtracting "a" and "b"
  #Effect  : First "a" and "b" to Integer, subtraction is performed and
  #         the result is returned as String
  def subtract(aestr) do
    lst = Regex.replace(~r/\-/, aestr, " ") |> String.split(" ")
    num1 = hd (lst)
    num2 = hd (tl (lst))
    {n1, _} = Integer.parse(num1)
    {n2, _} = Integer.parse(num2)
    result = n1 - n2
    Integer.to_string(result)
  end

  #Input   : A string aexp which contains braces is to be evaluated
  #Returns : Result of expression without the braces
  def resolveBraces(aexp) do
    ae = aexp
    if (Regex.run(~r/\(\d+\/\d+\)/, ae) != nil) do      
      result = Regex.run(~r/\d+\/\d+/, ae) |> hd |> divide()
      ae = Regex.replace(~r/\(\d+\/\d+\)/, ae, result, global: false) 
    end
    if (Regex.run(~r/\d+\/\d+/, ae) != nil) do
      result = Regex.run(~r/\d+\/\d+/, ae) |> hd |> divide()
      ae = Regex.replace(~r/\d+\/\d+/, ae, result, global: false)
    end
    if (Regex.run(~r/\(\d+\*\d+\)/, ae) != nil) do      
      result = Regex.run(~r/\d+\*\d+/, ae) |> hd |> multiply()
      ae = Regex.replace(~r/\(\d+\*\d+\)/, ae, result) 
    end

    if (Regex.run(~r/\d+\*\d+/, ae) != nil) do      
      result = Regex.run(~r/\d+\*\d+/, ae) |> hd |> multiply()
      ae = Regex.replace(~r/\d+\*\d+/, ae, result) 
    end

    if (Regex.run(~r/\(\d+\-\d+\)/, ae) != nil) do      
      result = Regex.run(~r/\d+\-\d+/, ae) |> hd |> subtract()
      ae = Regex.replace(~r/\(\d+\-\d+\)/, ae, result, global: false) 
    end

    if (Regex.run(~r/\d+\-\d+/, ae) != nil) do      
      result = Regex.run(~r/\d+\-\d+/, ae) |> hd |> subtract()
      ae = Regex.replace(~r/\d+\-\d+/, ae, result, global: false) 
    end

    if (Regex.run(~r/\(\d+\+\d+\)/, ae) != nil) do      
      result = Regex.run(~r/\d+\+\d+/, ae) |> hd |> add()
      ae = Regex.replace(~r/\(\d+\+\d+\)/, ae, result) 
    end

    if (Regex.run(~r/\d+\+\d+/, ae) != nil) do      
      result = Regex.run(~r/\d+\+\d+/, ae) |> hd |> add()
      ae = Regex.replace(~r/\d+\+\d+/, ae, result) 
    end

    if (Regex.run(~r/\(\d+\+\-\d+\)/, ae) != nil) do
      ae = Regex.replace(~r/\+\-/, ae, "-")
      result = Regex.run(~r/\d+\-\d+/, ae) |> hd |> subtract()
      ae = Regex.replace(~r/\(\d+\-\d+\)/, ae, result, global: false) 
    end

    ae
  end

  #Input   : A string aexp which is to be evaluated
  #Returns : Result of expression
  def checkOperator(aexp) do
    ae = aexp
    if(Regex.run(~r/(\(((?:(?>[^()])|(?1))*)\))/, ae) != nil) do
      ae = resolveBraces(ae)
    end 

    if(Regex.run(~r/(\(((?:(?>[^()])|(?1))*)\))/, ae) != nil) do
      ae = checkOperator(ae)
    end 
   
    if (Regex.run(~r/\d+\/\d+/, ae) != nil) do      
      result = Regex.run(~r/\d+\/\d+/, ae) |> hd |> divide()
      ae = Regex.replace(~r/\d+\/\d+/, ae, result, global: false) 
    end

    if (Regex.run(~r/\d+\/\d+/, ae) != nil) do
      ae = checkOperator(ae)
    end

    if (Regex.run(~r/\d+\*\d+/, ae) != nil) do      
      result = Regex.run(~r/\d+\*\d+/, ae) |> hd |> multiply()
      ae = Regex.replace(~r/\d+\*\d+/, ae, result) 
    end

    if (Regex.run(~r/\d+\*\d+/, ae) != nil) do
      ae = checkOperator(ae)
    end

    if (Regex.run(~r/\d+\-\d+/, ae) != nil) do      
      result = Regex.run(~r/\d+\-\d+/, ae) |> hd |> subtract()
      ae = Regex.replace(~r/\d+\-\d+/, ae, result, global: false) 
    end

    if (Regex.run(~r/\d+\-\d+/, ae) != nil) do
      ae = checkOperator(ae)
    end  

    if (Regex.run(~r/\d+\+\d+/, ae) != nil) do      
      result = Regex.run(~r/\d+\+\d+/, ae) |> hd |> add()
      ae = Regex.replace(~r/\d+\+\d+/, ae, result) 
    end

    if (Regex.run(~r/\d+\+\d+/, ae) != nil) do
      ae = checkOperator(ae)
    end
    
    if (Regex.run(~r/\d+\+\-\d+/, ae) != nil) do
      ae = Regex.replace(~r/\+\-/, ae, "-")
      result = Regex.run(~r/\d+\-\d+/, ae) |> hd |> subtract()
      ae = Regex.replace(~r/\d+\-\d+/, ae, result, global: false) 
    end

    ae
  end

  #Input   : A string aexp which is to be evaluated
  #Returns : Result of expression
  def eval(aexp) do
    if(Regex.run(~r/\\d+/, aexp) == nil) do
      checkOperator(aexp)
    end
  end

  #Input   : A string which is an arithmetic expression that is to be
  #          evaluated
  #Returns : A string which is the result of evaluating the input 
  #          arithmetic expression
  def main do
    ae = IO.gets(">")
    |> String.trim
    Regex.replace(~r/\s/, ae, "")
    |> eval()
    |> IO.puts
    main()
  end

end