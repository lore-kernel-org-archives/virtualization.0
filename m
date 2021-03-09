Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6A3C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:55:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900E365253
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900E365253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A408430BC;
	Tue,  9 Mar 2021 15:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R2_eBXYZhj56; Tue,  9 Mar 2021 15:55:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id BDAD940192;
	Tue,  9 Mar 2021 15:55:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 916AEC000B;
	Tue,  9 Mar 2021 15:55:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D7E9C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EB694BF7C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b33DawJGVX4P
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 903E94BEF2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=B2QcStvhg9D54BxwbuG4jJNpXPybnK2FqQydroBhB+g=; b=oEJ8ugE1x4j/2X9l3CQfTDXGMS
 Q/n8jpu9Ywp7imVSmXif75d7xXHeM2tpMwxW924TC0hKzyzBN3JCiriBDAgPrtO08TnExSGXkYom5
 7IbMPTnUuWT0+4FIiqi7z5LJmACctZ8ew34Oddm3TWS2SIrzIvkQ2W0M5x3gWrrLvJ6qGpXUZGoOZ
 DlpO6fH34pmRLyy8a4XCFgrzNs5TMW9rbySvmlrus7F/24wWk6Mj2OPm6RbyqI73AJJjBOpDqNtte
 j+piA+rYwRzXkiyu0lStNu6yIiQ3gMwi00aj7zbkeQUeYd19n7y+DMkqw+8Akrri9KEMJ3DD2bIJZ
 /NW9ZR2g==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lJegw-000lNb-Ow; Tue, 09 Mar 2021 15:54:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/9] drm: remove the drm file system
Date: Tue,  9 Mar 2021 16:53:43 +0100
Message-Id: <20210309155348.974875-5-hch@lst.de>
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
 drivers/gpu/drm/drm_drv.c | 64 ++-------------------------------------
 1 file changed, 3 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 87e7214a8e3565..af293d76f979e5 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -26,6 +26,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/module.h>
@@ -475,65 +476,6 @@ void drm_dev_unplug(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_dev_unplug);
 
-/*
- * DRM internal mount
- * We want to be able to allocate our own "struct address_space" to control
- * memory-mappings in VRAM (or stolen RAM, ...). However, core MM does not allow
- * stand-alone address_space objects, so we need an underlying inode. As there
- * is no way to allocate an independent inode easily, we need a fake internal
- * VFS mount-point.
- *
- * The drm_fs_inode_new() function allocates a new inode, drm_fs_inode_free()
- * frees it again. You are allowed to use iget() and iput() to get references to
- * the inode. But each drm_fs_inode_new() call must be paired with exactly one
- * drm_fs_inode_free() call (which does not have to be the last iput()).
- * We use drm_fs_inode_*() to manage our internal VFS mount-point and share it
- * between multiple inode-users. You could, technically, call
- * iget() + drm_fs_inode_free() directly after alloc and sometime later do an
- * iput(), but this way you'd end up with a new vfsmount for each inode.
- */
-
-static int drm_fs_cnt;
-static struct vfsmount *drm_fs_mnt;
-
-static int drm_fs_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, 0x010203ff) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type drm_fs_type = {
-	.name		= "drm",
-	.owner		= THIS_MODULE,
-	.init_fs_context = drm_fs_init_fs_context,
-	.kill_sb	= kill_anon_super,
-};
-
-static struct inode *drm_fs_inode_new(void)
-{
-	struct inode *inode;
-	int r;
-
-	r = simple_pin_fs(&drm_fs_type, &drm_fs_mnt, &drm_fs_cnt);
-	if (r < 0) {
-		DRM_ERROR("Cannot mount pseudo fs: %d\n", r);
-		return ERR_PTR(r);
-	}
-
-	inode = alloc_anon_inode_sb(drm_fs_mnt->mnt_sb);
-	if (IS_ERR(inode))
-		simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
-
-	return inode;
-}
-
-static void drm_fs_inode_free(struct inode *inode)
-{
-	if (inode) {
-		iput(inode);
-		simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
-	}
-}
-
 /**
  * DOC: component helper usage recommendations
  *
@@ -563,7 +505,7 @@ static void drm_dev_init_release(struct drm_device *dev, void *res)
 {
 	drm_legacy_ctxbitmap_cleanup(dev);
 	drm_legacy_remove_map_hash(dev);
-	drm_fs_inode_free(dev->anon_inode);
+	iput(dev->anon_inode);
 
 	put_device(dev->dev);
 	/* Prevent use-after-free in drm_managed_release when debugging is
@@ -616,7 +558,7 @@ static int drm_dev_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	dev->anon_inode = drm_fs_inode_new();
+	dev->anon_inode = alloc_anon_inode();
 	if (IS_ERR(dev->anon_inode)) {
 		ret = PTR_ERR(dev->anon_inode);
 		DRM_ERROR("Cannot allocate anonymous inode: %d\n", ret);
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
