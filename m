From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 17/26] x86/alternatives: Add patching logic in
 text_poke_site()
Date: Tue,  7 Apr 2020 22:03:14 -0700
Message-ID: <20200408050323.4237-18-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: jgross@suse.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, Ankur Arora <ankur.a.arora@oracle.com>, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, vkuznets@redhat.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Add actual poking and pipeline sync logic in poke_sync(). This is called
from text_poke_site()).

The patching logic is similar to that in text_poke_bp_batch() where we
patch the first byte with an INT3, which serves as a barrier, then patch
the remaining bytes and then come back and fixup the first byte.

The first and the last steps are single byte writes and are thus
atomic, and the second step is protected because the INT3 serves
as a barrier.

Between each of these steps is a global pipeline sync which ensures that
remote pipelines flush out any stale opcodes that they might have cached.
This is driven from poke_sync() where the primary introduces a sync_core()
on secondary CPUs for every PATCH_SYNC_* state change. The corresponding
loop on the secondary executes in text_poke_sync_site().

Note that breakpoints are not handled yet.

 CPU0                                CPUx
 ----                                ----

 patch_worker()                      patch_worker()

   /* Traversal, insn-gen */           text_poke_sync_finish()
   tps.patch_worker()                    /* wait until:
     /* = paravirt_worker() */            *  tps->state == PATCH_DONE
                                          */
                  /* for each patch-site */
     generate_paravirt()
       runtime_patch()
     text_poke_site()                    text_poke_sync_site()
        poke_sync()                       /* for each:
          __text_do_poke()                 *  PATCH_SYNC_[012] */
          sync_one()                       sync_one()
          ack()                            ack()
          wait_for_acks()

           ...                                 ...

  smp_store_release(&tps->state, PATCH_DONE)

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kernel/alternative.c | 103 +++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 1c5acdc4f349..7fdaae9edbf0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1441,27 +1441,57 @@ struct text_poke_state {
 
 static struct text_poke_state text_poke_state;
 
+static void wait_for_acks(struct text_poke_state *tps)
+{
+	int cpu = smp_processor_id();
+
+	cpumask_set_cpu(cpu, &tps->sync_ack_map);
+
+	/* Wait until all CPUs are known to have observed the state change. */
+	while (cpumask_weight(&tps->sync_ack_map) < tps->num_acks)
+		cpu_relax();
+}
+
 /**
- * poke_sync() - transitions to the specified state.
+ * poke_sync() - carries out one poke-step for a single site and
+ * transitions to the specified state.
+ * Called with the target populated in poking_mm and poking_addr.
  *
  * @tps - struct text_poke_state *
  * @state - one of PATCH_SYNC_* states
  * @offset - offset to be patched
  * @insns - insns to write
  * @len - length of insn sequence
+ *
+ * Returns after all CPUs have observed the state change and called
+ * sync_core().
  */
 static void poke_sync(struct text_poke_state *tps, int state, int offset,
 		      const char *insns, int len)
 {
+	if (len)
+		__text_do_poke(offset, insns, len);
 	/*
-	 * STUB: no patching or synchronization, just go through the
-	 * motions.
+	 * Stores to tps.sync_ack_map are ordered with
+	 * smp_load_acquire(tps->state) in text_poke_sync_site()
+	 * so we can safely clear the cpumask.
 	 */
 	smp_store_release(&tps->state, state);
+
+	cpumask_clear(&tps->sync_ack_map);
+
+	/*
+	 * Introduce a synchronizing instruction in local and remote insn
+	 * streams. This flushes any stale cached uops from CPU pipelines.
+	 */
+	sync_one();
+
+	wait_for_acks(tps);
 }
 
 /**
  * text_poke_site() - called on the primary to patch a single call site.
+ * The interlocking sync work on the secondary is done in text_poke_sync_site().
  *
  * Called in thread context with tps->state == PATCH_SYNC_DONE where it
  * takes tps->state through different PATCH_SYNC_* states, returning
@@ -1514,6 +1544,43 @@ static void __maybe_unused text_poke_site(struct text_poke_state *tps,
 			  &prev_mm, ptep);
 }
 
+/**
+ * text_poke_sync_site() -- called to synchronize the CPU pipeline
+ * on secondary CPUs for each patch site.
+ *
+ * Called in thread context with tps->state == PATCH_SYNC_0.
+ *
+ * Returns after having observed tps->state == PATCH_SYNC_DONE.
+ */
+static void text_poke_sync_site(struct text_poke_state *tps)
+{
+	int cpu = smp_processor_id();
+	int prevstate = -1;
+	int acked;
+
+	/*
+	 * In thread context we arrive here expecting tps->state to move
+	 * in-order from PATCH_SYNC_{0 -> 1 -> 2} -> PATCH_SYNC_DONE.
+	 */
+	do {
+		/*
+		 * Wait until there's some work for us to do.
+		 */
+		smp_cond_load_acquire(&tps->state,
+				      prevstate != VAL);
+
+		prevstate = READ_ONCE(tps->state);
+
+		if (prevstate < PATCH_SYNC_DONE) {
+			acked = cpumask_test_cpu(cpu, &tps->sync_ack_map);
+
+			BUG_ON(acked);
+			sync_one();
+			cpumask_set_cpu(cpu, &tps->sync_ack_map);
+		}
+	} while (prevstate < PATCH_SYNC_DONE);
+}
+
 /**
  * text_poke_sync_finish() -- called to synchronize the CPU pipeline
  * on secondary CPUs for all patch sites.
@@ -1525,6 +1592,7 @@ static void text_poke_sync_finish(struct text_poke_state *tps)
 {
 	while (true) {
 		enum patch_state state;
+		int cpu = smp_processor_id();
 
 		state = READ_ONCE(tps->state);
 
@@ -1535,11 +1603,24 @@ static void text_poke_sync_finish(struct text_poke_state *tps)
 		if (state == PATCH_DONE)
 			break;
 
-		/*
-		 * Relax here while the primary makes up its mind on
-		 * whether it is done or not.
-		 */
-		cpu_relax();
+		if (state == PATCH_SYNC_DONE) {
+			/*
+			 * Ack that we've seen the end of this iteration
+			 * and then wait until everybody's ready to move
+			 * to the next iteration or exit.
+			 */
+			cpumask_set_cpu(cpu, &tps->sync_ack_map);
+			smp_cond_load_acquire(&tps->state,
+					      (state != VAL));
+		} else if (state == PATCH_SYNC_0) {
+			/*
+			 * PATCH_SYNC_1, PATCH_SYNC_2 are handled
+			 * inside text_poke_sync_site().
+			 */
+			text_poke_sync_site(tps);
+		} else {
+			BUG();
+		}
 	}
 }
 
@@ -1549,6 +1630,12 @@ static int patch_worker(void *t)
 	struct text_poke_state *tps = t;
 
 	if (cpu == tps->primary_cpu) {
+		/*
+		 * The init state is PATCH_SYNC_DONE. Wait until the
+		 * secondaries have assembled before we start patching.
+		 */
+		wait_for_acks(tps);
+
 		/*
 		 * Generates insns and calls text_poke_site() to do the poking
 		 * and sync.
-- 
2.20.1
