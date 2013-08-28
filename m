From: Kent Overstreet <kmo@daterainc.com>
Subject: [PATCH] percpu ida: Switch to cpumask_t, add some comments
Date: Wed, 28 Aug 2013 12:55:17 -0700
Message-ID: <20130828195517.GF8032@kmo-pixel>
References: <1376694549-20609-1-git-send-email-nab@linux-iscsi.org>
	<1376694549-20609-2-git-send-email-nab@linux-iscsi.org>
	<20130820143157.f91bf59d16352989b54e431e@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130820143157.f91bf59d16352989b54e431e@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andi Kleen <andi@firstfloor.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, lkml <linux-kernel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Christoph Lameter <cl@gentwo.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Fixup patch, addressing Andrew's review feedback:

Signed-off-by: Kent Overstreet <kmo@daterainc.com>
---
 include/linux/idr.h |  2 +-
 lib/idr.c           | 38 +++++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index f0db12b..cdf39be 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -267,7 +267,7 @@ struct percpu_ida {
 	 * will just keep looking - but the bitmap _must_ be set whenever a
 	 * percpu freelist does have tags.
 	 */
-	unsigned long			*cpus_have_tags;
+	cpumask_t			cpus_have_tags;
 
 	struct {
 		spinlock_t		lock;
diff --git a/lib/idr.c b/lib/idr.c
index 26495e1..15c021c 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -1178,7 +1178,13 @@ EXPORT_SYMBOL(ida_init);
 #define IDA_PCPU_SIZE		((IDA_PCPU_BATCH_MOVE * 3) / 2)
 
 struct percpu_ida_cpu {
+	/*
+	 * Even though this is percpu, we need a lock for tag stealing by remote
+	 * CPUs:
+	 */
 	spinlock_t			lock;
+
+	/* nr_free/freelist form a stack of free IDs */
 	unsigned			nr_free;
 	unsigned			freelist[];
 };
@@ -1209,21 +1215,21 @@ static inline void steal_tags(struct percpu_ida *pool,
 	unsigned cpus_have_tags, cpu = pool->cpu_last_stolen;
 	struct percpu_ida_cpu *remote;
 
-	for (cpus_have_tags = bitmap_weight(pool->cpus_have_tags, nr_cpu_ids);
+	for (cpus_have_tags = cpumask_weight(&pool->cpus_have_tags);
 	     cpus_have_tags * IDA_PCPU_SIZE > pool->nr_tags / 2;
 	     cpus_have_tags--) {
-		cpu = find_next_bit(pool->cpus_have_tags, nr_cpu_ids, cpu);
+		cpu = cpumask_next(cpu, &pool->cpus_have_tags);
 
-		if (cpu == nr_cpu_ids)
-			cpu = find_first_bit(pool->cpus_have_tags, nr_cpu_ids);
+		if (cpu >= nr_cpu_ids)
+			cpu = cpumask_first(&pool->cpus_have_tags);
 
-		if (cpu == nr_cpu_ids)
+		if (cpu >= nr_cpu_ids)
 			BUG();
 
 		pool->cpu_last_stolen = cpu;
 		remote = per_cpu_ptr(pool->tag_cpu, cpu);
 
-		clear_bit(cpu, pool->cpus_have_tags);
+		cpumask_clear_cpu(cpu, &pool->cpus_have_tags);
 
 		if (remote == tags)
 			continue;
@@ -1246,6 +1252,10 @@ static inline void steal_tags(struct percpu_ida *pool,
 	}
 }
 
+/*
+ * Pop up to IDA_PCPU_BATCH_MOVE IDs off the global freelist, and push them onto
+ * our percpu freelist:
+ */
 static inline void alloc_global_tags(struct percpu_ida *pool,
 				     struct percpu_ida_cpu *tags)
 {
@@ -1317,8 +1327,8 @@ int percpu_ida_alloc(struct percpu_ida *pool, gfp_t gfp)
 		if (tags->nr_free) {
 			tag = tags->freelist[--tags->nr_free];
 			if (tags->nr_free)
-				set_bit(smp_processor_id(),
-					pool->cpus_have_tags);
+				cpumask_set_cpu(smp_processor_id(),
+						&pool->cpus_have_tags);
 		}
 
 		spin_unlock(&pool->lock);
@@ -1363,8 +1373,8 @@ void percpu_ida_free(struct percpu_ida *pool, unsigned tag)
 	spin_unlock(&tags->lock);
 
 	if (nr_free == 1) {
-		set_bit(smp_processor_id(),
-			pool->cpus_have_tags);
+		cpumask_set_cpu(smp_processor_id(),
+				&pool->cpus_have_tags);
 		wake_up(&pool->wait);
 	}
 
@@ -1398,7 +1408,6 @@ EXPORT_SYMBOL_GPL(percpu_ida_free);
 void percpu_ida_destroy(struct percpu_ida *pool)
 {
 	free_percpu(pool->tag_cpu);
-	kfree(pool->cpus_have_tags);
 	free_pages((unsigned long) pool->freelist,
 		   get_order(pool->nr_tags * sizeof(unsigned)));
 }
@@ -1428,7 +1437,7 @@ int percpu_ida_init(struct percpu_ida *pool, unsigned long nr_tags)
 
 	/* Guard against overflow */
 	if (nr_tags > (unsigned) INT_MAX + 1) {
-		pr_err("tags.c: nr_tags too large\n");
+		pr_err("percpu_ida_init(): nr_tags too large\n");
 		return -EINVAL;
 	}
 
@@ -1442,11 +1451,6 @@ int percpu_ida_init(struct percpu_ida *pool, unsigned long nr_tags)
 
 	pool->nr_free = nr_tags;
 
-	pool->cpus_have_tags = kzalloc(BITS_TO_LONGS(nr_cpu_ids) *
-				       sizeof(unsigned long), GFP_KERNEL);
-	if (!pool->cpus_have_tags)
-		goto err;
-
 	pool->tag_cpu = __alloc_percpu(sizeof(struct percpu_ida_cpu) +
 				       IDA_PCPU_SIZE * sizeof(unsigned),
 				       sizeof(unsigned));
-- 
1.8.4.rc3
