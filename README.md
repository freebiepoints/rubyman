This is a version of Hangman written in Ruby. The player get 6 attempts to guess all of the letters in a secret word. Each incorrect guess reduces the attempts by 1 and adds to the hangman.  

REQUIREMENTS  

!!Ruby must be installed!!  
--On Ubuntu/Debian--  
In your CLI:  
> sudo apt update  
> sudo apt install ruby-full  

--Other OS's--  
Refer to https://www.ruby-lang.org/en/documentation/installation/ for installation instructions  


LAUNCHING THE GAME  

In your CLI:  
Navigate to the directory rubyman.rb is located  
> ruby rubyman.rb


NOTES  

1. By default, Rubyman uses the word dictionary located in /usr/share/dict/words to generate its word list.  
You can check if this file exists with:  
> ls /usr/share/dict/words  

If it does not, you can install a dictionary with the following command:  
> sudo apt install wamerican  

2. You can load a custom dictionary by adding it as an argument, e.g.:  
> ruby rubyman.rb 'customdictionary.txt'  

3. There is a fallback word list if no other dictionary loads.  
