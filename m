From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/3] x86: drop a comment left over from X86_OOSTORE
Date: Wed, 13 Jan 2016 00:10:19 +0200
Message-ID: <1452635935-5439-3-git-send-email-mst@redhat.com>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1452635935-5439-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, Andrey Konovalov <andreyknvl@google.com>, the arch/x86 maintainers <x86@kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The comment about wmb being non-nop is a left over from before commit
09df7c4c8097 ("x86: Remove CONFIG_X86_OOSTORE").

It makes no sense now: if you have an SMP system with out of order
stores, making wmb not a nop will not help.

Additionally, wmb is not a nop even for regular intel CPUs because of
weird use-cases e.g. dealing with WC memory.

Drop this comment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/x86/include/asm/barrier.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7f99726..eb220b8 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -11,11 +11,6 @@
  */
 
 #ifdef CONFIG_X86_32
-/*
- * Some non-Intel clones support out of order store. wmb() ceases to be a
- * nop for these.
- */
-
 #define mb() asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
 #define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
 #define wmb() alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
-- 
MST
