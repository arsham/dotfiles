#!/bin/zsh

typeset -A DONE

_get_dependencies() {
    go list -f "{{if not .Standard}}{{printf \"\t%q -> %q;\n\" \"$1\" .ImportPath}}{{end}}" "$2"
}

_build_graph() {
    if [ -z ${DONE[$1]} ]
    then
        DONE[$1]="done"
        for d in $(go list -f '{{if not .Standard}}{{join .Imports " "}}{{end}}' "$1")
        do
            _get_dependencies "$1" "$d"
            _build_graph "$d"
        done
    fi
}


(
	echo "digraph G {"
	_build_graph "$1"
	echo "}"
) | dot -Tsvg -o /tmp/tmp_graph.svg
xdg-open /tmp/tmp_graph.svg

