From: Will Deacon <will@kernel.org>
Subject: [PATCH 12/18] include/linux: Remove smp_read_barrier_depends() from comments
Date: Tue, 30 Jun 2020 18:37:28 +0100
Message-ID: <20200630173734.14057-13-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.orgv
List-Id: virtualization@lists.linuxfoundation.org

smp_read_barrier_depends() doesn't exist any more, so reword the two
comments that mention it to refer to "dependency ordering" instead.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/percpu-refcount.h | 2 +-
 include/linux/ptr_ring.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 22d9d183950d..87d8a38bdea1 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -155,7 +155,7 @@ static inline bool __ref_is_percpu(struct percpu_ref *ref,
 	 * between contaminating the pointer value, meaning that
 	 * READ_ONCE() is required when fetching it.
 	 *
-	 * The smp_read_barrier_depends() implied by READ_ONCE() pairs
+	 * The dependency ordering from the READ_ONCE() pairs
 	 * with smp_store_release() in __percpu_ref_switch_to_percpu().
 	 */
 	percpu_ptr = READ_ONCE(ref->percpu_count_ptr);
diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 417db0a79a62..808f9d3ee546 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -107,7 +107,7 @@ static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 		return -ENOSPC;
 
 	/* Make sure the pointer we are storing points to a valid data. */
-	/* Pairs with smp_read_barrier_depends in __ptr_ring_consume. */
+	/* Pairs with the dependency ordering in __ptr_ring_consume. */
 	smp_wmb();
 
 	WRITE_ONCE(r->queue[r->producer++], ptr);
-- 
2.27.0.212.ge8ba1cc988-goog
