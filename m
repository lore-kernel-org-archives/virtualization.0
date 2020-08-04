Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0C7C433E4
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 19:42:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901A32076E
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 19:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkBjoQEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901A32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A7A588007;
	Tue,  4 Aug 2020 19:42:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7jdH8Ye2kbF0; Tue,  4 Aug 2020 19:42:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C36BC87F9F;
	Tue,  4 Aug 2020 19:42:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB876C0050;
	Tue,  4 Aug 2020 19:42:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79780C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 19:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 68D8F87FE9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 19:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8jewQWS3jEs
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 19:42:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9B9F387F9F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 19:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596570124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94kv3iM7voNuc/GuCMOJeaJASAgCqOV3S0igLlKUpuI=;
 b=SkBjoQEWvDm8ofeRCeGvvwq0sLQbAc13zcLQWP7oYm6YhpyqLC0CBOKr5D++HmG6u1q3sE
 8ARAxRrQSuxEYJu/sg7+fBfAExQr0pjSgxKm51VbBQJr3Wpn9edsR5r83idX7cHHOZyN3M
 c1LGnpU7cQj5nLjQSLAPmwd8f7vJw+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-VlR3S6k3NKaBmdM_PavKFA-1; Tue, 04 Aug 2020 15:42:00 -0400
X-MC-Unique: VlR3S6k3NKaBmdM_PavKFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49D8858;
 Tue,  4 Aug 2020 19:41:59 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-95.ams2.redhat.com [10.36.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 455BD72E4F;
 Tue,  4 Aug 2020 19:41:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] mm/page_alloc: tweak comments in has_unmovable_pages()
Date: Tue,  4 Aug 2020 21:41:38 +0200
Message-Id: <20200804194142.28279-3-david@redhat.com>
In-Reply-To: <20200804194142.28279-1-david@redhat.com>
References: <20200804194142.28279-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Let's move the split comment regarding bootmem allocations and memory
holes, especially in the context of ZONE_MOVABLE, to the PageReserved()
check.

Reviewed-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce2942..042ba09d70c5d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8207,14 +8207,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 	unsigned long iter = 0;
 	unsigned long pfn = page_to_pfn(page);
 
-	/*
-	 * TODO we could make this much more efficient by not checking every
-	 * page in the range if we know all of them are in MOVABLE_ZONE and
-	 * that the movable zone guarantees that pages are migratable but
-	 * the later is not the case right now unfortunatelly. E.g. movablecore
-	 * can still lead to having bootmem allocations in zone_movable.
-	 */
-
 	if (is_migrate_cma_page(page)) {
 		/*
 		 * CMA allocations (alloc_contig_range) really need to mark
@@ -8233,6 +8225,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 
 		page = pfn_to_page(pfn + iter);
 
+		/*
+		 * Both, bootmem allocations and memory holes are marked
+		 * PG_reserved and are unmovable. We can even have unmovable
+		 * allocations inside ZONE_MOVABLE, for example when
+		 * specifying "movablecore".
+		 */
 		if (PageReserved(page))
 			return page;
 
@@ -8306,14 +8304,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		 * it.  But now, memory offline itself doesn't call
 		 * shrink_node_slabs() and it still to be fixed.
 		 */
-		/*
-		 * If the page is not RAM, page_count()should be 0.
-		 * we don't need more check. This is an _used_ not-movable page.
-		 *
-		 * The problematic thing here is PG_reserved pages. PG_reserved
-		 * is set to both of a memory hole page and a _used_ kernel
-		 * page at boot.
-		 */
 		return page;
 	}
 	return NULL;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
