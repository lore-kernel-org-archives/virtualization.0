Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863CFCCA489
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 15:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33B1060E36;
	Wed,  8 Jun 2022 15:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zXWEDirfAmNy; Wed,  8 Jun 2022 15:03:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A357560E76;
	Wed,  8 Jun 2022 15:03:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80533C0083;
	Wed,  8 Jun 2022 15:03:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABDE5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BDDA60EE6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pOuqNGOGQzAD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC40D60A81
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ncg84OMjo+AvVLmZPKmxXncRAMSRMDL0v/ScNwY3xFo=; b=ZH1jj5JLt5Huo0hFneWdzgOddm
 tf5K8ofhIHTgnH+k78szErcZy1qjS4hpsIPzVbNLfB5AIeGJmWMbZktwyBE6yJjNN24hOFdbIWYps
 0k5T7kH1RFNzHhpJsupjLqgjCdLqwuWzSZgNhY2n52oP0kMd87dkVgBHfSoFTVS8nt6uZvyuZE06K
 gHrqY4UgBaz7xm0r/3v2l0jjzdslv1KD0nkS+J0Cbg4WA6mbH+6xsumitM+mTT5Vcrrl3/x0lv80/
 61+K0Wy9nZhpfjr/5EC2MG8rMJ90zjUNQarBbpaXsRYondC+xNRnTEkCIjXwjmRbYvVaaccl1uAzH
 CsHsOp5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyxCu-00CjFU-Ga; Wed, 08 Jun 2022 15:02:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/19] btrfs: Convert btree_migratepage to migrate_folio
Date: Wed,  8 Jun 2022 16:02:38 +0100
Message-Id: <20220608150249.3033815-9-willy@infradead.org>
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

Use a folio throughout this function.  migrate_page() will be converted
later.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 12b11e645c14..9ceb73f683af 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -952,28 +952,28 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 }
 
 #ifdef CONFIG_MIGRATION
-static int btree_migratepage(struct address_space *mapping,
-			struct page *newpage, struct page *page,
-			enum migrate_mode mode)
+static int btree_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
 	/*
 	 * we can't safely write a btree page from here,
 	 * we haven't done the locking hook
 	 */
-	if (PageDirty(page))
+	if (folio_test_dirty(src))
 		return -EAGAIN;
 	/*
 	 * Buffers may be managed in a filesystem specific way.
 	 * We must have no buffers or drop them.
 	 */
-	if (page_has_private(page) &&
-	    !try_to_release_page(page, GFP_KERNEL))
+	if (folio_get_private(src) &&
+	    !filemap_release_folio(src, GFP_KERNEL))
 		return -EAGAIN;
-	return migrate_page(mapping, newpage, page, mode);
+	return migrate_page(mapping, &dst->page, &src->page, mode);
 }
+#else
+#define btree_migrate_folio NULL
 #endif
 
-
 static int btree_writepages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
@@ -1073,10 +1073,8 @@ static const struct address_space_operations btree_aops = {
 	.writepages	= btree_writepages,
 	.release_folio	= btree_release_folio,
 	.invalidate_folio = btree_invalidate_folio,
-#ifdef CONFIG_MIGRATION
-	.migratepage	= btree_migratepage,
-#endif
-	.dirty_folio = btree_dirty_folio,
+	.migrate_folio	= btree_migrate_folio,
+	.dirty_folio	= btree_dirty_folio,
 };
 
 struct extent_buffer *btrfs_find_create_tree_block(
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
