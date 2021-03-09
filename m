Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9056AC433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:57:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D35565279
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D35565279
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7C756F501;
	Tue,  9 Mar 2021 15:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g2_w4bVrWX8p; Tue,  9 Mar 2021 15:57:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C9C66F509;
	Tue,  9 Mar 2021 15:57:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0441C0013;
	Tue,  9 Mar 2021 15:57:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AF7FC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AC834C351
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wAjV48XCeFxC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:57:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8818D4C6C9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=81oGSCBl39iypfLV/NoPk/fT5YyYJiKMaMVaZJIwgrQ=; b=K1zd0jFpZYL+ZtHkLHvgFqVo3p
 h0n1mVJ6xBDYsmZ2ahXvorBLK+B3nIqdp9SBF8EG/bXS+IsljPrtJK2g37AP4qDeVxiqHM/RZXx3q
 S2CEFcUd8C43qdjZ+9VdgqfeVWq56HoefjzfpaWwnPCvcAjOqJar1KuO0CyEqdbCe8ML70nAYFfua
 VPC6vyaOhGWsaj+cksNDgySPdh8+mPTd/DfGakuL9yseLjJeQfIk/7NZVe94BnW2qbyUlG2+FyHwZ
 uFSZK8ZEBs8Qdk6n8xtOgSm5GaHD9TgoqPuqa4IUBK0F1IiHVfJUGU91yPDMhg29RGnXUdHnRmOAs
 sVy5rRLQ==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lJeiQ-000lYx-7J; Tue, 09 Mar 2021 15:56:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 9/9] zsmalloc: remove the zsmalloc file system
Date: Tue,  9 Mar 2021 16:53:48 +0100
Message-Id: <20210309155348.974875-10-hch@lst.de>
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
 mm/zsmalloc.c | 48 +++---------------------------------------------
 1 file changed, 3 insertions(+), 45 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a6449a2ad861de..a7d2f471935447 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -41,6 +41,7 @@
 #include <linux/slab.h>
 #include <linux/pgtable.h>
 #include <asm/tlbflush.h>
+#include <linux/anon_inodes.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
 #include <linux/vmalloc.h>
@@ -176,10 +177,6 @@ struct zs_size_stat {
 static struct dentry *zs_stat_root;
 #endif
 
-#ifdef CONFIG_COMPACTION
-static struct vfsmount *zsmalloc_mnt;
-#endif
-
 /*
  * We assign a page to ZS_ALMOST_EMPTY fullness group when:
  *	n <= N / f, where
@@ -308,8 +305,6 @@ static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
-static int zsmalloc_mount(void) { return 0; }
-static void zsmalloc_unmount(void) {}
 static int zs_register_migration(struct zs_pool *pool) { return 0; }
 static void zs_unregister_migration(struct zs_pool *pool) {}
 static void migrate_lock_init(struct zspage *zspage) {}
@@ -1751,33 +1746,6 @@ static void lock_zspage(struct zspage *zspage)
 	} while ((page = get_next_page(page)) != NULL);
 }
 
-static int zs_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, ZSMALLOC_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type zsmalloc_fs = {
-	.name		= "zsmalloc",
-	.init_fs_context = zs_init_fs_context,
-	.kill_sb	= kill_anon_super,
-};
-
-static int zsmalloc_mount(void)
-{
-	int ret = 0;
-
-	zsmalloc_mnt = kern_mount(&zsmalloc_fs);
-	if (IS_ERR(zsmalloc_mnt))
-		ret = PTR_ERR(zsmalloc_mnt);
-
-	return ret;
-}
-
-static void zsmalloc_unmount(void)
-{
-	kern_unmount(zsmalloc_mnt);
-}
-
 static void migrate_lock_init(struct zspage *zspage)
 {
 	rwlock_init(&zspage->lock);
@@ -2086,7 +2054,7 @@ static const struct address_space_operations zsmalloc_aops = {
 
 static int zs_register_migration(struct zs_pool *pool)
 {
-	pool->inode = alloc_anon_inode_sb(zsmalloc_mnt->mnt_sb);
+	pool->inode = alloc_anon_inode();
 	if (IS_ERR(pool->inode)) {
 		pool->inode = NULL;
 		return 1;
@@ -2506,14 +2474,10 @@ static int __init zs_init(void)
 {
 	int ret;
 
-	ret = zsmalloc_mount();
-	if (ret)
-		goto out;
-
 	ret = cpuhp_setup_state(CPUHP_MM_ZS_PREPARE, "mm/zsmalloc:prepare",
 				zs_cpu_prepare, zs_cpu_dead);
 	if (ret)
-		goto hp_setup_fail;
+		return ret;
 
 #ifdef CONFIG_ZPOOL
 	zpool_register_driver(&zs_zpool_driver);
@@ -2522,11 +2486,6 @@ static int __init zs_init(void)
 	zs_stat_init();
 
 	return 0;
-
-hp_setup_fail:
-	zsmalloc_unmount();
-out:
-	return ret;
 }
 
 static void __exit zs_exit(void)
@@ -2534,7 +2493,6 @@ static void __exit zs_exit(void)
 #ifdef CONFIG_ZPOOL
 	zpool_unregister_driver(&zs_zpool_driver);
 #endif
-	zsmalloc_unmount();
 	cpuhp_remove_state(CPUHP_MM_ZS_PREPARE);
 
 	zs_stat_exit();
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
