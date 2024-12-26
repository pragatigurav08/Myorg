public class Palindrome {
 public static Boolean ispalindrome(string str)
 {
     if(str == str.reverse())
     {
         return true;
     }
    return false;
 }
    public void check()
    {
        list<string> result=new list<string>();
        list<string> lst= new list<string>{'civic','radar','shishira','level','rotor'};
     for(integer i =0;i< lst.size();i++)
        {
         if(Palindrome.ispalindrome(lst[i]))
         {
             result.add(lst[i]);
         }
    }
        system.debug(result);
    }
    
}