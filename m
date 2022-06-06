Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F530CCA487
	for <virtualization@archiver.kernel.org>; Mon,  6 Jun 2022 20:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1C3A84006;
	Mon,  6 Jun 2022 20:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2cY9mpyAby0T; Mon,  6 Jun 2022 20:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B24B831B0;
	Mon,  6 Jun 2022 20:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E60B8C0086;
	Mon,  6 Jun 2022 20:41:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C8D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 744514108A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gwC8wV0hduE4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81CBE41081
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=2zqEa9EzjfvcCB/R36xszZ4AMZtdcV59XiMVDc9jTyM=; b=U+BqaoSQWdsShi/y8CPTtTig63
 HCMa7+gIZx7Yyb6cusLNuXKWsG06WN8xz/erKBPWuYizRThCX0iiljqhNcZd2weflUVCtiqE770D/
 Vb15aA5PxUQlAGcLo3M0XEH41Q/fMFbQWUysBrY6PEG35YJKOueNndbkU/J8qu3X5pGzhsOP7ol4W
 F3RaDu2I/zP67juMsLCzxygZBIwXjKCl86d9jfX6rvdn+U142VP0hON97WCqvsixaBkAVbsODa0Rm
 STrW9jc4kjH9X53B35Fdz629pIYD4+nkkWKOdWUlig7kbghCKRcjBc7pf8npYNE/LtOnrV8sVT0Vs
 SEGqa5Hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyJWx-00B19i-Jy; Mon, 06 Jun 2022 20:40:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/20] aio: Convert to migrate_folio
Date: Mon,  6 Jun 2022 21:40:43 +0100
Message-Id: <20220606204050.2625949-14-willy@infradead.org>
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

Use a folio throughout this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/aio.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3c249b938632..a1911e86859c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -400,8 +400,8 @@ static const struct file_operations aio_ring_fops = {
 };
 
 #if IS_ENABLED(CONFIG_MIGRATION)
-static int aio_migratepage(struct address_space *mapping, struct page *new,
-			struct page *old, enum migrate_mode mode)
+static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
+			struct folio *src, enum migrate_mode mode)
 {
 	struct kioctx *ctx;
 	unsigned long flags;
@@ -435,10 +435,10 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 		goto out;
 	}
 
-	idx = old->index;
+	idx = src->index;
 	if (idx < (pgoff_t)ctx->nr_pages) {
-		/* Make sure the old page hasn't already been changed */
-		if (ctx->ring_pages[idx] != old)
+		/* Make sure the old folio hasn't already been changed */
+		if (ctx->ring_pages[idx] != &src->page)
 			rc = -EAGAIN;
 	} else
 		rc = -EINVAL;
@@ -447,27 +447,27 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 		goto out_unlock;
 
 	/* Writeback must be complete */
-	BUG_ON(PageWriteback(old));
-	get_page(new);
+	BUG_ON(folio_test_writeback(src));
+	folio_get(dst);
 
-	rc = migrate_page_move_mapping(mapping, new, old, 1);
+	rc = folio_migrate_mapping(mapping, dst, src, 1);
 	if (rc != MIGRATEPAGE_SUCCESS) {
-		put_page(new);
+		folio_put(dst);
 		goto out_unlock;
 	}
 
 	/* Take completion_lock to prevent other writes to the ring buffer
-	 * while the old page is copied to the new.  This prevents new
+	 * while the old folio is copied to the new.  This prevents new
 	 * events from being lost.
 	 */
 	spin_lock_irqsave(&ctx->completion_lock, flags);
-	migrate_page_copy(new, old);
-	BUG_ON(ctx->ring_pages[idx] != old);
-	ctx->ring_pages[idx] = new;
+	folio_migrate_copy(dst, src);
+	BUG_ON(ctx->ring_pages[idx] != &src->page);
+	ctx->ring_pages[idx] = &dst->page;
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
-	/* The old page is no longer accessible. */
-	put_page(old);
+	/* The old folio is no longer accessible. */
+	folio_put(src);
 
 out_unlock:
 	mutex_unlock(&ctx->ring_lock);
@@ -475,13 +475,13 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 	spin_unlock(&mapping->private_lock);
 	return rc;
 }
+#else
+#define aio_migrate_folio NULL
 #endif
 
 static const struct address_space_operations aio_ctx_aops = {
 	.dirty_folio	= noop_dirty_folio,
-#if IS_ENABLED(CONFIG_MIGRATION)
-	.migratepage	= aio_migratepage,
-#endif
+	.migrate_folio	= aio_migrate_folio,
 };
 
 static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
