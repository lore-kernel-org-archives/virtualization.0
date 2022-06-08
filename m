Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0FDC43334
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 15:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80E4983EF6;
	Wed,  8 Jun 2022 15:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FoOqnv7pWXQi; Wed,  8 Jun 2022 15:03:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EE3588248F;
	Wed,  8 Jun 2022 15:03:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41926C008A;
	Wed,  8 Jun 2022 15:03:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AFC8C0039
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF6028191E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tGufUsOOtpKe
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0E518248F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=XR+RIMaPRstxhE5d9sK6W/lLAxJj8y6CMlZq/dw3i2g=; b=PinZio6D0unRMLA2LkVJ0ptTFG
 VrnAnp0fToz0SSUq+txImmnD3LXbPrTgnBlZV++pGdop4Cn2WGlRLHpKuS+kybl2tUCz9v7CkzcI7
 M7dlh9co51ybg0sfqiCvyfJ+qCDVgLM04IACEtw5v5qim5kAOU7n37rbZwVisvIb02sc/ZVnklOXA
 Z5Yog62jbLrAe6tbGbP1arO8LqW6WhxyWv31XFNHQTwJmoW7cJQZQo66HOCZ0qKa0oTcQqQUR6I7N
 YxEdTY90TszBiIe5Yx9ka66db2HDnsKgnuyFmp91lyFFjiAr/Y42M1z5fpXGH6DEdv5iEQaT18DjE
 zFSSPGRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyxCu-00CjFW-Ik; Wed, 08 Jun 2022 15:02:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/19] nfs: Convert to migrate_folio
Date: Wed,  8 Jun 2022 16:02:39 +0100
Message-Id: <20220608150249.3033815-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220608150249.3033815-1-willy@infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
MIME-Version: 1.0
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 Anna Schumaker <Anna.Schumaker@Netapp.com>, linux-ext4@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
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

Use a folio throughout this function.  migrate_page() will be converted
later.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/file.c     |  4 +---
 fs/nfs/internal.h |  6 ++++--
 fs/nfs/write.c    | 16 ++++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 2d72b1b7ed74..549baed76351 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -533,9 +533,7 @@ const struct address_space_operations nfs_file_aops = {
 	.write_end = nfs_write_end,
 	.invalidate_folio = nfs_invalidate_folio,
 	.release_folio = nfs_release_folio,
-#ifdef CONFIG_MIGRATION
-	.migratepage = nfs_migrate_page,
-#endif
+	.migrate_folio = nfs_migrate_folio,
 	.launder_folio = nfs_launder_folio,
 	.is_dirty_writeback = nfs_check_dirty_writeback,
 	.error_remove_page = generic_error_remove_page,
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 8f8cd6e2d4db..437ebe544aaf 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -578,8 +578,10 @@ void nfs_clear_pnfs_ds_commit_verifiers(struct pnfs_ds_commit_info *cinfo)
 #endif
 
 #ifdef CONFIG_MIGRATION
-extern int nfs_migrate_page(struct address_space *,
-		struct page *, struct page *, enum migrate_mode);
+int nfs_migrate_folio(struct address_space *, struct folio *dst,
+		struct folio *src, enum migrate_mode);
+#else
+#define nfs_migrate_folio NULL
 #endif
 
 static inline int
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1c706465d090..649b9e633459 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2119,27 +2119,27 @@ int nfs_wb_page(struct inode *inode, struct page *page)
 }
 
 #ifdef CONFIG_MIGRATION
-int nfs_migrate_page(struct address_space *mapping, struct page *newpage,
-		struct page *page, enum migrate_mode mode)
+int nfs_migrate_folio(struct address_space *mapping, struct folio *dst,
+		struct folio *src, enum migrate_mode mode)
 {
 	/*
-	 * If PagePrivate is set, then the page is currently associated with
+	 * If the private flag is set, the folio is currently associated with
 	 * an in-progress read or write request. Don't try to migrate it.
 	 *
 	 * FIXME: we could do this in principle, but we'll need a way to ensure
 	 *        that we can safely release the inode reference while holding
-	 *        the page lock.
+	 *        the folio lock.
 	 */
-	if (PagePrivate(page))
+	if (folio_test_private(src))
 		return -EBUSY;
 
-	if (PageFsCache(page)) {
+	if (folio_test_fscache(src)) {
 		if (mode == MIGRATE_ASYNC)
 			return -EBUSY;
-		wait_on_page_fscache(page);
+		folio_wait_fscache(src);
 	}
 
-	return migrate_page(mapping, newpage, page, mode);
+	return migrate_page(mapping, &dst->page, &src->page, mode);
 }
 #endif
 
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
