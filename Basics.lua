function basics()
	
	-- Setting a variable
	x = 4
	print(x)
	
	x = x + 6
	print(x)
	
	-- This is an if statement. The backbone of computer logic
	if x > 5 then
		print("x was greater than 5")
	else
		print("x was not greater than five")
	end
	
	-- Naming convention
	camelCase = "How we name variables. "
	discriptiveNames = "Names have to be descriptive"
	print(camelCase..discriptiveNames)
	
	i = 1
	while (i <= 10) do
		print(i)
		i = i + 1
	end
	
	myList = {"Hi", "Hello", 4, 10}
	i = 1
	while (i <= #myList) do
		print(myList[i])
		i = i + 1
	end
	
end