using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;
using System.Threading;


namespace EBNFParser
{
    class Program
    {
       

        static void Main(string[] args)
        {
            System.IO.StreamReader sr = null
                ;
            try
            {
                sr = new System.IO.StreamReader("expression.txt");
            
            
                String s;

                ThreadPool.SetMaxThreads(3, 3);
                ThreadPool.SetMinThreads(3, 3);
            

                while ((s= sr.ReadLine()) != null)
                {
                    EBNFParser parser = new EBNFParser(s);
                    ThreadPool.QueueUserWorkItem(parser.expression);

                


                }

            }
            catch (Exception e )
            {
                Console.WriteLine("File not found!");
            }
            //   WaitHandle.WaitAll(100,1);




            Console.ReadLine();
        }
    }




    public class EBNFParser 
    {
        private LinkedList<char> exp;
        private int bracketLeftCount = 0;
        private int bracketRightCount = 0;
        private String backUp;

        public EBNFParser(String s) // Construktor with new linkedList
        {
            exp = new LinkedList<char>(s.ToCharArray());
            backUp = s;
        }

        public void expression(Object o)  //check Element for RoundbracketLeft, constant, Digit or Variable else Exception
        {
            try
            {
                
                if (isRoundBracketLeft())
                {

                    roundBracketLeft();
                }
                else if (isDigit())
                {
                    constant();
                }
                else if (isVariable())
                {
                    variable();
                }

                else {
                    throw (new Exception());
                }
                if (!isBracketsCountEquals())
                {
                    throw (new Exception());
                }
                else
                {
                    Console.WriteLine( "{0}: parsing complete",backUp);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("{0}: no parsing possible", backUp);
               
            }
        }

       

        private void roundBracketLeft() // check next Element after an roundbracket left if RroundbracketLeft, Digitor Variable and remove it else Exception
        {
            if (exp.Count() != 0)
            {
                if (isRoundBracketLeft())
                {
                    bracketLeftCount++;
                    exp.RemoveFirst();
                    roundBracketLeft();
                }
                else if (isDigit())
                {
                     constant();
                }
                else if (isVariable())
                {
                    variable();
                }
                else {
                    throw (new Exception());
                }

            }
        }


        private void constant() // check next element if Valide digit and remove it or roundBracketRight or ArithOperator else Exception  
        {
           
            if (exp.Count() != 0)
            {
                if (isDigit())
                {
                    exp.RemoveFirst();
                    constant();
                }

                else if (isRoundBracketRight())
                {
                    roundBracketRight();
                }
                else if (isArithOperator())
                {
                    arithOperator();
                }


                else {
                    throw (new Exception());
                }
            }
        }


        private void arithOperator() // Check next Element for an reoundBracketLeft and remove it  else Exception
        {

            if (exp.Count() != 0)
            {
                if (isArithOperator())
                {
                    exp.RemoveFirst();
                    roundBracketLeft();
                }


                else
                {
                    throw (new Exception());
                }
            }
        }




        private void variable() // Check next Element for an Variable or artihOperator and remove it or roundBracketRight else exception
        {
            if (exp.Count() != 0)
            {
                if (isVariable())
                {
                    exp.RemoveFirst();
                    arithOperator();
                }


                else if (isRoundBracketRight())
                {
                    roundBracketRight();
                }


                else
                {
                    throw (new Exception());
                }
            }
        }




        private void roundBracketRight() // check next element for an roundBracketRight and remove it or artihOperator  else Exception
        {
            if (exp.Count() != 0)
            {
                if (isRoundBracketRight())
                {
                    bracketRightCount++;
                    exp.RemoveFirst();
                    roundBracketRight();
                }


                else if (isArithOperator())
                {
                    arithOperator();
                }


                else {
                    throw (new Exception());
                }
            }
        }



        private bool isRoundBracketLeft() //check if the first Element of the List is an roundBracketLeft
        {
            return exp.First.Value == '(';
        }

        private bool isRoundBracketRight()// check if the first Element of the List is an roundBracketRight
        {
            return exp.First.Value == ')';
        }


        private bool isArithOperator() // check the value of artihmetik Operator
        {
            if (exp.Count() != 0)
            {
                switch (exp.First.Value)
                {
                    case '+':
                    case '-':
                    case '/':
                    case '*':
                        return true;
                    default:
                        return false;
                }
            }
            else
            {
                return true;
            }

        }








        private bool isDigit() // Check value of Digit from 0 to 9
        {
            if (exp.Count() != 0)
            {
                switch (exp.First.Value)
                {
                    case '0':
                    case '1':
                    case '2':
                    case '3':
                    case '4':
                    case '5':
                    case '6':
                    case '7':
                    case '8':
                    case '9':
                        return true;
                    default:
                        return false;
                }
            }
            else
            {
                return true;
            }
        }

        private bool isVariable() //Check valid of Variable x,y,z
        {
            if (exp.Count() != 0)
            {
                switch (exp.First.Value)
                {
                    case 'x':
                    case 'y':
                    case 'z':
                        return true;
                    default:
                        return false;
                }
            }
            else
            {
                return true;
            }
        }

        private bool isBracketsCountEquals() // check if bracketLeftCoundt has the same count as backetRightCount
        {
            return bracketLeftCount == bracketRightCount;
        }

    } 

}
