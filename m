Return-Path: <SRS0=YY9U=PG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFAEC4321E
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 04:41:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C7161279
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 04:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74C7161279
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5631840430;
	Mon, 18 Oct 2021 04:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WV-fydgcjcsw; Mon, 18 Oct 2021 04:41:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4041F403FE;
	Mon, 18 Oct 2021 04:41:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D799C0011;
	Mon, 18 Oct 2021 04:41:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 298DDC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 04:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CA63608B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 04:41:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xmwwOp3hohlz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 04:41:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 839A4608B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 04:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=glgwSJzGEwQSM6Jz2SxPqM9pJWr388+uRKEOiUyQE70=; b=Xv8p6QGen6vZxngL0hWmmolZLb
 XDO6RQ6yNjTxtsF6/ySZjBm+7+xBt4HLsd34GtAdfbpaiB8L+iI/crRqiyVi1Z9BTMfpBTxHM0c/t
 s6Z7821TpndJq02sLk82ZF6QhgCflPo+WAaFEj/h7lG14I6ytZJVdl4HjqS72LUFDz1tPNIb75x3F
 lxJPOHaeRcwciJEcN7VEq1CGAHdtSo5CBz8vUgxKFU63WEcA/A3w5ELQNosgqe5o22SqEgn/Ddo+o
 4XcPRznSy9Euf+hC3Alw5K4didg/7rWgqdKvHe1REonDzmcqkAjuG9EJcOaBfvxR/xGR4hNewtE4v
 ItppiCVQ==;
Received: from 089144211028.atnat0020.highway.a1.net ([89.144.211.28]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcKSZ-00E3L1-Qh; Mon, 18 Oct 2021 04:41:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: 
Subject: [PATCH 06/11] xfs: factor out a xfs_setup_dax helper
Date: Mon, 18 Oct 2021 06:40:49 +0200
Message-Id: <20211018044054.1779424-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
References: <20211018044054.1779424-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
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

Factor out another DAX setup helper to simplify future changes.  Also
move the experimental warning after the checks to not clutter the log
too much if the setup failed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_super.c | 47 +++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c4e0cd1c1c8ca..d07020a8eb9e3 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -339,6 +339,32 @@ xfs_buftarg_is_dax(
 			bdev_nr_sectors(bt->bt_bdev));
 }
 
+static int
+xfs_setup_dax(
+	struct xfs_mount	*mp)
+{
+	struct super_block	*sb = mp->m_super;
+
+	if (!xfs_buftarg_is_dax(sb, mp->m_ddev_targp) &&
+	   (!mp->m_rtdev_targp || !xfs_buftarg_is_dax(sb, mp->m_rtdev_targp))) {
+		xfs_alert(mp,
+			"DAX unsupported by block device. Turning off DAX.");
+		goto disable_dax;
+	}
+
+	if (xfs_has_reflink(mp)) {
+		xfs_alert(mp, "DAX and reflink cannot be used together!");
+		return -EINVAL;
+	}
+
+	xfs_warn(mp, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
+	return 0;
+
+disable_dax:
+	xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
+	return 0;
+}
+
 STATIC int
 xfs_blkdev_get(
 	xfs_mount_t		*mp,
@@ -1592,26 +1618,9 @@ xfs_fs_fill_super(
 		sb->s_flags |= SB_I_VERSION;
 
 	if (xfs_has_dax_always(mp)) {
-		bool rtdev_is_dax = false, datadev_is_dax;
-
-		xfs_warn(mp,
-		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-
-		datadev_is_dax = xfs_buftarg_is_dax(sb, mp->m_ddev_targp);
-		if (mp->m_rtdev_targp)
-			rtdev_is_dax = xfs_buftarg_is_dax(sb,
-						mp->m_rtdev_targp);
-		if (!rtdev_is_dax && !datadev_is_dax) {
-			xfs_alert(mp,
-			"DAX unsupported by block device. Turning off DAX.");
-			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
-		}
-		if (xfs_has_reflink(mp)) {
-			xfs_alert(mp,
-		"DAX and reflink cannot be used together!");
-			error = -EINVAL;
+		error = xfs_setup_dax(mp);
+		if (error)
 			goto out_filestream_unmount;
-		}
 	}
 
 	if (xfs_has_discard(mp)) {
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
