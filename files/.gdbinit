set debuginfod enabled on

# Stop on AddressSanitizer reports before the process exits
set breakpoint pending on
break __asan::ReportGenericError
set breakpoint pending auto

# Machine-specific settings (e.g., add-auto-load-safe-path), not tracked in the
# dotfiles repo. gdb has no conditional include, so go through Python.
python
import os
local = os.path.expanduser("~/.gdbinit.local")
if os.path.isfile(local):
    gdb.execute("source " + local)
end
