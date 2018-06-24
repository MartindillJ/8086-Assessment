# 8086-Assessment
INSTRUCTIONS
Write an 8086 assembly program to test if two strings form an anagram of each
other.
Your program should use the following algorithm:
1. read in two strings
2. in each string convert upper case characters to lower case
3. in each string remove all non-alphabetic characters
4. in each string count the number of occurrences of each alphabetic
character (i.e. compute the frequency of the 26 alphabetic
letters)
5. compare the set of frequencies for each string to test if the strings
are anagrams. 

SAMPLE OUTPUTS
enter string: Elvis
just read string: Elvis
enter string: lives!!(?)
just read string: lives!!(?)
converted to lower case: elvis
converted to lower case: lives!!(?)
removed non-alphabetic characters: elvis
removed non-alphabetic characters: lives
character counts: 00001000100100000010010000
character counts: 00001000100100000010010000
strings ARE anagrams

enter string: Eleven plus two
just read string: Eleven plus two
enter string: = twelve (12) PLUS (+) one (1).
just read string: = twelve (12) PLUS (+) one (1).
converted to lower case: eleven plus two
converted to lower case: twelve (12) plus (+) one (1).
removed non-alphabetic characters: elevenplustwo
removed non-alphabetic characters: twelveplusone
character counts: 00003000000201110011111000
character counts: 00003000000201110011111000
strings ARE anagrams

enter string: Eleven plus two
just read string: Eleven plus two
enter string: = Thirteen.
just read string: = Thirteen.
converted to lower case: eleven plus two
converted to lower case: = thirteen.
removed non-alphabetic characters: elevenplustwo
removed non-alphabetic characters: thirteen
character counts: 00003000000201110011111000
character counts: 00002001100001000102000000
strings are NOT anagrams

enter string: ’That’s one small step for a man; one giant leap for mankind.’ Neil Armstrong
just read string: ’That’s one small step for a man; one giant leap for mankind.’ Neil Armstrong
enter string: [A] thin man ran... makes a large stride... left planet... pins flag on moon... on to Mars!
just read string: [A] thin man ran... makes a large stride... left planet... pins flag on moon... on to Mars!
converted to lower case: ’that’s one small step for a man; one giant leap for mankind.’ neil armstrong
converted to lower case: [a] thin man ran... makes a large stride... left planet... pins flag on moon... on to mars!
removed non-alphabetic characters: thatsonesmallstepforamanonegiantleapformankindneilarmstrong
removed non-alphabetic characters: athinmanranmakesalargestrideleftplanetpinsflagonmoonontomars
character counts: 80015221301448520445000000
character counts: 90015221301448520445000000
strings are NOT anagrams
