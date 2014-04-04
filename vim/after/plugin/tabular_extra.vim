if !exists(':Tabularize')
  finish " Tabular.vim wasn't loaded
endif

AddTabularPattern!  table       /|/
AddTabularPattern!  second_arg  /,\s*\zs[^\s]/l1r0
AddTabularPattern!  properties  /:\zs*/l0r1
AddTabularPattern!  rdoc        /# =>/
