From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v4 09/10] x86: process: Introduce helper to switch IO bitmap
Date: Sun, 2 Nov 2014 09:32:55 -0800
Message-ID: <7da73a194a9856de21cf9cf035be29239ce88ef3.1414870871.git.josh__26033.3055783578$1414949622$gmane$org@joshtriplett.org>
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

This simplifies __switch_to_xtra, and will make it easier to make IO
optional later.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 arch/x86/kernel/process-io.h | 23 +++++++++++++++++++++++
 arch/x86/kernel/process.c    | 14 +-------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/process-io.h b/arch/x86/kernel/process-io.h
index 012c1d5..e48d5c9 100644
--- a/arch/x86/kernel/process-io.h
+++ b/arch/x86/kernel/process-io.h
@@ -57,4 +57,27 @@ static inline void switch_iopl_mask(struct thread_struct *prev,
                 set_iopl_mask(next->iopl);
 }
 
+static inline void switch_io_bitmap(struct tss_struct *tss,
+				    struct task_struct *prev_p,
+				    struct task_struct *next_p)
+{
+        struct thread_struct *prev, *next;
+        prev = &prev_p->thread;
+        next = &next_p->thread;
+
+        if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
+                /*
+                 * Copy the relevant range of the IO bitmap.
+                 * Normally this is 128 bytes or less:
+                 */
+                memcpy(tss->io_bitmap, next->io_bitmap_ptr,
+                       max(prev->io_bitmap_max, next->io_bitmap_max));
+        } else if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
+                /*
+                 * Clear any possible leftover bits:
+                 */
+                memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
+        }
+}
+
 #endif /* _X86_KERNEL_PROCESS_IO_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 37b45ca..7ac01bf 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -211,19 +211,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 			hard_enable_TSC();
 	}
 
-	if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
-		/*
-		 * Copy the relevant range of the IO bitmap.
-		 * Normally this is 128 bytes or less:
-		 */
-		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-		       max(prev->io_bitmap_max, next->io_bitmap_max));
-	} else if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
-		/*
-		 * Clear any possible leftover bits:
-		 */
-		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
-	}
+	switch_io_bitmap(tss, prev_p, next_p);
 	propagate_user_return_notify(prev_p, next_p);
 }
 
-- 
2.1.1
