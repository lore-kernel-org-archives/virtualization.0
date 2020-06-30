From: Will Deacon <will@kernel.org>
Subject: [PATCH 05/18] asm/rwonce: Remove smp_read_barrier_depends() invocation
Date: Tue, 30 Jun 2020 18:37:21 +0100
Message-ID: <20200630173734.14057-6-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.orgv
List-Id: virtualization@lists.linuxfoundation.org

Alpha overrides __READ_ONCE() directly, so there's no need to use
smp_read_barrier_depends() in the core code. This also means that
__READ_ONCE() can be relied upon to provide dependency ordering.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/rwonce.h | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index f9dfa88fc04d..cc810f1f18ca 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -30,24 +30,16 @@
 
 /*
  * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
- * atomicity or dependency ordering guarantees. Note that this may result
- * in tears!
+ * atomicity. Note that this may result in tears!
  */
 #ifndef __READ_ONCE
 #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
 #endif
 
-#define __READ_ONCE_SCALAR(x)						\
-({									\
-	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
-	smp_read_barrier_depends();					\
-	(typeof(x))__x;							\
-})
-
 #define READ_ONCE(x)							\
 ({									\
 	compiletime_assert_rwonce_type(x);				\
-	__READ_ONCE_SCALAR(x);						\
+	__READ_ONCE(x);							\
 })
 
 #define __WRITE_ONCE(x, val)						\
@@ -74,12 +66,9 @@ unsigned long __read_once_word_nocheck(const void *addr)
  */
 #define READ_ONCE_NOCHECK(x)						\
 ({									\
-	unsigned long __x;						\
-	compiletime_assert(sizeof(x) == sizeof(__x),			\
+	compiletime_assert(sizeof(x) == sizeof(unsigned long),		\
 		"Unsupported access size for READ_ONCE_NOCHECK().");	\
-	__x = __read_once_word_nocheck(&(x));				\
-	smp_read_barrier_depends();					\
-	(typeof(x))__x;							\
+	(typeof(x))__read_once_word_nocheck(&(x));			\
 })
 
 static __no_kasan_or_inline
-- 
2.27.0.212.ge8ba1cc988-goog
