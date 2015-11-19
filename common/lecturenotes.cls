\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lecturenotes}[2015/11/14 A simple class for lecture notes]

\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{report}
}

\ProcessOptions\relax

\LoadClass[a4paper,twoside]{report}

\RequirePackage[T1]{fontenc}
\RequirePackage[italian]{babel}
\RequirePackage{hyperref}
\RequirePackage{nameref}
\RequirePackage{fullpage}
\RequirePackage{parskip}

\RequirePackage{fancyhdr}

\pagestyle{fancyplain}
\fancyhead{} % clear all header fields
\fancyfoot{} % clear all footer fields
\fancyfoot[C]{\today}
\fancyfoot[LE,RO]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\RequirePackage{makeidx}
\makeindex

\endinput


