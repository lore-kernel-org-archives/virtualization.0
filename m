Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA527C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 08:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DB9B415B9;
	Wed,  9 Feb 2022 08:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1WCV0YeYi6rF; Wed,  9 Feb 2022 08:21:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3816E415B0;
	Wed,  9 Feb 2022 08:21:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F13BC0011;
	Wed,  9 Feb 2022 08:21:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01565C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 08:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E51D8415B6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 08:21:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RW_72UeTf5wz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 08:21:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45513415B8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 08:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=F2lIZdBncpE9NDo/cYhvW0BcY5k8p1Xy0zkeny0OuCE=; b=pm8/6EA1MklZpU91ac7ttgR1yv
 iAfCmchEDh+O3/gwYXKpLpPMsl2q/V6G+Df+WJKA72rIpcKNiR7t4M3DBX99tiPC1A94F/OQAIzfj
 ii6UisZBqnzWVLpgzoxAKknFdJEbj03W3INLbruwZ6VCzLlUElFxG05UNQy4Ys2ycsStkDggzrlku
 /nFPUvV86l1axSa4JUkZ3yh/GKtKF5UXVjk4KEI8gIGzK0efZ7z6zg/Pmv8QRUYSWNekmU02F5mp1
 K77f4vMG0I8emFqrR+tkvwQLzn12m7XsvUCYeOVEbzld+txku58ng5tOj5TOwlV10qa8uiAzUIvZ9
 dHhpmhhQ==;
Received: from [2001:4bb8:188:3efc:ea2:7599:7eeb:4b5a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHiEM-00GbCA-Cj; Wed, 09 Feb 2022 08:21:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] virtio_blk: simplify refcounting
Date: Wed,  9 Feb 2022 09:21:20 +0100
Message-Id: <20220209082121.2628452-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209082121.2628452-1-hch@lst.de>
References: <20220209082121.2628452-1-hch@lst.de>
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

Implement the ->free_disk method to free the virtio_blk structure only
once the last gendisk reference goes away instead of keeping a local
refcount.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 74 +++++++++++---------------------------
 1 file changed, 21 insertions(+), 53 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c443cd64fc9b4..05cc5451d6cc1 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -69,13 +69,6 @@ struct virtio_blk {
 	/* Process context for config space updates */
 	struct work_struct config_work;
 
-	/*
-	 * Tracks references from block_device_operations open/release and
-	 * virtio_driver probe/remove so this object can be freed once no
-	 * longer in use.
-	 */
-	refcount_t refs;
-
 	/* What host tells us, plus 2 for header & tailer. */
 	unsigned int sg_elems;
 
@@ -391,43 +384,6 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	return err;
 }
 
-static void virtblk_get(struct virtio_blk *vblk)
-{
-	refcount_inc(&vblk->refs);
-}
-
-static void virtblk_put(struct virtio_blk *vblk)
-{
-	if (refcount_dec_and_test(&vblk->refs)) {
-		ida_simple_remove(&vd_index_ida, vblk->index);
-		mutex_destroy(&vblk->vdev_mutex);
-		kfree(vblk);
-	}
-}
-
-static int virtblk_open(struct block_device *bd, fmode_t mode)
-{
-	struct virtio_blk *vblk = bd->bd_disk->private_data;
-	int ret = 0;
-
-	mutex_lock(&vblk->vdev_mutex);
-
-	if (vblk->vdev)
-		virtblk_get(vblk);
-	else
-		ret = -ENXIO;
-
-	mutex_unlock(&vblk->vdev_mutex);
-	return ret;
-}
-
-static void virtblk_release(struct gendisk *disk, fmode_t mode)
-{
-	struct virtio_blk *vblk = disk->private_data;
-
-	virtblk_put(vblk);
-}
-
 /* We provide getgeo only to please some old bootloader/partitioning tools */
 static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 {
@@ -460,11 +416,19 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 	return ret;
 }
 
+static void virtblk_free_disk(struct gendisk *disk)
+{
+	struct virtio_blk *vblk = disk->private_data;
+
+	ida_simple_remove(&vd_index_ida, vblk->index);
+	mutex_destroy(&vblk->vdev_mutex);
+	kfree(vblk);
+}
+
 static const struct block_device_operations virtblk_fops = {
-	.owner  = THIS_MODULE,
-	.open = virtblk_open,
-	.release = virtblk_release,
-	.getgeo = virtblk_getgeo,
+	.owner  	= THIS_MODULE,
+	.getgeo		= virtblk_getgeo,
+	.free_disk	= virtblk_free_disk,
 };
 
 static int index_to_minor(int index)
@@ -791,8 +755,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 		goto out_free_index;
 	}
 
-	/* This reference is dropped in virtblk_remove(). */
-	refcount_set(&vblk->refs, 1);
 	mutex_init(&vblk->vdev_mutex);
 
 	vblk->vdev = vdev;
@@ -948,7 +910,13 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return 0;
 
 out_cleanup_disk:
-	blk_cleanup_disk(vblk->disk);
+	blk_cleanup_queue(vblk->disk->queue);
+	blk_mq_free_tag_set(&vblk->tag_set);
+	vdev->config->del_vqs(vdev);
+	kfree(vblk->vqs);
+	put_disk(vblk->disk);
+	return err;
+
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
 out_free_vq:
@@ -970,7 +938,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	flush_work(&vblk->config_work);
 
 	del_gendisk(vblk->disk);
-	blk_cleanup_disk(vblk->disk);
+	blk_cleanup_queue(vblk->disk->queue);
 	blk_mq_free_tag_set(&vblk->tag_set);
 
 	mutex_lock(&vblk->vdev_mutex);
@@ -986,7 +954,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 
 	mutex_unlock(&vblk->vdev_mutex);
 
-	virtblk_put(vblk);
+	put_disk(vblk->disk);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
