Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1B1C433E6
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:56:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283BE65242
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283BE65242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF3734C4BF;
	Tue,  9 Mar 2021 15:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WwzEqSAv7odA; Tue,  9 Mar 2021 15:56:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F0B64BF7C;
	Tue,  9 Mar 2021 15:56:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF16AC000B;
	Tue,  9 Mar 2021 15:56:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 209A1C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F177E4308F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YDsa8j30PvGo
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:56:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D7BD430AE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=3M8hBLIawJHMtUGgys5VeJcEPDN2yS9O0RGnqufBgKI=; b=U2dY1YoxC/q1JkvxYuErcUmM7G
 yNLzZEFPUD/PpwSMC0sxlmTrm15YRnKHKJAt+fMXoP9qEB/cTAxoI5Pm6jwZZk+bXrHectQuAsiFC
 rX1aVSPbDujtJRpARm7H+EDSahwdvGZgm8tKkGQEqHEF57ViiLlCwMAkXxyCyYQO/nmP1hGHolJS5
 aHHrsNWOUhNj6riEwaOc9ADfSNG2qUcuWpHQnzqa0IYvDrRP3H7eJdz57HO8orK9CyOiPihYKpRWJ
 lwcNNXwHH8HGXZTyH602DtYjkOGdhM7VkOAiZZgjli5xWKnsO06znGdhAsbUh5UFfx9JQ9Ikwrkbz
 Eeiwq1jA==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lJehA-000lO8-7a; Tue, 09 Mar 2021 15:54:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/9] vmw_balloon: remove the balloon-vmware file system
Date: Tue,  9 Mar 2021 16:53:44 +0100
Message-Id: <20210309155348.974875-6-hch@lst.de>
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
 drivers/misc/vmw_balloon.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 5d057a05ddbee8..be4be32f858253 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -16,6 +16,7 @@
 //#define DEBUG
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/anon_inodes.h>
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -1735,20 +1736,6 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
 
 
 #ifdef CONFIG_BALLOON_COMPACTION
-
-static int vmballoon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, BALLOON_VMW_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type vmballoon_fs = {
-	.name           	= "balloon-vmware",
-	.init_fs_context	= vmballoon_init_fs_context,
-	.kill_sb        	= kill_anon_super,
-};
-
-static struct vfsmount *vmballoon_mnt;
-
 /**
  * vmballoon_migratepage() - migrates a balloon page.
  * @b_dev_info: balloon device information descriptor.
@@ -1878,8 +1865,6 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
 		iput(b->b_dev_info.inode);
 
 	b->b_dev_info.inode = NULL;
-	kern_unmount(vmballoon_mnt);
-	vmballoon_mnt = NULL;
 }
 
 /**
@@ -1895,13 +1880,8 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
  */
 static __init int vmballoon_compaction_init(struct vmballoon *b)
 {
-	vmballoon_mnt = kern_mount(&vmballoon_fs);
-	if (IS_ERR(vmballoon_mnt))
-		return PTR_ERR(vmballoon_mnt);
-
 	b->b_dev_info.migratepage = vmballoon_migratepage;
-	b->b_dev_info.inode = alloc_anon_inode_sb(vmballoon_mnt->mnt_sb);
-
+	b->b_dev_info.inode = alloc_anon_inode();
 	if (IS_ERR(b->b_dev_info.inode))
 		return PTR_ERR(b->b_dev_info.inode);
 
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
