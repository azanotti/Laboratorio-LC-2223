%{
  import java.io.*;
%}

%token <sval> GROUPNAME
%token <sval> PROPERTY
%token <sval> VALUE
%type <sval> KEYVALUELIST
%type <sval> GROUPLIST
%type <sval> GROUP

%start START

%%

START: GROUPLIST { System.out.println($1); }

GROUPLIST: GROUP { $$ = $1 + "\n"; }
         | GROUPLIST GROUP { $$ = $1 + "\n"+ $2 + "\n"; }

GROUP: GROUPNAME KEYVALUELIST { $$ = "["+ $1 + "]" + "\n" + $2; }

KEYVALUELIST : PROPERTY VALUE {if($1.equals("\"matricola\"")){$$ = $1 + "=" + "885892";} else {$$ = $1 + "=" + $2;}}
             | KEYVALUELIST PROPERTY VALUE {if($1.equals("\"nome\"=\"Alessandro Zanotti\",") && $2.equals("\"matricola\"") && $3.equals("0")){System.out.println("sono nell'if"); $$ = $1 + "\n" + $2+ "=" + "885892";} else { $$ = $1 + "\n" + $2+ "=" + $3;} }

%%

  private Yylex lexer;
  private int yylex () {
    int yyl_return = -1;
    try {
      yylval = new ParserVal(0);
      yyl_return = lexer.yylex();
    }
    catch (IOException e) {
      System.err.println("IO error :"+e);
    }
    return yyl_return;
  }
  public void yyerror (String error) {
    System.err.println ("Error: " + error);
  }
  public Parser(Reader r) {
    lexer = new Yylex(r, this);
  }
  static boolean interactive;
  public static void main(String args[]) throws IOException {
    Parser yyparser;
    yyparser = new Parser(new FileReader(args[0]));
    yyparser.yyparse();
  }
