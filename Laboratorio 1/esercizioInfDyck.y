%{
  import java.io.*;
%}

%token OPEN_PAREN;
%token CLOSE_PAREN;
%token OPEN_SQUARE_BRACKET;
%token CLOSE_SQUARE_BRACKET;
%token <sval> COLONS;
%token <sval> SKIP;
%token <sval> UPPERCASE_CHARS;
%token <sval> SERIAL;

%start s

%%

parens  : OPEN_PAREN s CLOSE_PAREN
        | OPEN_PAREN CLOSE_PAREN
		
brackets : OPEN_SQUARE_BRACKET s CLOSE_SQUARE_BRACKET
		 | OPEN_SQUARE_BRACKET CLOSE_SQUARE_BRACKET

exp     : parens
		| brackets

exps    : exp SKIP { System.out.println("txt: "+$2); }
		| exp COLONS SKIP {
			if($2.length() %2 == 0){ 
				System.out.println("txt: " + $3); 
			} else { 
				System.out.println("txt: :" + $3);
			} 
		  };
		| exp UPPERCASE_CHARS SKIP { 
			if($2.charAt(0) != $2.charAt(1)){
				System.out.print("Err: ");
			}
				System.out.println($3);  
			}
		| exp UPPERCASE_CHARS SERIAL { System.out.println("txt: " + $3); }
        | exp

s       : SKIP { System.out.println("txt: "+$1); }
		| COLONS SKIP {
			if($1.length()%2 == 0)
				System.out.println("txt: " + $2); 
			else
				System.out.println("txt: :" + $2);
		  }
		| UPPERCASE_CHARS SKIP {
			if($1.charAt(0) != $1.charAt(1)){
				System.out.print("Err: ");
			}
			System.out.println($2);
		}
		| UPPERCASE_CHARS SERIAL { System.out.println("txt: " + $2); }
        | exps
        | s exps

%%

void yyerror(String s)
{
 System.out.println("err:"+s);
 System.out.println("   :"+yylval.sval);
}

static Yylex lexer;
int yylex()
{
 try {
  return lexer.yylex();
 }
 catch (IOException e) {
  System.err.println("IO error :"+e);
  return -1;
 }
}

public static void main(String args[])
{
 System.out.println("[Quit with CTRL-D]");
 Parser par = new Parser();
 lexer = new Yylex(new InputStreamReader(System.in), par);
 par.yyparse();
}
