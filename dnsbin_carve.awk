prev == $0 { next }
{ prev=$0 }

/^start-/  { active=1; next }
/^end-/  { active=0; next }
active == 1 { print }
