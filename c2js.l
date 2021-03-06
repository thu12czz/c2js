/* c2js flex flie */
Digit 	[0-9]
Letter 	[a-zA-Z]
Hex 	[a-fA-F0-9]
FS      (f|F|l|L)
E           [Ee][+-]?{Digit}+

%{
#include <iostream>
#include <fstream>

#define YYSTYPE char*
#include "c2js.tab.h"

using namespace std;

extern "C"
{
    void yyerror(const char* s);
    extern int yylex(void);
}

void showStr();
%}

%%
"//"            { cout<<"//: 		"; showStr();  return(COMMENT);	}
"char"          { cout<<"CHAR: 		"; showStr();  return(CHAR);	}
"double"        { cout<<"DOUBLE: 	"; showStr();  return(DOUBLE);	}
"float"         { cout<<"FLOAT: 	"; showStr();  return(FLOAT); 	}
"for"           { cout<<"FOR: 		"; showStr();  return(FOR);		}
"while"         { cout<<"WHILE: 	"; showStr();  return(WHILE);	}
"if"            { cout<<"IF: 		"; showStr();  return(IF);		}
"int"           { cout<<"INT: 		"; showStr();  return(INT);		}
"return"        { cout<<"RETURN: 	"; showStr();  return(RETURN);	}
"void"          { cout<<"VOID: 		"; showStr();  return(VOID);	}
"#include"      { cout<<"INCLUDE: 	"; showStr();  return(INCLUDE); }

[a-zA-Z][a-zA-Z0-9]*  { cout<<"IDENTIFIER: 	"; showStr();  return(IDENTIFIER); }

{Digit}*"."{Digit}+({E})?{FS}?  { cout<<"CONST:	"; showStr(); return(CONST); }
{Digit}+"."{Digit}*({E})?{FS}?  { cout<<"CONST:	"; showStr(); return(CONST); }
{Digit}              			{ cout<<"CONST:	"; showStr(); return(CONST); }

"\\n"			{ /* ignore enter key*/ }
[ \n\t\v\f] 	{ }
"++"            { cout<<"++:	"; showStr(); return(INC_OP);	}
"--"            { cout<<"--:	"; showStr(); return(DEC_OP); 	}
"<="            { cout<<"<=:	"; showStr(); return(LE_OP); 	}
">="            { cout<<">=:	"; showStr(); return(GE_OP); 	}
"=="            { cout<<"==:	"; showStr(); return(EQ_OP); 	}
"!="            { cout<<"!=:	"; showStr(); return(NE_OP); 	}
"&&"            { cout<<"&&:	"; showStr(); return(AND_OP);	}
"||"            { cout<<"||:	"; showStr(); return(OR_OP); 	}
"-"             { cout<<"-:		"; showStr(); return('-'); 		}
"+"             { cout<<"+:		"; showStr(); return('+'); 		}
"*"             { cout<<"*:		"; showStr(); return('*'); 		}
"/"             { cout<<"/:		"; showStr(); return('/'); 		}
"%"             { cout<<"%:		"; showStr(); return('%'); 		}
"\\"            { cout<<"\\:	"; showStr(); return('\\'); 	}
"<"             { cout<<"<:		"; showStr(); return('<'); 		}
"."             { cout<<".:		"; showStr(); return('.'); 		}
">"             { cout<<">:		"; showStr(); return('>'); 		}
","             { cout<<",:		"; showStr(); return(','); 		}
":"             { cout<<"::		"; showStr(); return(':'); 		}
";"             { cout<<";:		"; showStr(); return(';'); 		}
"="             { cout<<"=:		"; showStr(); return('='); 		}
"("             { cout<<"(:		"; showStr(); return('('); 		}
")"             { cout<<"):		"; showStr(); return(')'); 		}
"{"     		{ cout<<"{:		"; showStr(); return('{'); 		}
"}"      		{ cout<<"}:		"; showStr(); return('}'); 		}
"["      		{ cout<<"[:		"; showStr(); return('['); 		}
"]"      		{ cout<<"]:		"; showStr(); return(']'); 		}
"\""			{ cout<<"\":	"; showStr(); return('\"');		}



[a-zA-Z][a-zA-Z0-9]*  printf("Var     : %s\n",yytext);
[/+/%/*///-]          printf("Op      : %s\n",yytext);
[0-9]+                printf("Int     : %s\n",yytext);
[0-9]*[/.][0-9]+      printf("Float   : %s\n",yytext);

.                     printf("Unknown : %c\n",yytext[0]);

%%

void showStr()
{
	cout<<yytext<<endl;
}

int yywrap()
{
	return 1;
}