From: "tip-bot for Michael S. Tsirkin" <tipbot@zytor.com>
Subject: [tip:locking/core] locking/x86:
	Drop a comment left over from X86_OOSTORE
Date: Fri, 29 Jan 2016 03:32:30 -0800
Message-ID: <tip-e37cee133c72c9529f74a20d9b7eb3b6dfb928b5@git.kernel.org>
References: <1453921746-16178-3-git-send-email-mst@redhat.com>
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dbueso@suse.de, luto@amacapital.net,
	virtualization@lists.linux-foundation.org, tglx@linutronix.de,
	luto@kernel.org, hpa@zytor.com, brgerst@gmail.com, bp@alien8.de,
	akpm@linux-foundation.org, dave@stgolabs.net,
	torvalds@linux-foundation.org, andreyknvl@google.com, bp@suse.de,
	mst@redhat.com, paulmck@linux.vnet.ibm.com, dvlasenk@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1453921746-16178-3-git-send-email-mst@redhat.com>
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
Cc: paulmck@linux.vnet.ibm.com, dvlasenk@redhat.com, akpm@linux-foundation.org, dbueso@suse.de, peterz@infradead.org, andreyknvl@google.com, mst@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, luto@amacapital.net, dave@stgolabs.net, bp@alien8.de, bp@suse.de, luto@kernel.org, brgerst@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Commit-ID:  e37cee133c72c9529f74a20d9b7eb3b6dfb928b5
Gitweb:     http://git.kernel.org/tip/e37cee133c72c9529f74a20d9b7eb3b6dfb928b5
Author:     Michael S. Tsirkin <mst@redhat.com>
AuthorDate: Thu, 28 Jan 2016 19:02:37 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 29 Jan 2016 09:40:10 +0100

locking/x86: Drop a comment left over from X86_OOSTORE

The comment about wmb being non-NOP to deal with non-Intel CPUs
is a left over from before the following commit:

  09df7c4c8097 ("x86: Remove CONFIG_X86_OOSTORE")

It makes no sense now: in particular, wmb() is not a NOP even for
regular Intel CPUs because of weird use-cases e.g. dealing with
WC memory.

Drop this comment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
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
Link: http://lkml.kernel.org/r/1453921746-16178-3-git-send-email-mst@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/barrier.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index a65bdb1..a291745 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -11,10 +11,6 @@
  */
 
 #ifdef CONFIG_X86_32
-/*
- * Some non-Intel clones support out of order store. wmb() ceases to be a
- * nop for these.
- */
 #define mb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "mfence", \
 				      X86_FEATURE_XMM2) ::: "memory", "cc")
 #define rmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "lfence", \
