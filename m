From: akpm@linux-foundation.org
Subject: [patch 1/9] lguest: export symbols for lguest as a module
Date: Wed, 09 May 2007 02:51:34 -0700
Message-ID: <200705090951.l499pY1W020383@shell0.pdx.osdl.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756582AbXEIJwq@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, akpm@linux-foundation.org, rusty@rustcorp.com.au
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>

lguest does some fairly lowlevel things to support a host, which
normal modules don't need:

math_state_restore:
	When the guest triggers a Device Not Available fault, we need
	to be able to restore the FPU

__put_task_struct:
	We need to hold a reference to another task for inter-guest
	I/O, and put_task_struct() is an inline function which calls
	__put_task_struct.

access_process_vm:
	We need to access another task for inter-guest I/O.

map_vm_area & __get_vm_area:
	We need to map the switcher shim (ie. monitor) at 0xFFC01000.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/i386/kernel/traps.c |    1 +
 kernel/fork.c            |    1 +
 mm/memory.c              |    1 +
 mm/vmalloc.c             |    2 ++
 4 files changed, 5 insertions(+)

diff -puN arch/i386/kernel/traps.c~lguest-export-symbols-for-lguest-as-a-module arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c~lguest-export-symbols-for-lguest-as-a-module
+++ a/arch/i386/kernel/traps.c
@@ -1058,6 +1058,7 @@ asmlinkage void math_state_restore(void)
 	thread->status |= TS_USEDFPU;	/* So we fnsave on switch_to() */
 	tsk->fpu_counter++;
 }
+EXPORT_SYMBOL_GPL(math_state_restore);
 
 #ifndef CONFIG_MATH_EMULATION
 
diff -puN kernel/fork.c~lguest-export-symbols-for-lguest-as-a-module kernel/fork.c
--- a/kernel/fork.c~lguest-export-symbols-for-lguest-as-a-module
+++ a/kernel/fork.c
@@ -126,6 +126,7 @@ void __put_task_struct(struct task_struc
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
 }
+EXPORT_SYMBOL_GPL(__put_task_struct);
 
 void __init fork_init(unsigned long mempages)
 {
diff -puN mm/memory.c~lguest-export-symbols-for-lguest-as-a-module mm/memory.c
--- a/mm/memory.c~lguest-export-symbols-for-lguest-as-a-module
+++ a/mm/memory.c
@@ -2829,3 +2829,4 @@ int access_process_vm(struct task_struct
 
 	return buf - old_buf;
 }
+EXPORT_SYMBOL_GPL(access_process_vm);
diff -puN mm/vmalloc.c~lguest-export-symbols-for-lguest-as-a-module mm/vmalloc.c
--- a/mm/vmalloc.c~lguest-export-symbols-for-lguest-as-a-module
+++ a/mm/vmalloc.c
@@ -159,6 +159,7 @@ int map_vm_area(struct vm_struct *area, 
 	flush_cache_vmap((unsigned long) area->addr, end);
 	return err;
 }
+EXPORT_SYMBOL_GPL(map_vm_area);
 
 static struct vm_struct *__get_vm_area_node(unsigned long size, unsigned long flags,
 					    unsigned long start, unsigned long end,
@@ -237,6 +238,7 @@ struct vm_struct *__get_vm_area(unsigned
 {
 	return __get_vm_area_node(size, flags, start, end, -1, GFP_KERNEL);
 }
+EXPORT_SYMBOL_GPL(__get_vm_area);
 
 /**
  *	get_vm_area  -  reserve a contingous kernel virtual area
_
