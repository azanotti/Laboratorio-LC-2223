
%%

%byaccj

%{
  /* store a reference to the parser object */
  private Parser yyparser;

  /* constructor taking an additional parser object */
  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
%}

%%

"("                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.OPEN_PAREN; 
					  }
")"                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.CLOSE_PAREN; 
					  }
"["					  { yyparser.yylval = new ParserVal(""+yycharat(0));
						return Parser.OPEN_SQUARE_BRACKET; 
					  }
"]"					  { yyparser.yylval = new ParserVal(""+yycharat(0));
						return Parser.CLOSE_SQUARE_BRACKET;
					  }
":"+			      { yyparser.yylval = new ParserVal(yytext());
						return Parser.COLONS;
					  }
[A-Z]{2}			  {	yyparser.yylval = new ParserVal(yytext());
						return Parser.UPPERCASE_CHARS;
					  }
[a-z]+           	  { yyparser.yylval = new ParserVal(yytext());
                        return Parser.SKIP;
					  }
"885892"			  {	yyparser.yylval = new ParserVal(yytext());
						return Parser.SERIAL;
					  }
[^] {} /*butta il resto*/
