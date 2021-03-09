Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28688C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:57:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22F765242
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22F765242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6125683DA9;
	Tue,  9 Mar 2021 15:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YAoyHMBUjr7I; Tue,  9 Mar 2021 15:57:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8A1483D89;
	Tue,  9 Mar 2021 15:57:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C00A0C000B;
	Tue,  9 Mar 2021 15:57:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D9A4C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F1D083D89
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XKz-3F5felaA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:57:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A60BF83D7A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=IFk47HqYrcljU8sgV3Szm3kSO/BjefEBgYu1y49MYsE=; b=WHyxP41MA1s5vmF0W/htokhaBx
 JJRExXLLcZF4nmAarls1d3HuzNwpxmbC2mhuQ2AjlEBa/HE9uab75LwxnBHvSlkMbCIWybzSODn2N
 nI1H1JvK6Iir6AOGJrydVaRgu6VKcvBTzTMpXy9rIa7WbTAufbU1gTxOWVjZCYgJMpuoZTM/mo4PI
 uRhHJt00wwUBMfOwTrEx++Btjp1eJXNPixwQbRg7gtFznHkapP3JdMEA9Bcm9iGgeFNorbolw8FTk
 j7Z0M3Q+So7C7evvGwEeGHmpDkMRkIYZTYMWqzUeucdgD9LBE/o0m4JdRWf9Xk52M7m+GAD4SKJAt
 L4oOHUZw==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lJehy-000lWp-8R; Tue, 09 Mar 2021 15:55:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 8/9] z3fold: remove the z3fold file system
Date: Tue,  9 Mar 2021 16:53:47 +0100
Message-Id: <20210309155348.974875-9-hch@lst.de>
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
 mm/z3fold.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e7cd9298b221f5..e0749a3d8987de 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/anon_inodes.h>
 #include <linux/atomic.h>
 #include <linux/sched.h>
 #include <linux/cpumask.h>
@@ -345,38 +346,10 @@ static inline void free_handle(unsigned long handle, struct z3fold_header *zhdr)
 	}
 }
 
-static int z3fold_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, Z3FOLD_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type z3fold_fs = {
-	.name		= "z3fold",
-	.init_fs_context = z3fold_init_fs_context,
-	.kill_sb	= kill_anon_super,
-};
-
-static struct vfsmount *z3fold_mnt;
-static int z3fold_mount(void)
-{
-	int ret = 0;
-
-	z3fold_mnt = kern_mount(&z3fold_fs);
-	if (IS_ERR(z3fold_mnt))
-		ret = PTR_ERR(z3fold_mnt);
-
-	return ret;
-}
-
-static void z3fold_unmount(void)
-{
-	kern_unmount(z3fold_mnt);
-}
-
 static const struct address_space_operations z3fold_aops;
 static int z3fold_register_migration(struct z3fold_pool *pool)
 {
-	pool->inode = alloc_anon_inode_sb(z3fold_mnt->mnt_sb);
+	pool->inode = alloc_anon_inode();
 	if (IS_ERR(pool->inode)) {
 		pool->inode = NULL;
 		return 1;
@@ -1787,22 +1760,15 @@ MODULE_ALIAS("zpool-z3fold");
 
 static int __init init_z3fold(void)
 {
-	int ret;
-
 	/* Make sure the z3fold header is not larger than the page size */
 	BUILD_BUG_ON(ZHDR_SIZE_ALIGNED > PAGE_SIZE);
-	ret = z3fold_mount();
-	if (ret)
-		return ret;
 
 	zpool_register_driver(&z3fold_zpool_driver);
-
 	return 0;
 }
 
 static void __exit exit_z3fold(void)
 {
-	z3fold_unmount();
 	zpool_unregister_driver(&z3fold_zpool_driver);
 }
 
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
