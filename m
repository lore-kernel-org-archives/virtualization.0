From: Will Deacon <will@kernel.org>
Subject: [PATCH 03/18] asm/rwonce: Allow __READ_ONCE to be overridden by the architecture
Date: Tue, 30 Jun 2020 18:37:19 +0100
Message-ID: <20200630173734.14057-4-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.orgv
List-Id: virtualization@lists.linuxfoundation.org

The meat and potatoes of READ_ONCE() is defined by the __READ_ONCE()
macro, which uses a volatile casts in an attempt to avoid tearing of
byte, halfword, word and double-word accesses. Allow this to be
overridden by the architecture code in the case that things like memory
barriers are also required.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/rwonce.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 92cc2f223cb3..f9dfa88fc04d 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -33,7 +33,9 @@
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
+#ifndef __READ_ONCE
 #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
+#endif
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
-- 
2.27.0.212.ge8ba1cc988-goog
