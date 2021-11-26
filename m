Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4BDC433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 13:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F5EA82A95;
	Fri, 26 Nov 2021 13:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ej8DrhzycP93; Fri, 26 Nov 2021 13:43:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD98F82A7F;
	Fri, 26 Nov 2021 13:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79571C001C;
	Fri, 26 Nov 2021 13:43:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 531EAC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3530282A6C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OHz2m-BeToj9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:43:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E77082A5D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637934180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4ASNgq1wvOne4qpYWmxZPMmbkQM20zd6LP7bCK7u48=;
 b=BEUFoZnrqKVwdPmcyIALVFD6vGHgxwrnqoLRC7W1zpXwQmee38Mx4XzfZ7GdHeUNYkAfdw
 CqXwPKCkvCnfuFAYoVF5MO7Ep4YAylYiXRWB8HdwbWlxh4sX9X2Mpo2sakyMH629fc1HRy
 MN23TfgCLHePGjTsXCSjeBKrP9hzIcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-kLUfQrpTOl2g6qN_yUWUvQ-1; Fri, 26 Nov 2021 08:42:55 -0500
X-MC-Unique: kLUfQrpTOl2g6qN_yUWUvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB25E84B9A1;
 Fri, 26 Nov 2021 13:42:53 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F11E46C350;
 Fri, 26 Nov 2021 13:42:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] virtio-mem: prepare fake page onlining code for
 granularity smaller than MAX_ORDER - 1
Date: Fri, 26 Nov 2021 14:42:09 +0100
Message-Id: <20211126134209.17332-3-david@redhat.com>
In-Reply-To: <20211126134209.17332-1-david@redhat.com>
References: <20211126134209.17332-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Gavin Shan <gshan@redhat.com>,
 Eric Ren <renzhengeek@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, Zi Yan <ziy@nvidia.com>,
 Hui Zhu <teawater@gmail.com>, Wei Yang <richard.weiyang@linux.alibaba.com>
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

Let's prepare our fake page onlining code for subblock size smaller than
MAX_ORDER - 1: we might get called for ranges not covering properly
aligned MAX_ORDER - 1 pages. We have to detect the order to use
dynamically.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 03e1c5743699..50de7582c9f8 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1121,15 +1121,18 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
  */
 static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 {
-	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
+	unsigned long order = MAX_ORDER - 1;
 	unsigned long i;
 
 	/*
-	 * We are always called at least with MAX_ORDER_NR_PAGES
-	 * granularity/alignment (e.g., the way subblocks work). All pages
-	 * inside such a block are alike.
+	 * We might get called for ranges that don't cover properly aligned
+	 * MAX_ORDER - 1 pages; however, we can only online properly aligned
+	 * pages with an order of MAX_ORDER - 1 at maximum.
 	 */
-	for (i = 0; i < nr_pages; i += max_nr_pages) {
+	while (!IS_ALIGNED(pfn | nr_pages, 1 << order))
+		order--;
+
+	for (i = 0; i < nr_pages; i += 1 << order) {
 		struct page *page = pfn_to_page(pfn + i);
 
 		/*
@@ -1139,14 +1142,12 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 		 * alike.
 		 */
 		if (PageDirty(page)) {
-			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
-						      false);
-			generic_online_page(page, MAX_ORDER - 1);
+			virtio_mem_clear_fake_offline(pfn + i, 1 << order, false);
+			generic_online_page(page, order);
 		} else {
-			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
-						      true);
-			free_contig_range(pfn + i, max_nr_pages);
-			adjust_managed_page_count(page, max_nr_pages);
+			virtio_mem_clear_fake_offline(pfn + i, 1 << order, true);
+			free_contig_range(pfn + i, 1 << order);
+			adjust_managed_page_count(page, 1 << order);
 		}
 	}
 }
@@ -2477,7 +2478,6 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	/*
 	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
 	 * pageblock_nr_pages pages. This:
-	 * - Simplifies our fake page onlining code (virtio_mem_fake_online).
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
