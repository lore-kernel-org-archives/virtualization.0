From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v4 08/10] x86: process: Introduce helper for IO-related bits
	of exit_thread
Date: Sun, 2 Nov 2014 09:32:48 -0800
Message-ID: <0a47e59dec909be4e6b4fd7769e371a5fb14e3e4.1414870871.git.josh__15981.2543578029$1414949616$gmane$org@joshtriplett.org>
References: <cover.1414870871.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1414870871.git.josh@joshtriplett.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

This makes the two major functions of exit_thread (IO and FPU) more
obvious, and will make it easier to make IO optional later.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 arch/x86/kernel/process-io.h | 20 ++++++++++++++++++++
 arch/x86/kernel/process.c    | 20 +++-----------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/process-io.h b/arch/x86/kernel/process-io.h
index 6d4f147..012c1d5 100644
--- a/arch/x86/kernel/process-io.h
+++ b/arch/x86/kernel/process-io.h
@@ -24,6 +24,26 @@ static inline int copy_io_bitmap(struct task_struct *me,
 	return 0;
 }
 
+static inline void exit_thread_io(struct task_struct *me)
+{
+        struct thread_struct *t = &me->thread;
+        unsigned long *bp = t->io_bitmap_ptr;
+
+        if (bp) {
+                struct tss_struct *tss = &per_cpu(init_tss, get_cpu());
+
+                t->io_bitmap_ptr = NULL;
+                clear_thread_flag(TIF_IO_BITMAP);
+                /*
+                 * Careful, clear this in the TSS too:
+                 */
+                memset(tss->io_bitmap, 0xff, t->io_bitmap_max);
+                t->io_bitmap_max = 0;
+                put_cpu();
+                kfree(bp);
+        }
+}
+
 static inline void switch_iopl_mask(struct thread_struct *prev,
 				    struct thread_struct *next)
 {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index e127dda..37b45ca 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -29,6 +29,8 @@
 #include <asm/debugreg.h>
 #include <asm/nmi.h>
 
+#include "process-io.h"
+
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
  * no more per-task TSS's. The TSS size is kept cacheline-aligned
@@ -104,23 +106,7 @@ void arch_task_cache_init(void)
 void exit_thread(void)
 {
 	struct task_struct *me = current;
-	struct thread_struct *t = &me->thread;
-	unsigned long *bp = t->io_bitmap_ptr;
-
-	if (bp) {
-		struct tss_struct *tss = &per_cpu(init_tss, get_cpu());
-
-		t->io_bitmap_ptr = NULL;
-		clear_thread_flag(TIF_IO_BITMAP);
-		/*
-		 * Careful, clear this in the TSS too:
-		 */
-		memset(tss->io_bitmap, 0xff, t->io_bitmap_max);
-		t->io_bitmap_max = 0;
-		put_cpu();
-		kfree(bp);
-	}
-
+	exit_thread_io(me);
 	drop_fpu(me);
 }
 
-- 
2.1.1
