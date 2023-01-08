%%

%byaccj

%{
  private Parser yyparser;
  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
%}
NL  = \n | \r
BEGINCONTENT = "{"
ENDCONTENT = "};"
DELIMITER = ":"

%state CONTENT
%state VALUE
%state STARTCONTENT

%%
<YYINITIAL> {
  [\s]+                            { }
  [^:\{\n\r]+ {DELIMITER}           { String s = yytext();
                                     s = s.substring(0, s.length() - 1);
                                     yyparser.yylval = new ParserVal(s);
                                     yybegin(STARTCONTENT);
                                     return Parser.GROUPNAME; }
}
<STARTCONTENT> {
  [\s]+                            { }
  {BEGINCONTENT}                      { yybegin(CONTENT); }
}

<CONTENT> {
  [\s]+                            { }
  [^\s]+[^\n\r"};"\:]* {DELIMITER}  { String s = yytext();
                                     s = s.substring(0, s.length() - 1);
                                     yyparser.yylval = new ParserVal(s);
                                     yybegin(VALUE);
                                     return Parser.PROPERTY; }
  {ENDCONTENT}                        { yybegin(YYINITIAL); }
}

<VALUE> {
  [\s]+                            { }
  [^\s]+[^\n\r]* {NL}              { String s = yytext();
                                     s = s.substring(0, s.length() - 1);
                                     yyparser.yylval = new ParserVal(s);
                                     yybegin(CONTENT);
                                     return Parser.VALUE; }
}

/* error fallback */
[^]    { System.err.println("Error: unexpected character '"+yytext()+"'"); return -1; }