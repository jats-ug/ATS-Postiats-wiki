Characters are demarcated with single quotes, i.e. the character c is
written 'c'. Some characters may need an escape character (the back-slash)
because the sequence *'char* for the char being discussed has a special
meaning in ATS. One such example is '(, so we actually write '\\(' to denote
the left parentheses. We note here that strings, in contrast, are demarcated
with double quotes.

Escape sequences for characters
-------------------------------
The following list is believed to be exhaustive:

* C conventions are used for some characters, e.g.:
    * newline is written as '\\n'
    * carriage return is written as '\\r'
    * to input a single backlash, use two backslashes, '\\\\'
    * to input a single colon, use '\\''
* additionally, some characters may "clash" with ATS conventions, so they are escaped too:
    * '\\(' for left parenthesis (clashes with boxed tuple type)
    * '\\{' for left brace (clashes with boxed record type)
    * '\\[' for left bracket (clashes with singly-linked list literal)
* also, it is possible to specify a character in octal notation: '\\000' (backlash, then one to three octal digits 0-7), or in hexadecimal notation, with '\\0x00' (backlash, then leading zero, then 'x' or 'X', then one or more hexadecimal digit, which is either 0-9 or a-z or A-Z)

(How do we specify ASCII codes in Hex, Bin, Dec, Oct, etc?)

*char* and Unicode
------------------
Please note that 'char' maps directly to C type 'char', therefore it is the
size of 1 byte, and cannot be used to represent any multi-byte encoding,
such as UTF-16 or UTF-32.

Conversion functions for *char*
-----------------------------
(Also see our [[Rosetta Stone|Rosetta Stone]] (This section, and the Rosetta
Stone, need ATS2 versions))

**char to string**

```ocaml
(*
   HX: the return is dynamically allocated
*)
fun tostring_char
  (c: char):<> strnptr(1) = "mac#%"
overload tostring with tostring_char
```
