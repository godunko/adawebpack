------------------------------------------------------------------------------
--                                                                          --
--                  GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                --
--                                                                          --
--                             S Y S T E M . I N I T                        --
--                                                                          --
--                                   S p e c                                --
--                                                                          --
--          Copyright (C) 2003-2020, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNARL was developed by the GNARL team at Florida State University.       --
-- Extensive contributions were provided by AdaCore.                        --
--                                                                          --
------------------------------------------------------------------------------

--  This unit contains initialization circuits that are system dependent

--  This package is for use with configurable runtimes, and replaces init.c

pragma Restrictions (No_Elaboration_Code);
--  The procedure Install_Handler is called by the binder generated file before
--  any elaboration code, so we use the No_Elaboration_Code restriction to be
--  enfore full static preelaboration.

package System.Init is
   pragma Preelaborate;

   procedure Install_Handler;
   pragma Export (C, Install_Handler, "__gnat_install_handler");
   --  Install signal handlers. This procedure is called by Runtime_Initialize,
   --  but it may also be called by the tasking runtime when a task is created.

   procedure Runtime_Initialize (Install_Handler : Integer);
   pragma Export (C, Runtime_Initialize, "__gnat_runtime_initialize");
   --  This procedure is called by adainit before the elaboration of other
   --  units. It usually installs handler for the synchronous signals. The C
   --  profile here is what is expected by the binder-generated main.

   procedure Runtime_Finalize;
   pragma Export (C, Runtime_Finalize, "__gnat_runtime_finalize");
   --  This procedure is called by adafinal.
private
   -----------------------------
   -- Binder Generated Values --
   -----------------------------

   Gl_Leap_Seconds_Support : Integer := 0;
   pragma Export (C, Gl_Leap_Seconds_Support, "__gl_leap_seconds_support");

   Gl_Time_Slice_Val : Integer := -1;
   pragma Export (C, Gl_Time_Slice_Val, "__gl_time_slice_val");

   Gl_Wc_Encoding : Character := 'n';
   pragma Export (C, Gl_Wc_Encoding, "__gl_wc_encoding");

   Gl_Locking_Policy : Character := ' ';
   pragma Export (C, Gl_Locking_Policy, "__gl_locking_policy");

   Gl_Queuing_Policy : Character := ' ';
   pragma Export (C, Gl_Queuing_Policy, "__gl_queuing_policy");

   Gl_Task_Dispatching_Policy : Character := ' ';
   pragma Export (C, Gl_Task_Dispatching_Policy,
                     "__gl_task_dispatching_policy");

   Gl_Priority_Specific_Dispatching : Address := Null_Address;
   pragma Export (C, Gl_Priority_Specific_Dispatching,
                     "__gl_priority_specific_dispatching");

   Gl_Num_Specific_Dispatching : Integer := 0;
   pragma Export (C, Gl_Num_Specific_Dispatching,
                  "__gl_num_specific_dispatching");

   Gl_Restrictions : Address := Null_Address;
   pragma Export (C, Gl_Restrictions, "__gl_restrictions");

   Gl_Interrupt_States : Address := Null_Address;
   pragma Export (C, Gl_Interrupt_States, "__gl_interrupt_states");

   Gl_Num_Interrupt_States : Integer := 0;
   pragma Export (C, Gl_Num_Interrupt_States, "__gl_num_interrupt_states");

   Gl_Unreserve_All_Interrupts : Integer := 0;
   pragma Export (C, Gl_Unreserve_All_Interrupts,
                  "__gl_unreserve_all_interrupts");

   Gl_Exception_Tracebacks : Integer := 0;
   pragma Export (C, Gl_Exception_Tracebacks, "__gl_exception_tracebacks");

   Gl_Exception_Tracebacks_Symbolic : Integer := 0;
   pragma Export (C, Gl_Exception_Tracebacks_Symbolic,
                  "__gl_exception_tracebacks_symbolic");

   Gl_Detect_Blocking : Integer := 0;
   pragma Export (C, Gl_Detect_Blocking, "__gl_detect_blocking");

   Gl_Default_Stack_Size : Integer := 0;
   pragma Export (C, Gl_Default_Stack_Size, "__gl_default_stack_size");

   Gl_Bind_Env_Addr : Address := Null_Address;
   pragma Export (C, Gl_Bind_Env_Addr, "__gl_bind_env_addr");

   --  The following two variables are deliberately commented out. They are
   --  referenced by the binder generated file, but they cannot be shared among
   --  different versions of System.Init. The reason is that the ravenscar
   --  version of System.Tasking (s-taskin-raven.adb) redefines these variables
   --  because the ravenscar/sfp runtime doesn't use System.Init, while the
   --  ravenscar/full runtime does.

   --  Gl_Main_Priority : Integer := -1;
   --  pragma Export (C, Gl_Main_Priority, "__gl_main_priority");

   --  Gl_Main_CPU : Integer := -1;
   --  pragma Export (C, Gl_Main_CPU, "__gl_main_cpu");

end System.Init;
