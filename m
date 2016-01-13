From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 4/4] x86: drop mfence in favor of lock+addl
Date: Wed, 13 Jan 2016 22:12:44 +0200
Message-ID: <1452715911-12067-5-git-send-email-mst__25858.8248434991$1452716004$gmane$org@redhat.com>
References: <1452715911-12067-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1452715911-12067-1-git-send-email-mst@redhat.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, Andrey Konovalov <andreyknvl@google.com>, the arch/x86 maintainers <x86@kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>
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

Update rmb/wmb on 32 bit to use the negative offset, too, for
consistency.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/x86/include/asm/barrier.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index bfb28ca..9a2d257 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -11,16 +11,15 @@
  */
 
 #ifdef CONFIG_X86_32
-#define mb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "mfence", \
-				      X86_FEATURE_XMM2) ::: "memory", "cc")
-#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "lfence", \
+#define mb() asm volatile("lock; addl $0,-4(%%esp)" ::: "memory", "cc")
+#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
-#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "sfence", \
+#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #else
-#define mb() 	asm volatile("mfence":::"memory")
-#define rmb()	asm volatile("lfence":::"memory")
-#define wmb()	asm volatile("sfence" ::: "memory")
+#define mb() asm volatile("lock; addl $0,-4(%%rsp)" ::: "memory", "cc")
+#define rmb() asm volatile("lfence" ::: "memory")
+#define wmb() asm volatile("sfence" ::: "memory")
 #endif
 
 #ifdef CONFIG_X86_PPRO_FENCE
-- 
MST
