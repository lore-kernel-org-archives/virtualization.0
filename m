Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7440CCA483
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 15:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BEE0A41171;
	Wed,  8 Jun 2022 15:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9TCatyJmZKQB; Wed,  8 Jun 2022 15:03:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A20B41167;
	Wed,  8 Jun 2022 15:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EEF0C0082;
	Wed,  8 Jun 2022 15:03:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0838AC007C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 247F38191E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgnRURRl__mb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 793D0827F3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=3fQqNRsX2k9U5g+9eAzNLqy1rB1a5hC9OuR/TIVAv1c=; b=BzgCA3dtIfrrNOFOqZw+rQudkD
 nQHTv0fThp0cTrpRot0mmwRsAJIVnWEYdCMHR9+BI2vGiioilWMA0f5/jrc3m/9O4FeZRtFwrPPEc
 CRfaG1TVqvJZrjE8U7i8Qn0EyWZ+Huymk4p+kP5MwP0AvEE0aparXlmBO+8OO8YLNJ/O8TNmYzM1V
 BXTwncOLifnP30UapOFmT9Bg5IFrHfXxgFF0f3vKoRKkVZZE0LLbqRMWs/kl31OrOiRyD/mlQMkWG
 nU/8onyZGsVXhJq4qZ+wDdd8mdRf0/qTyqE2iJ8XwE6Cg7sqF/OMB+hYJd6qhVzvrxdp3ZngOZ9qD
 bKJsjzIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyxCu-00CjFO-89; Wed, 08 Jun 2022 15:02:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/19] mm/migrate: Convert writeout() to take a folio
Date: Wed,  8 Jun 2022 16:02:35 +0100
Message-Id: <20220608150249.3033815-6-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/migrate.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 1878de817a01..6b6fec26f4d0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -761,11 +761,10 @@ int buffer_migrate_page_norefs(struct address_space *mapping,
 #endif
 
 /*
- * Writeback a page to clean the dirty state
+ * Writeback a folio to clean the dirty state
  */
-static int writeout(struct address_space *mapping, struct page *page)
+static int writeout(struct address_space *mapping, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 		.nr_to_write = 1,
@@ -779,25 +778,25 @@ static int writeout(struct address_space *mapping, struct page *page)
 		/* No write method for the address space */
 		return -EINVAL;
 
-	if (!clear_page_dirty_for_io(page))
+	if (!folio_clear_dirty_for_io(folio))
 		/* Someone else already triggered a write */
 		return -EAGAIN;
 
 	/*
-	 * A dirty page may imply that the underlying filesystem has
-	 * the page on some queue. So the page must be clean for
-	 * migration. Writeout may mean we loose the lock and the
-	 * page state is no longer what we checked for earlier.
+	 * A dirty folio may imply that the underlying filesystem has
+	 * the folio on some queue. So the folio must be clean for
+	 * migration. Writeout may mean we lose the lock and the
+	 * folio state is no longer what we checked for earlier.
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
 	remove_migration_ptes(folio, folio, false);
 
-	rc = mapping->a_ops->writepage(page, &wbc);
+	rc = mapping->a_ops->writepage(&folio->page, &wbc);
 
 	if (rc != AOP_WRITEPAGE_ACTIVATE)
 		/* unlocked. Relock */
-		lock_page(page);
+		folio_lock(folio);
 
 	return (rc < 0) ? -EIO : -EAGAIN;
 }
@@ -817,7 +816,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
 		default:
 			return -EBUSY;
 		}
-		return writeout(mapping, &src->page);
+		return writeout(mapping, src);
 	}
 
 	/*
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
