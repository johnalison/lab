# makeslides - generate tex input
# input: sequence of lines describing sorting options
# output: Unix sort command with appropriate arguments

BEGIN {

    # Make These configs....
    title ="3b Study"
    names = "TEST John Alison, Patrick Bryant"
    institution = "CMU: Carnegie Mellon University"
    topDir = "./"
    slideTitle = ""
    subDir = ""
}


/^#/ {
    next
}

/^[t,T]itle/ {
    title = stripFirstWord(); next
}


/^[n,N]ame/ {
    names = stripFirstWord(); next
}

/[i,I]nstitution/ {
    institution = stripFirstWord(); next
}

/[s,S]ub[s,S]ection/ {
    gsub($1, "", $0);  
    slides[++n] = addSubSection($0);
    next
}

/[s,S]ection/ {
    gsub($1, "", $0);  
    slides[++n] = addSection($0);
    next
}

/[t,T]rans*/ {
    gsub($1, "", $0); 
    slides[++n] = addTransition($0);
    next
}

/[t,T]op[d,D]ir/ {
    topDir = stripFirstWord(); next
}

/[s,S]ub[d,D]ir/ {
    subDir = stripFirstWord(); next
}


/^[s,S]lide[t,T]itle/ {
    slideTitle = stripFirstWord(); next
}

/./ {
    slides[++n] = slideWithPlots()
}


END {

    printTitle()


    for (iSlide=1; iSlide<=length(slides); iSlide++){
	printf( slides[iSlide])
    }

    
    trailer = "\\end{document} \n"
    printf(trailer)
}

function slideWithPlots(){
    outputText = ""
    exampleSlide = "\\begin{frame} \n"					\
	"\\begin{picture}(10,8) \n"					
    outputText = outputText sprintf(exampleSlide)

    #offSets[1] = "0.45 ,3.8"
    #offSets[2] = "5.45 ,3.8"
    #offSets[3] = "0.45,-0.6"
    #offSets[4] = "5.45 ,-0.6"

    offSets[1] = "0.45 ,3.1"
    offSets[2] = "5.45 ,3.1"
    offSets[3] = "0.45,-1.2"
    offSets[4] = "5.45 ,-1.2"
    
    
    for (iPlot=1; iPlot<=NF; iPlot++){
	exampleSlide = "\\put(%s){\\includegraphics[width=1.75in]{%s/%s/%s.pdf}}\n" 
	outputText = outputText sprintf(exampleSlide,offSets[iPlot],topDir,subDir,$iPlot)
    }
    outputText = outputText sprintf("\\put(4,7.6){\\textcolor{myred}{\\huge %s}}  \n",slideTitle)
    outputText = outputText "\\end{picture}\n"	
    outputText = outputText "\\end{frame}\n"			

    return outputText
    
}

function addTransition(transitionName){
    transitionText = "\n"		   \
	"\\begin{frame}\n"		   \
	"\\begin{picture}(10,8) \n"				  \
	"  \\put(0,4){\\textcolor{myred}{\\Huge \\textit{%s}}}\n" \
	"\\end{picture}\n"					  \
	"\\end{frame}\n" 

    return sprintf(transitionText,transitionName)
}


function addSection(sectionName){
    return sprintf("\\section{%s} \n",sectionName)
}

function addSubSection(subSectionName){
    return sprintf("\\subsection{%s} \n", subSectionName)
}

function stripFirstWord(){
    gsub($1, "", $0);        # Remove first word
    gsub(/^[ \t]/, "", $0);  # Strip leading whiteSpace
    return $0
}


function printTitle(){

    header = "\\documentclass{beamer} \n"	\
	"\\mode<presentation> \n" \
	"\\setbeamertemplate{footline}[frame number]\n" \
	"\\addtobeamertemplate{frametitle}{\\vspace*{0.4cm}}{\\vspace*{-0.4cm}}\n" \
	"{ \\usetheme{boxes} }\n" \
	"\\usepackage{times}  \n" \
	"\\usefonttheme{serif}  \n" \
	"\\usepackage{graphicx}\n" \
	"\\usepackage{tikz}\n" \
	"\\usepackage{colortbl}\n" \
	"\\setlength{\\pdfpagewidth}{2\\paperwidth}\n" \
	"\\setlength{\\pdfpageheight}{2\\paperheight}\n"
    printf(header)

    
    header = "\\title{\\huge \\textcolor{myblue}{{%s }}}\n"			\
	"\\author{\\textcolor{cmured}{{\\Large \\\\%s\\\\}}\n" \
	"\\vspace*{1cm} \n" \
	"  \\textit{\\Large %s}\n" 
    printf(header, title, names, institution)

    header = "}\n"		     \
	"\\date{  } \n" \
	"\n" \
	"\\usepackage{tikz} \n"			\
	"\\titlegraphic { \n" \
	"\\begin{tikzpicture}[overlay,remember picture] \n" \
	"\\node[left=0.2cm] at (current page.30){ \n" \
	"\\includegraphics[width=0.6in]{CMSlogo_outline_black_red_nolabel_May2014.pdf} \n" \
	"};\n" \
	"\\node[right=0.2cm] at (current page.150){ \n" \
	"\\includegraphics[width=0.8in]{CMU_Logo_Stack_Red.eps} \n" \
	"}; \n" \
	"\\end{tikzpicture} \n" \
	"} \n" \
	"\n"					   \
	"\\beamertemplatenavigationsymbolsempty\n" \
	"\n" \
	"\\unitlength=1cm\n" \
	"\\definecolor{myblue}{RGB}{33,100,158}\n" \
	"\\definecolor{myblack}{RGB}{0,0,0}\n" \
	"\\definecolor{myred}{RGB}{168,56,39}\n" \
	"\\definecolor{cmured}{RGB}{173,29,53}\n" \
	"\\definecolor{mygreen}{RGB}{0,204,0}\n" \
	"\\begin{document}\n" \
	"\n" \
	"\n" \
	"\\begin{frame}\n" \
	"\\titlepage\n" \
	"\\end{frame}\n"	   \

    printf(header)
}


