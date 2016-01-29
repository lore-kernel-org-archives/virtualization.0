From: "tip-bot for Michael S. Tsirkin" <tipbot@zytor.com>
Subject: [tip:locking/core] locking/x86: Add cc clobber for ADDL
Date: Fri, 29 Jan 2016 03:32:09 -0800
Message-ID: <tip-bd922477d9350a3006d73dabb241400e6c4181b0@git.kernel.org>
References: <1453921746-16178-2-git-send-email-mst@redhat.com>
Reply-To: brgerst@gmail.com, dvlasenk@redhat.com, bp@suse.de,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	peterz@infradead.org, andreyknvl@google.com, tglx@linutronix.de,
	mst@redhat.com, virtualization@lists.linux-foundation.org,
	paulmck@linux.vnet.ibm.com, dbueso@suse.de, bp@alien8.de,
	hpa@zytor.com, dave@stgolabs.net, luto@kernel.org,
	luto@amacapital.net, torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1453921746-16178-2-git-send-email-mst@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-tip-commits@vger.kernel.org
Cc: dave@stgolabs.net, dvlasenk@redhat.com, akpm@linux-foundation.org, mst@redhat.com, peterz@infradead.org, andreyknvl@google.com, hpa@zytor.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, luto@amacapital.net, dbueso@suse.de, bp@alien8.de, luto@kernel.org, brgerst@gmail.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, bp@suse.de, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Commit-ID:  bd922477d9350a3006d73dabb241400e6c4181b0
Gitweb:     http://git.kernel.org/tip/bd922477d9350a3006d73dabb241400e6c4181b0
Author:     Michael S. Tsirkin <mst@redhat.com>
AuthorDate: Thu, 28 Jan 2016 19:02:29 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 29 Jan 2016 09:40:10 +0100

locking/x86: Add cc clobber for ADDL

ADDL clobbers flags (such as CF) but barrier.h didn't tell this
to GCC. Historically, GCC doesn't need one on x86, and always
considers flags clobbered. We are probably missing the cc
clobber in a *lot* of places for this reason.

But even if not necessary, it's probably a good thing to add for
documentation, and in case GCC semantcs ever change.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization <virtualization@lists.linux-foundation.org>
Link: http://lkml.kernel.org/r/1453921746-16178-2-git-send-email-mst@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/barrier.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index a584e1c..a65bdb1 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -15,9 +15,12 @@
  * Some non-Intel clones support out of order store. wmb() ceases to be a
  * nop for these.
  */
-#define mb() alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
-#define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
-#define wmb() alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
+#define mb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "mfence", \
+				      X86_FEATURE_XMM2) ::: "memory", "cc")
+#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "lfence", \
+				       X86_FEATURE_XMM2) ::: "memory", "cc")
+#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "sfence", \
+				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #else
 #define mb() 	asm volatile("mfence":::"memory")
 #define rmb()	asm volatile("lfence":::"memory")
