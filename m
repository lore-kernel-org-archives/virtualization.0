Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E684C433EF
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 10:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28D2460A75;
	Mon, 29 Nov 2021 10:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fX-9g0Y2xH7C; Mon, 29 Nov 2021 10:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B9A8160A4A;
	Mon, 29 Nov 2021 10:22:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9553BC001C;
	Mon, 29 Nov 2021 10:22:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15839C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E46F241C58
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSPMT-W32di8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F03BF41C47
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=UzM2aDm5k5Eta2DOSpSuHfxbm4uuoJ6QqXw1zIIoRh4=; b=drU9GpyfSBm9H9q/7a4l7/gD5G
 gSzUnv68ETQBcRYwjV+7JZGAfgwSpByoDkmm+kG8QbwE4eaMJAfVeKwX55J1H5xMGuM9uKhKB17tr
 0mRsBuhrl6AZng/bFhKCKcRxwchBNAa4pgAk6GEyNYtdtgHMWEG3xovU6RAlQy4yu1UDIKj+ryRr+
 yBnjr2i3vAM/m+KWca697ZzqH/Ub+HhpSCmrtLroTqT67IgppGBSRnbH5axQThnsJ1P6NMApzwXQd
 km07OnMtaYdgg8qxjeZrCTNg6aokCXggAn8cW0XwHiMQZVx+O8kaDbGDJofaDQT1hnSHysw91IJcO
 Rc0Wg0SA==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdns-0073Ti-Rd; Mon, 29 Nov 2021 10:22:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 21/29] xfs: move dax device handling into xfs_{alloc,
 free}_buftarg
Date: Mon, 29 Nov 2021 11:21:55 +0100
Message-Id: <20211129102203.2243509-22-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
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

Hide the DAX device lookup from the xfs_super.c code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/xfs/xfs_buf.c   |  8 ++++----
 fs/xfs/xfs_buf.h   |  4 ++--
 fs/xfs/xfs_super.c | 26 +++++---------------------
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 631c5a61d89b7..4d4553ffa7050 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1892,6 +1892,7 @@ xfs_free_buftarg(
 	list_lru_destroy(&btp->bt_lru);
 
 	blkdev_issue_flush(btp->bt_bdev);
+	fs_put_dax(btp->bt_daxdev);
 
 	kmem_free(btp);
 }
@@ -1932,11 +1933,10 @@ xfs_setsize_buftarg_early(
 	return xfs_setsize_buftarg(btp, bdev_logical_block_size(bdev));
 }
 
-xfs_buftarg_t *
+struct xfs_buftarg *
 xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
-	struct block_device	*bdev,
-	struct dax_device	*dax_dev)
+	struct block_device	*bdev)
 {
 	xfs_buftarg_t		*btp;
 
@@ -1945,7 +1945,7 @@ xfs_alloc_buftarg(
 	btp->bt_mount = mp;
 	btp->bt_dev =  bdev->bd_dev;
 	btp->bt_bdev = bdev;
-	btp->bt_daxdev = dax_dev;
+	btp->bt_daxdev = fs_dax_get_by_bdev(bdev);
 
 	/*
 	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 6b0200b8007d1..bd7f709f0d232 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -338,8 +338,8 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
 /*
  *	Handling of buftargs.
  */
-extern struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *,
-		struct block_device *, struct dax_device *);
+struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
+		struct block_device *bdev);
 extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c4297206f4834..3584cfc3c5930 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -391,26 +391,19 @@ STATIC void
 xfs_close_devices(
 	struct xfs_mount	*mp)
 {
-	struct dax_device *dax_ddev = mp->m_ddev_targp->bt_daxdev;
-
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
 		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
-		struct dax_device *dax_logdev = mp->m_logdev_targp->bt_daxdev;
 
 		xfs_free_buftarg(mp->m_logdev_targp);
 		xfs_blkdev_put(logdev);
-		fs_put_dax(dax_logdev);
 	}
 	if (mp->m_rtdev_targp) {
 		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
-		struct dax_device *dax_rtdev = mp->m_rtdev_targp->bt_daxdev;
 
 		xfs_free_buftarg(mp->m_rtdev_targp);
 		xfs_blkdev_put(rtdev);
-		fs_put_dax(dax_rtdev);
 	}
 	xfs_free_buftarg(mp->m_ddev_targp);
-	fs_put_dax(dax_ddev);
 }
 
 /*
@@ -428,8 +421,6 @@ xfs_open_devices(
 	struct xfs_mount	*mp)
 {
 	struct block_device	*ddev = mp->m_super->s_bdev;
-	struct dax_device	*dax_ddev = fs_dax_get_by_bdev(ddev);
-	struct dax_device	*dax_logdev = NULL, *dax_rtdev = NULL;
 	struct block_device	*logdev = NULL, *rtdev = NULL;
 	int			error;
 
@@ -439,8 +430,7 @@ xfs_open_devices(
 	if (mp->m_logname) {
 		error = xfs_blkdev_get(mp, mp->m_logname, &logdev);
 		if (error)
-			goto out;
-		dax_logdev = fs_dax_get_by_bdev(logdev);
+			return error;
 	}
 
 	if (mp->m_rtname) {
@@ -454,25 +444,24 @@ xfs_open_devices(
 			error = -EINVAL;
 			goto out_close_rtdev;
 		}
-		dax_rtdev = fs_dax_get_by_bdev(rtdev);
 	}
 
 	/*
 	 * Setup xfs_mount buffer target pointers
 	 */
 	error = -ENOMEM;
-	mp->m_ddev_targp = xfs_alloc_buftarg(mp, ddev, dax_ddev);
+	mp->m_ddev_targp = xfs_alloc_buftarg(mp, ddev);
 	if (!mp->m_ddev_targp)
 		goto out_close_rtdev;
 
 	if (rtdev) {
-		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev, dax_rtdev);
+		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev);
 		if (!mp->m_rtdev_targp)
 			goto out_free_ddev_targ;
 	}
 
 	if (logdev && logdev != ddev) {
-		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev, dax_logdev);
+		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev);
 		if (!mp->m_logdev_targp)
 			goto out_free_rtdev_targ;
 	} else {
@@ -488,14 +477,9 @@ xfs_open_devices(
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
 	xfs_blkdev_put(rtdev);
-	fs_put_dax(dax_rtdev);
  out_close_logdev:
-	if (logdev && logdev != ddev) {
+	if (logdev && logdev != ddev)
 		xfs_blkdev_put(logdev);
-		fs_put_dax(dax_logdev);
-	}
- out:
-	fs_put_dax(dax_ddev);
 	return error;
 }
 
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
