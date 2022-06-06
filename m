Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C9FCCA482
	for <virtualization@archiver.kernel.org>; Mon,  6 Jun 2022 20:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CF3061360;
	Mon,  6 Jun 2022 20:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wGGca694PYi1; Mon,  6 Jun 2022 20:41:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0213261357;
	Mon,  6 Jun 2022 20:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6DC6C0091;
	Mon,  6 Jun 2022 20:41:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82003C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06E4641081
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3nWYhMLtAbuY
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E83EF40992
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=2z1jX0yhTDltG7l7TM/WGDPE6d/xoDTeJDDQMbm1wg8=; b=Cv8slqe8iqqf4HOlLgutAaOA1A
 aFZHrqpp1ecJXz6/5OQgJaQgKmewa4IH+xNKntZNhPPNG2mq0TdCdUt37Lr1Rlb0d1jJiC5N0NY/k
 MH0U/aTkoMggca8NkpnWB2GfbEv8k3Qmd5IKV0bs9olGVEmGhjFUfhCNRkX82E7h2m4gIdzJIK83s
 bHNkdkHR2JrVCWQENaRdn/efg9EVXp1QQpLyXEb/+OSm01Xpgs6y+Nu8g5hE+zcuMzIc9U7qF5UHc
 CxDD3zjR9BkFUEuw/J+/y4QTlNqlIzj7jIvBLCnybLdxlLB62DbDIFf5GndYJbQZ9TUlgPwmGmbBf
 0wr7BlYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyJWw-00B19Q-Rb; Mon, 06 Jun 2022 20:40:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/20] mm/migrate: Convert buffer_migrate_page() to
 buffer_migrate_folio()
Date: Mon,  6 Jun 2022 21:40:34 +0100
Message-Id: <20220606204050.2625949-5-willy@infradead.org>
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

Use a folio throughout __buffer_migrate_folio(), add kernel-doc for
buffer_migrate_folio() and buffer_migrate_folio_norefs(), move their
declarations to buffer.h and switch all filesystems that have wired
them up.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/fops.c                |  2 +-
 fs/ext2/inode.c             |  4 +-
 fs/ext4/inode.c             |  4 +-
 fs/ntfs/aops.c              |  6 +--
 fs/ocfs2/aops.c             |  2 +-
 include/linux/buffer_head.h | 10 +++++
 include/linux/fs.h          | 12 ------
 mm/migrate.c                | 76 ++++++++++++++++++++++---------------
 8 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d6b3276a6c68..743fc46d0aad 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -417,7 +417,7 @@ const struct address_space_operations def_blk_aops = {
 	.write_end	= blkdev_write_end,
 	.writepages	= blkdev_writepages,
 	.direct_IO	= blkdev_direct_IO,
-	.migratepage	= buffer_migrate_page_norefs,
+	.migrate_folio	= buffer_migrate_folio_norefs,
 	.is_dirty_writeback = buffer_check_dirty_writeback,
 };
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 360ce3604a2d..84570c6265aa 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -973,7 +973,7 @@ const struct address_space_operations ext2_aops = {
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
 	.writepages		= ext2_writepages,
-	.migratepage		= buffer_migrate_page,
+	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate	= block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 };
@@ -989,7 +989,7 @@ const struct address_space_operations ext2_nobh_aops = {
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
 	.writepages		= ext2_writepages,
-	.migratepage		= buffer_migrate_page,
+	.migrate_folio		= buffer_migrate_folio,
 	.error_remove_page	= generic_error_remove_page,
 };
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1aaea53e67b5..53877ffe3c41 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3633,7 +3633,7 @@ static const struct address_space_operations ext4_aops = {
 	.invalidate_folio	= ext4_invalidate_folio,
 	.release_folio		= ext4_release_folio,
 	.direct_IO		= noop_direct_IO,
-	.migratepage		= buffer_migrate_page,
+	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
@@ -3668,7 +3668,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.invalidate_folio	= ext4_invalidate_folio,
 	.release_folio		= ext4_release_folio,
 	.direct_IO		= noop_direct_IO,
-	.migratepage		= buffer_migrate_page,
+	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 9e3964ea2ea0..5f4fb6ca6f2e 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1659,7 +1659,7 @@ const struct address_space_operations ntfs_normal_aops = {
 	.dirty_folio	= block_dirty_folio,
 #endif /* NTFS_RW */
 	.bmap		= ntfs_bmap,
-	.migratepage	= buffer_migrate_page,
+	.migrate_folio	= buffer_migrate_folio,
 	.is_partially_uptodate = block_is_partially_uptodate,
 	.error_remove_page = generic_error_remove_page,
 };
@@ -1673,7 +1673,7 @@ const struct address_space_operations ntfs_compressed_aops = {
 	.writepage	= ntfs_writepage,
 	.dirty_folio	= block_dirty_folio,
 #endif /* NTFS_RW */
-	.migratepage	= buffer_migrate_page,
+	.migrate_folio	= buffer_migrate_folio,
 	.is_partially_uptodate = block_is_partially_uptodate,
 	.error_remove_page = generic_error_remove_page,
 };
@@ -1688,7 +1688,7 @@ const struct address_space_operations ntfs_mst_aops = {
 	.writepage	= ntfs_writepage,	/* Write dirty page to disk. */
 	.dirty_folio	= filemap_dirty_folio,
 #endif /* NTFS_RW */
-	.migratepage	= buffer_migrate_page,
+	.migrate_folio	= buffer_migrate_folio,
 	.is_partially_uptodate	= block_is_partially_uptodate,
 	.error_remove_page = generic_error_remove_page,
 };
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 767df51f8657..1d489003f99d 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2462,7 +2462,7 @@ const struct address_space_operations ocfs2_aops = {
 	.direct_IO		= ocfs2_direct_IO,
 	.invalidate_folio	= block_invalidate_folio,
 	.release_folio		= ocfs2_release_folio,
-	.migratepage		= buffer_migrate_page,
+	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate	= block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 };
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index c9d1463bb20f..b0366c89d6a4 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -267,6 +267,16 @@ int nobh_truncate_page(struct address_space *, loff_t, get_block_t *);
 int nobh_writepage(struct page *page, get_block_t *get_block,
                         struct writeback_control *wbc);
 
+#ifdef CONFIG_MIGRATION
+extern int buffer_migrate_folio(struct address_space *,
+		struct folio *dst, struct folio *src, enum migrate_mode);
+extern int buffer_migrate_folio_norefs(struct address_space *,
+		struct folio *dst, struct folio *src, enum migrate_mode);
+#else
+#define buffer_migrate_folio NULL
+#define buffer_migrate_folio_norefs NULL
+#endif
+
 void buffer_init(void);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7b380fa66983..5737c92ed286 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3217,18 +3217,6 @@ extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
-#ifdef CONFIG_MIGRATION
-extern int buffer_migrate_page(struct address_space *,
-				struct page *, struct page *,
-				enum migrate_mode);
-extern int buffer_migrate_page_norefs(struct address_space *,
-				struct page *, struct page *,
-				enum migrate_mode);
-#else
-#define buffer_migrate_page NULL
-#define buffer_migrate_page_norefs NULL
-#endif
-
 int may_setattr(struct user_namespace *mnt_userns, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct user_namespace *, struct dentry *, struct iattr *);
diff --git a/mm/migrate.c b/mm/migrate.c
index f19246c12fe9..77b8c662c9ca 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -657,23 +657,23 @@ static bool buffer_migrate_lock_buffers(struct buffer_head *head,
 	return true;
 }
 
-static int __buffer_migrate_page(struct address_space *mapping,
-		struct page *newpage, struct page *page, enum migrate_mode mode,
+static int __buffer_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode,
 		bool check_refs)
 {
 	struct buffer_head *bh, *head;
 	int rc;
 	int expected_count;
 
-	if (!page_has_buffers(page))
-		return migrate_page(mapping, newpage, page, mode);
+	head = folio_buffers(src);
+	if (!head)
+		return migrate_page(mapping, &dst->page, &src->page, mode);
 
 	/* Check whether page does not have extra refs before we do more work */
-	expected_count = expected_page_refs(mapping, page);
-	if (page_count(page) != expected_count)
+	expected_count = expected_page_refs(mapping, &src->page);
+	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-	head = page_buffers(page);
 	if (!buffer_migrate_lock_buffers(head, mode))
 		return -EAGAIN;
 
@@ -704,23 +704,22 @@ static int __buffer_migrate_page(struct address_space *mapping,
 		}
 	}
 
-	rc = migrate_page_move_mapping(mapping, newpage, page, 0);
+	rc = folio_migrate_mapping(mapping, dst, src, 0);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		goto unlock_buffers;
 
-	attach_page_private(newpage, detach_page_private(page));
+	folio_attach_private(dst, folio_detach_private(src));
 
 	bh = head;
 	do {
-		set_bh_page(bh, newpage, bh_offset(bh));
+		set_bh_page(bh, &dst->page, bh_offset(bh));
 		bh = bh->b_this_page;
-
 	} while (bh != head);
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
+		folio_migrate_copy(dst, src);
 	else
-		migrate_page_states(newpage, page);
+		folio_migrate_flags(dst, src);
 
 	rc = MIGRATEPAGE_SUCCESS;
 unlock_buffers:
@@ -730,34 +729,51 @@ static int __buffer_migrate_page(struct address_space *mapping,
 	do {
 		unlock_buffer(bh);
 		bh = bh->b_this_page;
-
 	} while (bh != head);
 
 	return rc;
 }
 
-/*
- * Migration function for pages with buffers. This function can only be used
- * if the underlying filesystem guarantees that no other references to "page"
- * exist. For example attached buffer heads are accessed only under page lock.
+/**
+ * buffer_migrate_folio() - Migration function for folios with buffers.
+ * @mapping: The address space containing @src.
+ * @dst: The folio to migrate to.
+ * @src: The folio to migrate from.
+ * @mode: How to migrate the folio.
+ *
+ * This function can only be used if the underlying filesystem guarantees
+ * that no other references to @src exist. For example attached buffer
+ * heads are accessed only under the folio lock.  If your filesystem cannot
+ * provide this guarantee, buffer_migrate_folio_noref() may be more
+ * appropriate.
+ *
+ * Return: 0 on success or a negative errno on failure.
  */
-int buffer_migrate_page(struct address_space *mapping,
-		struct page *newpage, struct page *page, enum migrate_mode mode)
+int buffer_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
-	return __buffer_migrate_page(mapping, newpage, page, mode, false);
+	return __buffer_migrate_folio(mapping, dst, src, mode, false);
 }
-EXPORT_SYMBOL(buffer_migrate_page);
+EXPORT_SYMBOL(buffer_migrate_folio);
 
-/*
- * Same as above except that this variant is more careful and checks that there
- * are also no buffer head references. This function is the right one for
- * mappings where buffer heads are directly looked up and referenced (such as
- * block device mappings).
+/**
+ * buffer_migrate_folio_noref() - Migration function for folios with buffers.
+ * @mapping: The address space containing @src.
+ * @dst: The folio to migrate to.
+ * @src: The folio to migrate from.
+ * @mode: How to migrate the folio.
+ *
+ * Like buffer_migrate_folio() except that this variant is more careful
+ * and checks that there are also no buffer head references. This function
+ * is the right one for mappings where buffer heads are directly looked
+ * up and referenced (such as block device mappings).
+ *
+ * Return: 0 on success or a negative errno on failure.
  */
-int buffer_migrate_page_norefs(struct address_space *mapping,
-		struct page *newpage, struct page *page, enum migrate_mode mode)
+int buffer_migrate_folio_norefs(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
-	return __buffer_migrate_page(mapping, newpage, page, mode, true);
+	return __buffer_migrate_folio(mapping, dst, src, mode, true);
 }
 #endif
 
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
