Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6969FC433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:56:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA1365242
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA1365242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5813430AE;
	Tue,  9 Mar 2021 15:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EygcYMlbUexh; Tue,  9 Mar 2021 15:56:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 55CFC430DD;
	Tue,  9 Mar 2021 15:56:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26349C000B;
	Tue,  9 Mar 2021 15:56:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD8EC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DFC9430E4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cqXX3KfFhBaF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:56:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77E99430DD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=YCa5USJ2jm70Z2UsFo8WsaOurKZNnFvLpmzM+RUjH7Q=; b=tOG8dHR47ixjkPXc3KpuPHwBJN
 9VFDsIBs0iNabrNwVXnkHpEUdRE0Xw1VihxeUy1+Fk4KYBtVgcEksHwzR18mV15ZWijtKj5WiAj/5
 7KOcX17CSbvl+aU8mkaAl7PIwJV8dwwIDpxTeRudfOZASKqLd2oSxE8ndV2Mhje3p8opZFyB+5AY6
 3WCbnTsjVJ3yqS6hJgSLnrgXWlagzm2/jm1eIMY/fHzgbKF2asFhyKisFuX10Qwx8gBqZ5of7CTH3
 ZHAvbig1z/NdDSn0Hj3VaXLltwy6s7eRmlDs/uoLyCyDcM4moI+4Km8Zi3CtzTIP32H3qV1JoiGlq
 YC8O2rHA==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lJehF-000lP8-0R; Tue, 09 Mar 2021 15:55:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6/9] virtio_balloon: remove the balloon-kvm file system
Date: Tue,  9 Mar 2021 16:53:45 +0100
Message-Id: <20210309155348.974875-7-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309155348.974875-1-hch@lst.de>
References: <20210309155348.974875-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jason Gunthorpe <jgg@nvidia.com>, "VMware, Inc." <pv-drivers@vmware.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
 Nadav Amit <namit@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Nitin Gupta <ngupta@vflare.org>
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

Just use the generic anon_inode file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_balloon.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index cae76ee5bdd688..1efb890cd3ff09 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -6,6 +6,7 @@
  *  Copyright 2008 Rusty Russell IBM Corporation
  */
 
+#include <linux/anon_inodes.h>
 #include <linux/virtio.h>
 #include <linux/virtio_balloon.h>
 #include <linux/swap.h>
@@ -42,10 +43,6 @@
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
 #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
 
-#ifdef CONFIG_BALLOON_COMPACTION
-static struct vfsmount *balloon_mnt;
-#endif
-
 enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_INFLATE,
 	VIRTIO_BALLOON_VQ_DEFLATE,
@@ -805,18 +802,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 
 	return MIGRATEPAGE_SUCCESS;
 }
-
-static int balloon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, BALLOON_KVM_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type balloon_fs = {
-	.name           = "balloon-kvm",
-	.init_fs_context = balloon_init_fs_context,
-	.kill_sb        = kill_anon_super,
-};
-
 #endif /* CONFIG_BALLOON_COMPACTION */
 
 static unsigned long shrink_free_pages(struct virtio_balloon *vb,
@@ -909,17 +894,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		goto out_free_vb;
 
 #ifdef CONFIG_BALLOON_COMPACTION
-	balloon_mnt = kern_mount(&balloon_fs);
-	if (IS_ERR(balloon_mnt)) {
-		err = PTR_ERR(balloon_mnt);
-		goto out_del_vqs;
-	}
-
 	vb->vb_dev_info.migratepage = virtballoon_migratepage;
-	vb->vb_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
+	vb->vb_dev_info.inode = alloc_anon_inode();
 	if (IS_ERR(vb->vb_dev_info.inode)) {
 		err = PTR_ERR(vb->vb_dev_info.inode);
-		goto out_kern_unmount;
+		goto out_del_vqs;
 	}
 	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
 #endif
@@ -1016,8 +995,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 out_iput:
 #ifdef CONFIG_BALLOON_COMPACTION
 	iput(vb->vb_dev_info.inode);
-out_kern_unmount:
-	kern_unmount(balloon_mnt);
 out_del_vqs:
 #endif
 	vdev->config->del_vqs(vdev);
@@ -1070,7 +1047,6 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	if (vb->vb_dev_info.inode)
 		iput(vb->vb_dev_info.inode);
 
-	kern_unmount(balloon_mnt);
 #endif
 	kfree(vb);
 }
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
