module main::rascal::Generator3

import IO;
import Set;
import List;
import main::rascal::AST;
import String;

import main::rascal::Parser;
import main::rascal::Implode;

str generator3(cast) {
    ast = implode(cast);
    rVal = 
        "Info of the planning DepartmentABC
        'All Persons:
	    '       <for (person <- {name | /personTasks(name, _) := ast }) {><person>
        '       <}>
        'All actions of tasks:
        '======
        '        <printTaskWithDuration(ast)>
        '=====
        'Other way of listing all tasks:
        '        <printTaskWithoutDuration(ast)>
        '";
    return rVal;
}

str printTaskWithDuration(ast) {
    rVal = [];
    for (<a, p, d> <- [ <action, prio, duration> | /task(action, prio, duration) := ast ]) {
        rVal += "<printAction(a)> <p> <printDuration(d)>";
    }
    return intercalate(" &\n", rVal);
}

str printTaskWithoutDuration(ast) {   //Esta y la anterior la cambie, porqu emandaba un error en prio, estaba usando prio por fuera de donde se define
    rVal = [];
    for (<a, p> <- { <action, prio> | /task(action, prio, _) := ast }) { //aca en l for y en el anterior estaban extrayendo a y d, pero no p, por eso me marcaba error en prio
        rVal += "<printAction(a)> <p>";
    }
    return intercalate(" ,\n", rVal);
}

str printAction(action) {
    if (/lunchAction(location)  := action)  return "Lunch at location <location>";
    if (/meetingAction(topic)   := action)  return "Meeting with topic <replaceAll(topic, "\"", "")>";
    if (/paperAction(report)    := action)  return "Paper for journal <report>";
    if (/paymentAction(amount)  := action)  return "Pay <amount> Euro";
    return "Unknown action!";
}

str printDuration(duration) {
    rVal = "";
    if (/duration(dl, _) := duration) {
        u = "";
        if (/minute() := duration) u = "m";
        if (/hour()   := duration) u = "h";
        if (/day()    := duration) u = "d";
        if (/week()   := duration) u = "w";
        return "with duration: <dl> <u>";
    } else {
        ; // duration is optional
    }
    return rVal;
}