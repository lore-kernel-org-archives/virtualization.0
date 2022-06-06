Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53769CCA489
	for <virtualization@archiver.kernel.org>; Mon,  6 Jun 2022 20:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6072840A0;
	Mon,  6 Jun 2022 20:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3SAR7TeCqxTW; Mon,  6 Jun 2022 20:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 86C5E8308D;
	Mon,  6 Jun 2022 20:41:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C588C0039;
	Mon,  6 Jun 2022 20:41:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97D5EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AB9D4107E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4JLM7tE_MQCh
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2BEE4108A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Nbr9wUy4GZu/A9I5fNiEUH8YjHUTRzvYZO3QnrtHfqs=; b=Gd3hSiL+/E0dfHLBarUzOacZ5+
 RgLt/HR3/LRhEZeLymFVkZyeDV4o45ibioJi0eraHf6ehCGQbtosb1TjID04N286tCzWwDmpddr27
 H3ByN9G6hK5riWHYLqRkTy3GsEZUgLnYhezqas1+XNq5pmGlpRnM2NevyEDgUXJ8ZYsVlaLiCT3RO
 8Ehpw8He8k5yQNPfIvPT9F5a/3yz8jOKKKyGe7pM1yVoqkDKz2YPmFcUn0VPuUW3SPY9tPOvKaZJU
 1Vf1NH8uVC9GEQzwQCTJYo35GSSSaLqMV3XH1X1fzAEkojyoaH3wkOkh+Z2rcUydL6L7kLEvUr3mZ
 LKB+9tpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyJWx-00B19q-Uf; Mon, 06 Jun 2022 20:40:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/20] z3fold: Convert to migrate_folio
Date: Mon,  6 Jun 2022 21:40:47 +0100
Message-Id: <20220606204050.2625949-18-willy@infradead.org>
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

z3fold doesn't really use folios, but it needs to be called like this
in order to migrate an individual page.  Convert from a folio back to
a page until we decide how to handle migration better for z3fold.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/z3fold.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index f41f8b0d9e9a..5d091c41fb35 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1554,9 +1554,11 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	return false;
 }
 
-static int z3fold_page_migrate(struct address_space *mapping, struct page *newpage,
-			       struct page *page, enum migrate_mode mode)
+static int z3fold_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
+	struct page *newpage = &dst->page;
+	struct page *page = &src->page;
 	struct z3fold_header *zhdr, *new_zhdr;
 	struct z3fold_pool *pool;
 	struct address_space *new_mapping;
@@ -1644,7 +1646,7 @@ static void z3fold_page_putback(struct page *page)
 
 static const struct address_space_operations z3fold_aops = {
 	.isolate_page = z3fold_page_isolate,
-	.migratepage = z3fold_page_migrate,
+	.migrate_folio = z3fold_migrate_folio,
 	.putback_page = z3fold_page_putback,
 };
 
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
