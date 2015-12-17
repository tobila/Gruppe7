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
            
            System.IO.StreamReader sr = new System.IO.StreamReader("expression.txt");
            String s;

            ThreadPool.SetMaxThreads(3, 3);
            ThreadPool.SetMinThreads(3, 3);
            

            while ((s= sr.ReadLine()) != null)
            {
                EBNFParser parser = new EBNFParser(s);
                ThreadPool.QueueUserWorkItem(parser.expression);

                


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

        public EBNFParser(String s)
        {
            exp = new LinkedList<char>(s.ToCharArray());
            backUp = s;
        }

        public void expression(Object o)
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

       

        private void roundBracketLeft()
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


        private void constant()
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


        private void arithOperator()
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




        private void variable()
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




        private void roundBracketRight()
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



        private bool isRoundBracketLeft()
        {
            return exp.First.Value == '(';
        }

        private bool isRoundBracketRight()
        {
            return exp.First.Value == ')';
        }


        private bool isArithOperator()
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








        private bool isDigit()
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

        private bool isVariable()
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

        private bool isBracketsCountEquals()
        {
            return bracketLeftCount == bracketRightCount;
        }

    } 

}
