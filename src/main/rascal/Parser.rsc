module main::rascal::Parser

import main::rascal::Syntax;
import ParseTree;

public start[Planning] parsePlanning(str src, loc origin) = parse(#start[Planning], src, origin);
public start[Planning] parsePlanning(loc origin) = parse(#start[Planning], origin);