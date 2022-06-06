Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8E5CCA489
	for <virtualization@archiver.kernel.org>; Mon,  6 Jun 2022 20:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 958F4410A6;
	Mon,  6 Jun 2022 20:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e_GJM9NDfSbv; Mon,  6 Jun 2022 20:41:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E053410AD;
	Mon,  6 Jun 2022 20:41:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCE74C007F;
	Mon,  6 Jun 2022 20:41:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC6B4C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3D0E410A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tia0xxE9EWXR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8932F410A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=MljmBGg5QLNrlXQo2zoqyO/w7uyNryh0JirP0K7S3ag=; b=crx1P1AOzfaVjsIjKFsnW/dRPz
 BXw2ENLZjBS3Tf/K4vlxUvTW65vSWeLe4SK5T0Xn+T+dHDiJg0i+lSt2MU+wL0lJZ5+okWaxAgbc0
 Z/vst7YgLlz94wNZjneO8OUXYrNEJKVSQQicN17cN1YoPQTICS4bXGxyDlnzy9O5ahmISSxp7vpN/
 Hwqq/epOdfS0GN2mfRLkGMDSNsHzoUSO3A1kzb8obP6+oMgROyOVolsUsjhQaeGAY7SVGoFC37P39
 vXEmqMt5KDLiFuVK/vK6EVvywxX227bt9H9wiRu2WVwsFGhB7SVM3X8Mlqtvyz7jItHArnFsZxYgX
 ssmeGojg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyJWx-00B19c-AH; Mon, 06 Jun 2022 20:40:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/20] btrfs: Convert btrfs_migratepage to migrate_folio
Date: Mon,  6 Jun 2022 21:40:40 +0100
Message-Id: <20220606204050.2625949-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606204050.2625949-1-willy@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
MIME-Version: 1.0
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
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

Use filemap_migrate_folio() to do the bulk of the work, and then copy
the ordered flag across if needed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/inode.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 81737eff92f3..5f41d869c648 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8255,30 +8255,24 @@ static bool btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 }
 
 #ifdef CONFIG_MIGRATION
-static int btrfs_migratepage(struct address_space *mapping,
-			     struct page *newpage, struct page *page,
+static int btrfs_migrate_folio(struct address_space *mapping,
+			     struct folio *dst, struct folio *src,
 			     enum migrate_mode mode)
 {
-	int ret;
+	int ret = filemap_migrate_folio(mapping, dst, src, mode);
 
-	ret = migrate_page_move_mapping(mapping, newpage, page, 0);
 	if (ret != MIGRATEPAGE_SUCCESS)
 		return ret;
 
-	if (page_has_private(page))
-		attach_page_private(newpage, detach_page_private(page));
-
-	if (PageOrdered(page)) {
-		ClearPageOrdered(page);
-		SetPageOrdered(newpage);
+	if (folio_test_ordered(src)) {
+		folio_clear_ordered(src);
+		folio_set_ordered(dst);
 	}
 
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
-	else
-		migrate_page_states(newpage, page);
 	return MIGRATEPAGE_SUCCESS;
 }
+#else
+#define btrfs_migrate_folio NULL
 #endif
 
 static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
@@ -11422,9 +11416,7 @@ static const struct address_space_operations btrfs_aops = {
 	.direct_IO	= noop_direct_IO,
 	.invalidate_folio = btrfs_invalidate_folio,
 	.release_folio	= btrfs_release_folio,
-#ifdef CONFIG_MIGRATION
-	.migratepage	= btrfs_migratepage,
-#endif
+	.migrate_folio	= btrfs_migrate_folio,
 	.dirty_folio	= filemap_dirty_folio,
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate	= btrfs_swap_activate,
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
