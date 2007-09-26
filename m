From: rusty@rustcorp.com.au
Subject: [patch 18/43] lguest: Remove fixed limit on number of guests,
	and lguests array.
Date: Wed, 26 Sep 2007 16:36:36 +1000
Message-ID: <20070926063648.366603351@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lguest-remove-guestid.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Back when we had all the Guest state in the switcher, we had a fixed
array of them.  This is no longer necessary.

If we switch the network code to using random_ether_addr (46 bits is
enough to avoid clashes), we can get rid of the concept of "guest id"
altogether.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/core.c        |   14 --------------
 drivers/lguest/hypercalls.c  |    4 +---
 drivers/lguest/io.c          |   10 +++++-----
 drivers/lguest/lg.h          |    5 +----
 drivers/lguest/lguest_user.c |   17 ++++++-----------
 drivers/net/lguest_net.c     |    7 +------
 include/linux/lguest.h       |    2 --
 7 files changed, 14 insertions(+), 45 deletions(-)

===================================================================
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -46,10 +46,6 @@ static struct {
 /* This One Big lock protects all inter-guest data structures. */
 DEFINE_MUTEX(lguest_lock);
 static DEFINE_PER_CPU(struct lguest *, last_guest);
-
-/* FIXME: Make dynamic. */
-#define MAX_LGUEST_GUESTS 16
-struct lguest lguests[MAX_LGUEST_GUESTS];
 
 /* Offset from where switcher.S was compiled to where we've copied it */
 static unsigned long switcher_offset(void)
@@ -660,16 +656,6 @@ int run_guest(struct lguest *lg, unsigne
  * deliver_trap() and demand_page().  After all those, we'll be ready to
  * examine the Switcher, and our philosophical understanding of the Host/Guest
  * duality will be complete. :*/
-
-int find_free_guest(void)
-{
-	unsigned int i;
-	for (i = 0; i < MAX_LGUEST_GUESTS; i++)
-		if (!lguests[i].tsk)
-			return i;
-	return -1;
-}
-
 static void adjust_pge(void *on)
 {
 	if (on)
===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -225,9 +225,7 @@ static void initialize(struct lguest *lg
 	    /* We tell the Guest that it can't use the top 4MB of virtual
 	     * addresses used by the Switcher. */
 	    || put_user(4U*1024*1024, &lg->lguest_data->reserve_mem)
-	    || put_user(tsc_speed, &lg->lguest_data->tsc_khz)
-	    /* We also give the Guest a unique id, as used in lguest_net.c. */
-	    || put_user(lg->guestid, &lg->lguest_data->guestid))
+	    || put_user(tsc_speed, &lg->lguest_data->tsc_khz))
 		kill_guest(lg, "bad guest page %p", lg->lguest_data);
 
 	/* We write the current time into the Guest's data page once now. */
===================================================================
--- a/drivers/lguest/io.c
+++ b/drivers/lguest/io.c
@@ -212,7 +212,7 @@ int bind_dma(struct lguest *lg,
 			lg->dma[i].num_dmas = numdmas;
 			lg->dma[i].next_dma = 0;
 			lg->dma[i].key = key;
-			lg->dma[i].guestid = lg->guestid;
+			lg->dma[i].owner = lg;
 			lg->dma[i].interrupt = interrupt;
 
 			/* Now we add it to the hash table: the position
@@ -412,7 +412,7 @@ static int dma_transfer(struct lguest *s
 
 	/* From the "struct lguest_dma_info" we found in the hash, grab the
 	 * Guest. */
-	dstlg = &lguests[dst->guestid];
+	dstlg = dst->owner;
 	/* Read in the source "struct lguest_dma" handed to SEND_DMA. */
 	lgread(srclg, &src_dma, udma, sizeof(src_dma));
 
@@ -506,8 +506,8 @@ again:
 		struct lguest_dma_info *i;
 		/* Look through the hash for other Guests. */
 		list_for_each_entry(i, &dma_hash[hash(&key)], list) {
-			/* Don't send to ourselves. */
-			if (i->guestid == lg->guestid)
+			/* Don't send to ourselves (would deadlock). */
+			if (i->owner->mm == lg->mm)
 				continue;
 			if (!key_eq(&key, &i->key))
 				continue;
@@ -594,7 +594,7 @@ unsigned long get_dma_buffer(struct lgue
 	 * send to its own Guest for the moment, so the entry must be for this
 	 * Guest) */
 	list_for_each_entry(i, &dma_hash[hash(&key)], list) {
-		if (key_eq(&key, &i->key) && i->guestid == lg->guestid) {
+		if (key_eq(&key, &i->key) && i->owner == lg) {
 			unsigned int j;
 			/* Look through the registered DMA array for an
 			 * available buffer. */
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -52,9 +52,9 @@ struct lguest_dma_info
 	struct list_head list;
 	union futex_key key;
 	unsigned long dmas;
+	struct lguest *owner;
 	u16 next_dma;
 	u16 num_dmas;
-	u16 guestid;
 	u8 interrupt; 	/* 0 when not registered */
 };
 
@@ -141,7 +141,6 @@ struct lguest
 	struct lguest_data __user *lguest_data;
 	struct task_struct *tsk;
 	struct mm_struct *mm; 	/* == tsk->mm, but that becomes NULL on exit */
-	u16 guestid;
 	u32 pfn_limit;
 	/* This provides the offset to the base of guest-physical
 	 * memory in the Launcher. */
@@ -196,7 +195,6 @@ struct lguest
 	DECLARE_BITMAP(irqs_pending, LGUEST_IRQS);
 };
 
-extern struct lguest lguests[];
 extern struct mutex lguest_lock;
 
 /* core.c: */
@@ -204,7 +202,6 @@ void lgwrite_u32(struct lguest *lg, unsi
 void lgwrite_u32(struct lguest *lg, unsigned long addr, u32 val);
 void lgread(struct lguest *lg, void *buf, unsigned long addr, unsigned len);
 void lgwrite(struct lguest *lg, unsigned long, const void *buf, unsigned len);
-int find_free_guest(void);
 int lguest_address_ok(const struct lguest *lg,
 		      unsigned long addr, unsigned long len);
 int run_guest(struct lguest *lg, unsigned long __user *user);
===================================================================
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -167,11 +167,11 @@ static int initialize(struct file *file,
 	/* "struct lguest" contains everything we (the Host) know about a
 	 * Guest. */
 	struct lguest *lg;
-	int err, i;
+	int err;
 	u32 args[5];
 
-	/* We grab the Big Lguest lock, which protects the global array
-	 * "lguests" and multiple simultaneous initializations. */
+	/* We grab the Big Lguest lock, which protects against multiple
+	 * simultaneous initializations. */
 	mutex_lock(&lguest_lock);
 	/* You can't initialize twice!  Close the device and start again... */
 	if (file->private_data) {
@@ -184,18 +184,13 @@ static int initialize(struct file *file,
 		goto unlock;
 	}
 
-	/* Find an unused guest. */
-	i = find_free_guest();
-	if (i < 0) {
-		err = -ENOSPC;
+	lg = kzalloc(sizeof(*lg), GFP_KERNEL);
+	if (!lg) {
+		err = -ENOMEM;
 		goto unlock;
 	}
-	/* OK, we have an index into the "lguest" array: "lg" is a convenient
-	 * pointer. */
-	lg = &lguests[i];
 
 	/* Populate the easy fields of our "struct lguest" */
-	lg->guestid = i;
 	lg->mem_base = (void __user *)(long)args[0];
 	lg->pfn_limit = args[1];
 	lg->page_offset = args[4];
===================================================================
--- a/drivers/net/lguest_net.c
+++ b/drivers/net/lguest_net.c
@@ -465,12 +465,7 @@ static int lguestnet_probe(struct lguest
 	/* Ethernet defaults with some changes */
 	ether_setup(dev);
 	dev->set_mac_address = NULL;
-
-	dev->dev_addr[0] = 0x02; /* set local assignment bit (IEEE802) */
-	dev->dev_addr[1] = 0x00;
-	memcpy(&dev->dev_addr[2], &lguest_data.guestid, 2);
-	dev->dev_addr[4] = 0x00;
-	dev->dev_addr[5] = 0x00;
+	random_ether_addr(dev->dev_addr);
 
 	dev->open = lguestnet_open;
 	dev->stop = lguestnet_close;
===================================================================
--- a/include/linux/lguest.h
+++ b/include/linux/lguest.h
@@ -41,8 +41,6 @@ struct lguest_data
 /* Fields initialized by the Host at boot: */
 	/* Memory not to try to access */
 	unsigned long reserve_mem;
-	/* ID of this Guest (used by network driver to set ethernet address) */
-	u16 guestid;
 	/* KHz for the TSC clock. */
 	u32 tsc_khz;
 

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
