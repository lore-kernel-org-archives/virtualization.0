From: Will Deacon <will@kernel.org>
Subject: [PATCH v3 18/19] arm64: alternatives: Remove READ_ONCE() usage during patch operation
Date: Fri, 10 Jul 2020 17:52:02 +0100
Message-ID: <20200710165203.31284-19-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, virtualizati
List-Id: virtualization@lists.linuxfoundation.org

In preparation for patching the internals of READ_ONCE() itself, replace
its usage on the alternatives patching patch with a volatile variable
instead.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/alternative.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index d1757ef1b1e7..87bca8d44084 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -21,7 +21,8 @@
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
-static int all_alternatives_applied;
+/* Volatile, as we may be patching the guts of READ_ONCE() */
+static volatile int all_alternatives_applied;
 
 static DECLARE_BITMAP(applied_alternatives, ARM64_NCAPS);
 
@@ -217,7 +218,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 
 	/* We always have a CPU 0 at this point (__init) */
 	if (smp_processor_id()) {
-		while (!READ_ONCE(all_alternatives_applied))
+		while (!all_alternatives_applied)
 			cpu_relax();
 		isb();
 	} else {
@@ -229,7 +230,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 		BUG_ON(all_alternatives_applied);
 		__apply_alternatives(&region, false, remaining_capabilities);
 		/* Barriers provided by the cache flushing */
-		WRITE_ONCE(all_alternatives_applied, 1);
+		all_alternatives_applied = 1;
 	}
 
 	return 0;
-- 
2.27.0.383.g050319c2ae-goog
