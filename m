From: Will Deacon <will@kernel.org>
Subject: [PATCH 03/13] READ_ONCE: Allow __READ_ONCE_SIZE cases to be
	overridden by the architecture
Date: Fri,  8 Nov 2019 17:01:10 +0000
Message-ID: <20191108170120.22331-4-will__40097.8209961735$1573232539$gmane$org@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Josh Triplett <josh@joshtriplett.org>, Yunjae Lee <lyj7694@gmail.com>, SeongJae Park <sj38.park@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Joe Perches <joe@perches.com>, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

The meat and potatoes of 'READ_ONCE()' is defined by the
'__READ_ONCE_SIZE()' macro, which uses volatile casts in an attempt to
avoid tearing of byte, halfword, word and double-word accesses. Allow
this to be overridden by the architecture code in the case that things
like memory barriers are also required.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/rwonce.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index abf326634ecd..2c2ac0948c94 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -33,13 +33,29 @@
 
 #include <asm/barrier.h>
 
+#ifndef __read_once_size_1
+#define __read_once_size_1(p)	(*(volatile __u8 *)(p))
+#endif
+
+#ifndef __read_once_size_2
+#define __read_once_size_2(p)	(*(volatile __u16 *)(p))
+#endif
+
+#ifndef __read_once_size_4
+#define __read_once_size_4(p)	(*(volatile __u32 *)(p))
+#endif
+
+#ifndef __read_once_size_8
+#define __read_once_size_8(p)	(*(volatile __u64 *)(p))
+#endif
+
 #define __READ_ONCE_SIZE						\
 ({									\
 	switch (size) {							\
-	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
-	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
-	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
-	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
+	case 1: *(__u8 *)res = __read_once_size_1(p); break;		\
+	case 2: *(__u16 *)res = __read_once_size_2(p); break;		\
+	case 4: *(__u32 *)res = __read_once_size_4(p); break;		\
+	case 8: *(__u64 *)res = __read_once_size_8(p); break;		\
 	default:							\
 		barrier();						\
 		__builtin_memcpy((void *)res, (const void *)p, size);	\
@@ -59,6 +75,10 @@ void __read_once_size_nocheck(const volatile void *p, void *res, int size)
 	__READ_ONCE_SIZE;
 }
 
+#undef __read_once_size_1
+#undef __read_once_size_2
+#undef __read_once_size_4
+#undef __read_once_size_8
 #undef __READ_ONCE_SIZE
 
 static __always_inline void __write_once_size(volatile void *p, void *res, int size)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
