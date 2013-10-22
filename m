From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 1/3] x86: process: Unify 32-bit and 64-bit copy_thread I/O
	bitmap handling
Date: Tue, 22 Oct 2013 03:34:24 +0100
Message-ID: <41c886146639d4ab07331be335b889e2f48a79b5.1382407802.git.josh@joshtriplett.org>
References: <cover.1382407802.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1382407802.git.josh@joshtriplett.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, David Herrmann <dh.herrmann@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <keescook@chromium.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ross Lagerwall <rosslagerwall@gmail.com>, Chris
List-Id: virtualization@lists.linuxfoundation.org

The 32-bit and 64-bit versions of copy_thread have functionally
identical handling for copying the I/O bitmap, modulo differences in
error handling.  Clean up the error paths in both by moving the copy of
the I/O bitmap to the end, to eliminate the need to free it if
subsequent copy steps fail; move the resulting identical code to a
static inline in a common header.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 arch/x86/kernel/process-io.h | 22 ++++++++++++++++++++++
 arch/x86/kernel/process_32.c | 29 ++++++++---------------------
 arch/x86/kernel/process_64.c | 26 +++++---------------------
 3 files changed, 35 insertions(+), 42 deletions(-)
 create mode 100644 arch/x86/kernel/process-io.h

diff --git a/arch/x86/kernel/process-io.h b/arch/x86/kernel/process-io.h
new file mode 100644
index 0000000..d884444
--- /dev/null
+++ b/arch/x86/kernel/process-io.h
@@ -0,0 +1,22 @@
+#ifndef _X86_KERNEL_PROCESS_IO_H
+#define _X86_KERNEL_PROCESS_IO_H
+
+static inline int copy_io_bitmap(struct task_struct *me,
+				 struct task_struct *p)
+{
+	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
+		p->thread.io_bitmap_ptr = kmemdup(me->thread.io_bitmap_ptr,
+						  IO_BITMAP_BYTES, GFP_KERNEL);
+		if (!p->thread.io_bitmap_ptr) {
+			p->thread.io_bitmap_max = 0;
+			return -ENOMEM;
+		}
+		set_tsk_thread_flag(p, TIF_IO_BITMAP);
+	} else {
+		p->thread.io_bitmap_ptr = NULL;
+	}
+
+	return 0;
+}
+
+#endif /* _X86_KERNEL_PROCESS_IO_H */
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 884f98f..e86028b 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -56,6 +56,8 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 
+#include "process-io.h"
+
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 asmlinkage void ret_from_kernel_thread(void) __asm__("ret_from_kernel_thread");
 
@@ -135,7 +137,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct task_struct *tsk;
-	int err;
 
 	p->thread.sp = (unsigned long) childregs;
 	p->thread.sp0 = (unsigned long) (childregs+1);
@@ -167,36 +168,22 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 
 	p->fpu_counter = 0;
-	p->thread.io_bitmap_ptr = NULL;
 	tsk = current;
-	err = -ENOMEM;
 
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
-	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
-		p->thread.io_bitmap_ptr = kmemdup(tsk->thread.io_bitmap_ptr,
-						IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.io_bitmap_ptr) {
-			p->thread.io_bitmap_max = 0;
-			return -ENOMEM;
-		}
-		set_tsk_thread_flag(p, TIF_IO_BITMAP);
-	}
-
-	err = 0;
-
 	/*
 	 * Set a new TLS for the child thread?
 	 */
-	if (clone_flags & CLONE_SETTLS)
+	if (clone_flags & CLONE_SETTLS) {
+		int err;
 		err = do_set_thread_area(p, -1,
 			(struct user_desc __user *)childregs->si, 0);
-
-	if (err && p->thread.io_bitmap_ptr) {
-		kfree(p->thread.io_bitmap_ptr);
-		p->thread.io_bitmap_max = 0;
+		if(err)
+			return err;
 	}
-	return err;
+
+	return copy_io_bitmap(tsk, p);
 }
 
 void
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index bb1dc51..6e680ad 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -50,6 +50,8 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 
+#include "process-io.h"
+
 asmlinkage extern void ret_from_fork(void);
 
 asmlinkage DEFINE_PER_CPU(unsigned long, old_rsp);
@@ -154,7 +156,6 @@ static inline u32 read_32bit_tls(struct task_struct *t, int tls)
 int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct *p)
 {
-	int err;
 	struct pt_regs *childregs;
 	struct task_struct *me = current;
 
@@ -164,7 +165,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	p->thread.usersp = me->thread.usersp;
 	set_tsk_thread_flag(p, TIF_FORK);
 	p->fpu_counter = 0;
-	p->thread.io_bitmap_ptr = NULL;
 
 	savesegment(gs, p->thread.gsindex);
 	p->thread.gs = p->thread.gsindex ? 0 : me->thread.gs;
@@ -192,23 +192,13 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	if (sp)
 		childregs->sp = sp;
 
-	err = -ENOMEM;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
-	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
-		p->thread.io_bitmap_ptr = kmemdup(me->thread.io_bitmap_ptr,
-						  IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.io_bitmap_ptr) {
-			p->thread.io_bitmap_max = 0;
-			return -ENOMEM;
-		}
-		set_tsk_thread_flag(p, TIF_IO_BITMAP);
-	}
-
 	/*
 	 * Set a new TLS for the child thread?
 	 */
 	if (clone_flags & CLONE_SETTLS) {
+		int err;
 #ifdef CONFIG_IA32_EMULATION
 		if (test_thread_flag(TIF_IA32))
 			err = do_set_thread_area(p, -1,
@@ -217,16 +207,10 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 #endif
 			err = do_arch_prctl(p, ARCH_SET_FS, childregs->r8);
 		if (err)
-			goto out;
-	}
-	err = 0;
-out:
-	if (err && p->thread.io_bitmap_ptr) {
-		kfree(p->thread.io_bitmap_ptr);
-		p->thread.io_bitmap_max = 0;
+			return err;
 	}
 
-	return err;
+	return copy_io_bitmap(me, p);
 }
 
 static void
-- 
1.8.4.rc3
