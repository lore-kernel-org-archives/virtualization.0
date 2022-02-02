Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A6AC4332F
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 15:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23F5C60FE5;
	Wed,  2 Feb 2022 15:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jSaekT0bDmYY; Wed,  2 Feb 2022 15:57:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B575C60BE7;
	Wed,  2 Feb 2022 15:57:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E95AFC007A;
	Wed,  2 Feb 2022 15:57:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCB4AC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 15:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCB4984031
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 15:57:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eAgAOWBtCXPs
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 15:57:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EF0384030
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Ilg8MRKs3UhBiK+Mujp47+wrzj58nCf6OMRjMHqSUG8=; b=coDr4KSuLs8ezx3zbeJqGdmT7Y
 ZsNh2LmqvJHDlPT5mWZ46elIaHGQIx9J6ZDVXIWjGTX8piz2E7djDCyhIgKtW7Uq0ddX7i5Oeqg9p
 zPUe3fJ8dSpr5vB2StrFy47e1rm1CCFlTEmWtibQXYDtwhvSOdzPLxyki7JewGJqIiBNYNmzJmxv9
 fh8dCYXVGjseMJJMSKAgcm9trGmNHxtxmE21iQzCXc2jq780jpD8ASZCiawihlAe2PKZ62ZiXMejA
 7v78wKSwGHoz68lxXr7CTfQSzJtIzH69ANkiuzqf9RsglpMUjYaglBKANUrKqpjcOjOQ7FyqQA2kr
 SJ+67DdQ==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFI0N-00G6YZ-CA; Wed, 02 Feb 2022 15:57:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] memstick/ms_block: simplify refcounting
Date: Wed,  2 Feb 2022 16:56:57 +0100
Message-Id: <20220202155659.107895-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202155659.107895-1-hch@lst.de>
References: <20220202155659.107895-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-mmc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Implement the ->free_disk method to free the msb_data structure only once
the last gendisk reference goes away instead of keeping a local refcount.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/memstick/core/ms_block.c | 64 ++++++++------------------------
 drivers/memstick/core/ms_block.h |  1 -
 2 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 0cda6c6baefc3..3993bdd4b519c 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1943,22 +1943,6 @@ static void msb_io_work(struct work_struct *work)
 static DEFINE_IDR(msb_disk_idr); /*set of used disk numbers */
 static DEFINE_MUTEX(msb_disk_lock); /* protects against races in open/release */
 
-static int msb_bd_open(struct block_device *bdev, fmode_t mode)
-{
-	struct gendisk *disk = bdev->bd_disk;
-	struct msb_data *msb = disk->private_data;
-
-	dbg_verbose("block device open");
-
-	mutex_lock(&msb_disk_lock);
-
-	if (msb && msb->card)
-		msb->usage_count++;
-
-	mutex_unlock(&msb_disk_lock);
-	return 0;
-}
-
 static void msb_data_clear(struct msb_data *msb)
 {
 	kfree(msb->boot_page);
@@ -1968,33 +1952,6 @@ static void msb_data_clear(struct msb_data *msb)
 	msb->card = NULL;
 }
 
-static int msb_disk_release(struct gendisk *disk)
-{
-	struct msb_data *msb = disk->private_data;
-
-	dbg_verbose("block device release");
-	mutex_lock(&msb_disk_lock);
-
-	if (msb) {
-		if (msb->usage_count)
-			msb->usage_count--;
-
-		if (!msb->usage_count) {
-			disk->private_data = NULL;
-			idr_remove(&msb_disk_idr, msb->disk_id);
-			put_disk(disk);
-			kfree(msb);
-		}
-	}
-	mutex_unlock(&msb_disk_lock);
-	return 0;
-}
-
-static void msb_bd_release(struct gendisk *disk, fmode_t mode)
-{
-	msb_disk_release(disk);
-}
-
 static int msb_bd_getgeo(struct block_device *bdev,
 				 struct hd_geometry *geo)
 {
@@ -2003,6 +1960,17 @@ static int msb_bd_getgeo(struct block_device *bdev,
 	return 0;
 }
 
+static void msb_bd_free_disk(struct gendisk *disk)
+{
+	struct msb_data *msb = disk->private_data;
+
+	mutex_lock(&msb_disk_lock);
+	idr_remove(&msb_disk_idr, msb->disk_id);
+	mutex_unlock(&msb_disk_lock);
+
+	kfree(msb);
+}
+
 static blk_status_t msb_queue_rq(struct blk_mq_hw_ctx *hctx,
 				 const struct blk_mq_queue_data *bd)
 {
@@ -2096,10 +2064,9 @@ static void msb_start(struct memstick_dev *card)
 }
 
 static const struct block_device_operations msb_bdops = {
-	.open    = msb_bd_open,
-	.release = msb_bd_release,
-	.getgeo  = msb_bd_getgeo,
-	.owner   = THIS_MODULE
+	.owner		= THIS_MODULE,
+	.getgeo		= msb_bd_getgeo,
+	.free_disk	= msb_bd_free_disk, 
 };
 
 static const struct blk_mq_ops msb_mq_ops = {
@@ -2147,7 +2114,6 @@ static int msb_init_disk(struct memstick_dev *card)
 	set_capacity(msb->disk, capacity);
 	dbg("Set total disk size to %lu sectors", capacity);
 
-	msb->usage_count = 1;
 	msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
 	INIT_WORK(&msb->io_work, msb_io_work);
 	sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
@@ -2229,7 +2195,7 @@ static void msb_remove(struct memstick_dev *card)
 	msb_data_clear(msb);
 	mutex_unlock(&msb_disk_lock);
 
-	msb_disk_release(msb->disk);
+	put_disk(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }
 
diff --git a/drivers/memstick/core/ms_block.h b/drivers/memstick/core/ms_block.h
index 122e1a8a8bd5b..7058f9aefeb92 100644
--- a/drivers/memstick/core/ms_block.h
+++ b/drivers/memstick/core/ms_block.h
@@ -143,7 +143,6 @@ struct ms_boot_page {
 } __packed;
 
 struct msb_data {
-	unsigned int			usage_count;
 	struct memstick_dev		*card;
 	struct gendisk			*disk;
 	struct request_queue		*queue;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
