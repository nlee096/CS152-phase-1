   /* cs152-miniL phase1 */
   
%{   
	int currline = 1;
	int currpos = 1;
%}

   /* some common rules */
DIGIT		[0-9]
ALPHA		[A-Za-z]
ALPHANUM	{ALPHA}|{DIGIT}
VALIDID		{ALPHA}({ALPHANUM}|_+{ALPHANUM})* 
INVALIDSTART	[0-9_][A-Za-z0-9_]*
INVALIDEND	[A-Za-z][A-Za-z0-9_]*_

%%
   /* specific lexer rules in regex */
"function"	{printf("FUNCTION\n"); currpos += yyleng;}
"beginparams"	{printf("BEGIN_PARAMS\n"); currpos += yyleng;}
"endparams"	{printf("END_PARAMS\n"); currpos += yyleng;}
"beginlocals"	{printf("BEGIN_LOCALS\n"); currpos += yyleng;}
"endlocals"	{printf("END_LOCALS\n"); currpos += yyleng;}
"beginbody"	{printf("BEGIN_BODY\n"); currpos += yyleng;}
"endbody"	{printf("END_BODY\n"); currpos += yyleng;}
"integer"	{printf("INTEGER\n"); currpos += yyleng;}
"array"		{printf("ARRAY\n"); currpos += yyleng;}
"of"		{printf("OF\n"); currpos += yyleng;}
"if"		{printf("IF\n"); currpos += yyleng;}
"then"		{printf("THEN\n"); currpos += yyleng;}
"endif"		{printf("ENDIF\n"); currpos += yyleng;}
"else"		{printf("ELSE\n"); currpos += yyleng;}
"while"		{printf("WHILE\n"); currpos += yyleng;}
"do"		{printf("DO\n"); currpos += yyleng;}
"for"		{printf("FOR\n"); currpos += yyleng;}
"beginloop"	{printf("BEGINLOOP\n"); currpos += yyleng;}
"endloop"	{printf("ENDLOOP\n"); currpos += yyleng;}
"continue"	{printf("CONTINUE\n"); currpos += yyleng;}
"break"		{printf("BREAK\n"); currpos += yyleng;}
"read"		{printf("READ\n"); currpos += yyleng;}
"write"		{printf("WRITE\n"); currpos += yyleng;}
"not"		{printf("NOT\n"); currpos += yyleng;}
"and"		{printf("AND\n"); currpos += yyleng;}
"or"		{printf("OR\n"); currpos += yyleng;}
"true"		{printf("TRUE\n"); currpos += yyleng;}
"false"		{printf("FALSE\n"); currpos += yyleng;}
"return"	{printf("RETURN\n"); currpos += yyleng;}

"-"		{printf("SUB\n"); currpos += yyleng;}
"+"     	{printf("ADD\n"); currpos += yyleng;}
"*"     	{printf("MULT\n"); currpos += yyleng;}
"/"     	{printf("DIV\n"); currpos += yyleng;}
"%"     	{printf("MOD\n"); currpos += yyleng;}

"=="		{printf("EQ\n"); currpos += yyleng;}
"<>"		{printf("NEQ\n"); currpos += yyleng;}
"<"		{printf("LT\n"); currpos += yyleng;}
"<="		{printf("LTE\n"); currpos += yyleng;}
">"		{printf("GT\n"); currpos += yyleng;}
">="		{printf("GTE\n"); currpos += yyleng;}

";"		{printf("SEMICOLON\n"); currpos += yyleng;}
":"		{printf("COLON\n"); currpos += yyleng;}
","		{printf("COMMA\n"); currpos += yyleng;}

"("		{printf("L_PAREN\n"); currpos += yyleng;}
")"		{printf("R_PAREN\n"); currpos += yyleng;}
"["		{printf("L_SQUARE_BRACKET\n"); currpos += yyleng;}
"]"		{printf("R_SQUARE_BRACKET\n"); currpos += yyleng;}

":="		{printf("ASSIGN\n"); currpos += yyleng;}

{DIGIT}+	{printf("NUMBER %s\n", yytext); currpos += yyleng;}
[ \t]+		{currpos += yyleng;}
"\n"		{currline += 1;}		
[##].* 		{currline++; currpos = 1;}

{INVALIDSTART}	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n" , currline, currpos, yytext); exit(0);} 
{INVALIDEND}	{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n" , currline, currpos, yytext); exit(0);}
{VALIDID} 	{printf("IDENT %s\n", yytext); currpos += yyleng;}
. 		{printf("Error at line %d. column %d: unrecognized symbol \"%s\"\n", currline, currpos, yytext); exit(0);}
%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   yylex();
}
