From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 5/5] x86: drop mfence in favor of lock+addl
Date: Thu, 28 Jan 2016 19:02:58 +0200
Message-ID: <1453921746-16178-6-git-send-email-mst__28539.8675980561$1454000627$gmane$org@redhat.com>
References: <1453921746-16178-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1453921746-16178-1-git-send-email-mst@redhat.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, Andrey Konovalov <andreyknvl@google.com>, the arch/x86 maintainers <x86@kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

mfence appears to be way slower than a locked instruction - let's use
lock+add unconditionally, as we always did on old 32-bit.

Just poking at SP would be the most natural, but if we
then read the value from SP, we get a false dependency
which will slow us down.

This was noted in this article:
http://shipilev.net/blog/2014/on-the-fence-with-dependencies/

And is easy to reproduce by sticking a barrier in a small non-inline
function.

So let's use a negative offset - which avoids this problem since we
build with the red zone disabled.

Unfortunately there's some code that wants to order clflush instructions
using mb(), so we can't replace that - but smp_mb should be safe
to replace.

Update mb/rmb/wmb on 32 bit to use the negative offset, too, for
consistency.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/x86/include/asm/barrier.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index bfb28ca..3c6ba1e 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -11,11 +11,11 @@
  */
 
 #ifdef CONFIG_X86_32
-#define mb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "mfence", \
+#define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "mfence", \
 				      X86_FEATURE_XMM2) ::: "memory", "cc")
-#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "lfence", \
+#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
-#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "sfence", \
+#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #else
 #define mb() 	asm volatile("mfence":::"memory")
@@ -30,7 +30,11 @@
 #endif
 #define dma_wmb()	barrier()
 
-#define __smp_mb()	mb()
+#ifdef CONFIG_X86_32
+#define __smp_mb()	asm volatile("lock; addl $0,-4(%%esp)" ::: "memory", "cc")
+#else
+#define __smp_mb()	asm volatile("lock; addl $0,-4(%%rsp)" ::: "memory", "cc")
+#endif
 #define __smp_rmb()	dma_rmb()
 #define __smp_wmb()	barrier()
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
-- 
MST
