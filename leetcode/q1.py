import pandas as pd 
import json 
from datetime import datetime


#declaring the test cases that we are going to test 
test_case = {
                'test_case_1' : {
                                    'question' : [1,23,10,34],
                                    'solution' : 23
                                },
                'test_case_2' : {
                                    'question' : [1,-1,30,14],
                                    'solution' : 14
                                }
            }


def find_second_max(array: List[int]) -> int:
    
    #checking for valid length
    if len(array) <= 1 : 
        return -1 
    else : 
        try : 
            array.sort() # here we are expecting that it will sort in the ascending order
            return array[-2]
        except Exception as e :
            print(f"the following error has occured {e}"


if '__init__'=='main':
    #here we write the code of problem solution 
    for case in test_case :
                  #here comes the condition to solve the quesiton and the we do furthur stuff 
    def 
    return "your programm has worked correctly"

