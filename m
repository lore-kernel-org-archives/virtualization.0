Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A43C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:55:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAF065253
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAF065253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3B2483D41;
	Tue,  9 Mar 2021 15:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wDhGsZCw6fcP; Tue,  9 Mar 2021 15:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44F3B834DE;
	Tue,  9 Mar 2021 15:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30808C000B;
	Tue,  9 Mar 2021 15:55:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB1F5C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A97EF494C8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HjondfB10gFW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDD8247A21
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=7nuDahRSmYJ6PThyWDr7Xu918vQCfVTiqk1yVO8AeRg=; b=Vjun9SYZDP9JrvLc48F11Twd4e
 R5XJpfUwpMyzQ7LtqixDEwkdoeqMTSNnJdErVwe0Gzw90B+bXKlQrQtVddfTJjnxrXXk9GJdmnkLG
 JWtTCjj1tN3tRiy5QVYGaGk4mgMQDl7FurXRb5D9u2XjIb0BBWxIW2/CEBaVK1OQH9jbs+X8Xd9SG
 CQBblQ+dHU5PcnYPQf4yUg5m2Jit6/wznYXt69OGzneI5IxXDIsKy0DIl2KrOqddiHgFmAS6r1eUq
 afS57DyaEcVHy1jBTyC8xHx/LlT6dBW1HchxjZs5WfYY5xaJbcPB/sgk69m8QFMOAW8SbI69fEk8h
 JaExt8Tg==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lJegk-000lND-Rr; Tue, 09 Mar 2021 15:54:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/9] powerpc/pseries: remove the ppc-cmm file system
Date: Tue,  9 Mar 2021 16:53:42 +0100
Message-Id: <20210309155348.974875-4-hch@lst.de>
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
 arch/powerpc/platforms/pseries/cmm.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 6d36b858b14df1..9d07e6bea7126c 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -6,6 +6,7 @@
  * Author(s): Brian King (brking@linux.vnet.ibm.com),
  */
 
+#include <linux/anon_inodes.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -502,19 +503,6 @@ static struct notifier_block cmm_mem_nb = {
 };
 
 #ifdef CONFIG_BALLOON_COMPACTION
-static struct vfsmount *balloon_mnt;
-
-static int cmm_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, PPC_CMM_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type balloon_fs = {
-	.name = "ppc-cmm",
-	.init_fs_context = cmm_init_fs_context,
-	.kill_sb = kill_anon_super,
-};
-
 static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 			   struct page *newpage, struct page *page,
 			   enum migrate_mode mode)
@@ -573,19 +561,10 @@ static int cmm_balloon_compaction_init(void)
 	balloon_devinfo_init(&b_dev_info);
 	b_dev_info.migratepage = cmm_migratepage;
 
-	balloon_mnt = kern_mount(&balloon_fs);
-	if (IS_ERR(balloon_mnt)) {
-		rc = PTR_ERR(balloon_mnt);
-		balloon_mnt = NULL;
-		return rc;
-	}
-
-	b_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
+	b_dev_info.inode = alloc_anon_inode();
 	if (IS_ERR(b_dev_info.inode)) {
 		rc = PTR_ERR(b_dev_info.inode);
 		b_dev_info.inode = NULL;
-		kern_unmount(balloon_mnt);
-		balloon_mnt = NULL;
 		return rc;
 	}
 
@@ -597,8 +576,6 @@ static void cmm_balloon_compaction_deinit(void)
 	if (b_dev_info.inode)
 		iput(b_dev_info.inode);
 	b_dev_info.inode = NULL;
-	kern_unmount(balloon_mnt);
-	balloon_mnt = NULL;
 }
 #else /* CONFIG_BALLOON_COMPACTION */
 static int cmm_balloon_compaction_init(void)
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
