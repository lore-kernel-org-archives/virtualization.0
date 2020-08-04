Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4951C433E3
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF36F22C9F
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqxRYL+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF36F22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 67B95221AF;
	Tue,  4 Aug 2020 07:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MC2fH4iUtUR0; Tue,  4 Aug 2020 07:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3F5D920517;
	Tue,  4 Aug 2020 07:24:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36EABC0050;
	Tue,  4 Aug 2020 07:24:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F7BAC004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 07:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 89B2D220E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 07:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QZYRnz9i8+wy
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 07:24:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 092D820517
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596525874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNmXR+u9IzTxR95YCO3PnwRTTSVw3K+hGsEdO4nA3OU=;
 b=JqxRYL+YUhi+fCFmzFqDomJLbkoWYNuJTsgbG8tU2bLJZke9qL5Xl1EelQhtpa+G+dq+xo
 8iJJ73XppKbF2uza8tkT+qQn4PePwnR6hcuHkaP5fZ/gyykClin1iwjBom77HrjB2LZc2E
 M5TJMFnuO7NXZXF7YRK6ebn2DuaA1C4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-UxVyeqfcPXiLW0qdNCofPQ-1; Tue, 04 Aug 2020 03:24:32 -0400
X-MC-Unique: UxVyeqfcPXiLW0qdNCofPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46300100AA2C;
 Tue,  4 Aug 2020 07:24:31 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-95.ams2.redhat.com [10.36.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 483715DA33;
 Tue,  4 Aug 2020 07:24:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] mm/page_isolation: cleanup set_migratetype_isolate()
Date: Tue,  4 Aug 2020 09:24:06 +0200
Message-Id: <20200804072408.5481-5-david@redhat.com>
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

Let's clean it up a bit, simplifying error handling and getting rid of
the label.

Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index d099aac479601..e65fe5d770849 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -17,12 +17,9 @@
 
 static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
 {
-	struct page *unmovable = NULL;
-	struct zone *zone;
+	struct zone *zone = page_zone(page);
+	struct page *unmovable;
 	unsigned long flags;
-	int ret = -EBUSY;
-
-	zone = page_zone(page);
 
 	spin_lock_irqsave(&zone->lock, flags);
 
@@ -51,13 +48,13 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 									NULL);
 
 		__mod_zone_freepage_state(zone, -nr_pages, mt);
-		ret = 0;
+		spin_unlock_irqrestore(&zone->lock, flags);
+		drain_all_pages(zone);
+		return 0;
 	}
 
 	spin_unlock_irqrestore(&zone->lock, flags);
-	if (!ret) {
-		drain_all_pages(zone);
-	} else if ((isol_flags & REPORT_FAILURE) && unmovable) {
+	if (isol_flags & REPORT_FAILURE) {
 		/*
 		 * printk() with zone->lock held will likely trigger a
 		 * lockdep splat, so defer it here.
@@ -65,7 +62,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 		dump_page(unmovable, "unmovable page");
 	}
 
-	return ret;
+	return -EBUSY;
 }
 
 static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
