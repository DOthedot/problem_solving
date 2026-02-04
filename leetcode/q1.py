def find_second_max(array: List[int]) -> int:
    
    #checking for valid length
    if len(array) <= 1 : 
        return -1 
    else : 
        try : 
            array.sort() # here we are expecting that it will sort in the ascending order
            return array[-2]
        except Exception as e :
            print(f"the following error has occured {e}")


if '__init__'=='main':
    #here we write the code of problem solution 

    return "your programm has worked correctly"

