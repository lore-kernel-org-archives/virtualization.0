Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F0CC433E0
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30022076C
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfWPZI0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30022076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 959AD87B9B;
	Tue,  4 Aug 2020 07:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ToVZccXCRZGx; Tue,  4 Aug 2020 07:24:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1C50A87A14;
	Tue,  4 Aug 2020 07:24:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05887C0050;
	Tue,  4 Aug 2020 07:24:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE526C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 07:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DC36986B68
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 07:24:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pgksR74szwed
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 07:24:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 898E186777
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596525872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lt1g0htUa/bc8OboHGsnEp9sr/LuEltQUA5QpsfHh1k=;
 b=EfWPZI0lQtxajkAA+WIaNw6/CzBVcsFmUgCdx2xTI7/wXMUYYrEj0g8zT78f2CPgpysNuq
 JM1FrM8SruFTcsqutr7TwgekSXd1VrdsVvjf6ay/84m5aVSlvC5MH8gimJPBcPTGnz+UAx
 dy3QKVKX9E01gORXGNuuSszBqRO7w9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488--bsXYjLqO0qVPCbYYyYWJA-1; Tue, 04 Aug 2020 03:24:30 -0400
X-MC-Unique: -bsXYjLqO0qVPCbYYyYWJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED8D79ED5;
 Tue,  4 Aug 2020 07:24:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-95.ams2.redhat.com [10.36.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F30575DA74;
 Tue,  4 Aug 2020 07:24:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] mm/page_isolation: drop WARN_ON_ONCE() in
 set_migratetype_isolate()
Date: Tue,  4 Aug 2020 09:24:05 +0200
Message-Id: <20200804072408.5481-4-david@redhat.com>
In-Reply-To: <20200804072408.5481-1-david@redhat.com>
References: <20200804072408.5481-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Baoquan He <bhe@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

Inside has_unmovable_pages(), we have a comment describing how unmovable
data could end up in ZONE_MOVABLE - via "movable_core". Also, besides
checking if the first page in the pageblock is reserved, we don't
perform any further checks in case of ZONE_MOVABLE.

In case of memory offlining, we set REPORT_FAILURE, properly
dump_page() the page and handle the error gracefully.
alloc_contig_pages() users currently never allocate from ZONE_MOVABLE.
E.g., hugetlb uses alloc_contig_pages() for the allocation of gigantic
pages only, which will never end up on the MOVABLE zone
(see htlb_alloc_mask()).

Reviewed-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 7d7d263ce7f4b..d099aac479601 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -57,15 +57,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret) {
 		drain_all_pages(zone);
-	} else {
-		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-
-		if ((isol_flags & REPORT_FAILURE) && unmovable)
-			/*
-			 * printk() with zone->lock held will likely trigger a
-			 * lockdep splat, so defer it here.
-			 */
-			dump_page(unmovable, "unmovable page");
+	} else if ((isol_flags & REPORT_FAILURE) && unmovable) {
+		/*
+		 * printk() with zone->lock held will likely trigger a
+		 * lockdep splat, so defer it here.
+		 */
+		dump_page(unmovable, "unmovable page");
 	}
 
 	return ret;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
