From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 6/6] lguest: block driver tidyups
Date: Tue, 15 May 2007 11:28:11 +1000
Message-ID: <1179192491.27304.2.camel__6556.72022044218$1179192613$gmane$org@localhost.localdomain>
References: <1179191827.10836.24.camel@localhost.localdomain>
	<1179191888.10836.26.camel@localhost.localdomain>
	<1179191979.10836.29.camel@localhost.localdomain>
	<1179192035.10836.32.camel@localhost.localdomain>
	<1179192098.10836.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1179192098.10836.35.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

1) Use new dma wrapper functions, and handle bind failure (may happen
   in future)
2) Use new lgdev_irq() "get me a good interrupt number" function.
3) Use new lguest_map()/lguest_unmap() instead of ioremap/iounmap.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/block/lguest_blk.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

===================================================================
--- a/drivers/block/lguest_blk.c
+++ b/drivers/block/lguest_blk.c
@@ -37,7 +37,7 @@ struct blockdev
 	int irq;
 
 	unsigned long phys_addr;
-	/* The ioremap'ed block page. */
+	/* The mapped block page. */
 	struct lguest_block_page *lb_page;
 
 	/* We only have a single request outstanding at a time. */
@@ -123,7 +123,7 @@ static void do_write(struct blockdev *bd
 	pr_debug("lgb: WRITE sector %li\n", (long)req->sector);
 	setup_req(bd, 1, req, &send);
 
-	hcall(LHCALL_SEND_DMA, bd->phys_addr, __pa(&send), 0);
+	lguest_send_dma(bd->phys_addr, &send);
 }
 
 static void do_read(struct blockdev *bd, struct request *req)
@@ -134,7 +134,7 @@ static void do_read(struct blockdev *bd,
 	setup_req(bd, 0, req, &bd->dma);
 
 	empty_dma(&ping);
-	hcall(LHCALL_SEND_DMA, bd->phys_addr, __pa(&ping), 0);
+	lguest_send_dma(bd->phys_addr, &ping);
 }
 
 static void do_lgb_request(request_queue_t *q)
@@ -183,13 +183,13 @@ static int lguestblk_probe(struct lguest
 		return -ENOMEM;
 
 	spin_lock_init(&bd->lock);
-	bd->irq = lgdev->index+1;
+	bd->irq = lgdev_irq(lgdev);
 	bd->req = NULL;
 	bd->dma.used_len = 0;
 	bd->dma.len[0] = 0;
 	bd->phys_addr = (lguest_devices[lgdev->index].pfn << PAGE_SHIFT);
 
-	bd->lb_page = (void *)ioremap(bd->phys_addr, PAGE_SIZE);
+	bd->lb_page = lguest_map(bd->phys_addr, 1);
 	if (!bd->lb_page) {
 		err = -ENOMEM;
 		goto out_free_bd;
@@ -225,7 +225,9 @@ static int lguestblk_probe(struct lguest
 	if (err)
 		goto out_cleanup_queue;
 
-	hcall(LHCALL_BIND_DMA, bd->phys_addr, __pa(&bd->dma), (1<<8)+bd->irq);
+	err = lguest_bind_dma(bd->phys_addr, &bd->dma, 1, bd->irq);
+	if (err)
+		goto out_free_irq;
 
 	bd->disk->major = bd->major;
 	bd->disk->first_minor = 0;
@@ -241,6 +243,8 @@ static int lguestblk_probe(struct lguest
 	lgdev->private = bd;
 	return 0;
 
+out_free_irq:
+	free_irq(bd->irq, bd);
 out_cleanup_queue:
 	blk_cleanup_queue(bd->disk->queue);
 out_put_disk:
@@ -248,7 +252,7 @@ out_unregister_blkdev:
 out_unregister_blkdev:
 	unregister_blkdev(bd->major, "lguestblk");
 out_unmap:
-	iounmap(bd->lb_page);
+	lguest_unmap(bd->lb_page);
 out_free_bd:
 	kfree(bd);
 	return err;
