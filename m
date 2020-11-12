Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8155C56201
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1176E22240
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRByZXGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1176E22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 93E098779D;
	Thu, 12 Nov 2020 13:38:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NI2loFazKLkl; Thu, 12 Nov 2020 13:38:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 143D087797;
	Thu, 12 Nov 2020 13:38:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F21D2C088B;
	Thu, 12 Nov 2020 13:38:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84FEDC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7428F8779C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g1xdHYV4RJSr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 65B7A87797
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bj0DKxluQya7IdKMjC0YW3CYR9bPN7tHSjtUVL7Eyyg=;
 b=XRByZXGjBRKfCZFm3OiuANPrbZqg81BmWEL/bghprHxZpQF8KutILCAjt6Zf1Gd+ScobdG
 UlDyYGJwahL0RtFCswA6qvGGaA4upcOxwR5EstwfATHmVTIt+6hkcLAfoFpRa/GXz7JsBl
 YmeTKwG0TKuugGmyzA3MkKGf56nnH9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20--b0kf3i0M6GTTdJ6moAhCw-1; Thu, 12 Nov 2020 08:38:33 -0500
X-MC-Unique: -b0kf3i0M6GTTdJ6moAhCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7808D18B9FA9;
 Thu, 12 Nov 2020 13:38:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B53FE75138;
 Thu, 12 Nov 2020 13:38:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/29] virtio-mem: simplify MAX_ORDER - 1 / pageblock_order
 handling
Date: Thu, 12 Nov 2020 14:37:49 +0100
Message-Id: <20201112133815.13332-4-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org
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

Let's use pageblock_nr_pages and MAX_ORDER_NR_PAGES instead where
possible to simplify.

Add a comment why we have that restriction for now.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index dee46865bae2..0f9d854e8e42 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -753,14 +753,15 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
  */
 static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
 {
-	const int order = MAX_ORDER - 1;
+	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
 	int i;
 
 	/*
-	 * We are always called with subblock granularity, which is at least
-	 * aligned to MAX_ORDER - 1.
+	 * We are always called at least with MAX_ORDER_NR_PAGES
+	 * granularity/alignment (e.g., the way subblocks work). All pages
+	 * inside such a block are alike.
 	 */
-	for (i = 0; i < nr_pages; i += 1 << order) {
+	for (i = 0; i < nr_pages; i += max_nr_pages) {
 		struct page *page = pfn_to_page(pfn + i);
 
 		/*
@@ -770,14 +771,14 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
 		 * alike.
 		 */
 		if (PageDirty(page)) {
-			virtio_mem_clear_fake_offline(pfn + i, 1 << order,
+			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
 						      false);
-			generic_online_page(page, order);
+			generic_online_page(page, MAX_ORDER - 1);
 		} else {
-			virtio_mem_clear_fake_offline(pfn + i, 1 << order,
+			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
 						      true);
-			free_contig_range(pfn + i, 1 << order);
-			adjust_managed_page_count(page, 1 << order);
+			free_contig_range(pfn + i, max_nr_pages);
+			adjust_managed_page_count(page, max_nr_pages);
 		}
 	}
 }
@@ -790,7 +791,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 	int sb_id;
 
 	/*
-	 * We exploit here that subblocks have at least MAX_ORDER - 1
+	 * We exploit here that subblocks have at least MAX_ORDER_NR_PAGES.
 	 * size/alignment and that this callback is is called with such a
 	 * size/alignment. So we cannot cross subblocks and therefore
 	 * also not memory blocks.
@@ -1673,13 +1674,15 @@ static int virtio_mem_init(struct virtio_mem *vm)
 			 "Some memory is not addressable. This can make some memory unusable.\n");
 
 	/*
-	 * Calculate the subblock size:
-	 * - At least MAX_ORDER - 1 / pageblock_order.
-	 * - At least the device block size.
-	 * In the worst case, a single subblock per memory block.
+	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
+	 * pageblock_nr_pages pages. This:
+	 * - Simplifies our page onlining code (virtio_mem_online_page_cb)
+	 *   and fake page onlining code (virtio_mem_fake_online).
+	 * - Is required for now for alloc_contig_range() to work reliably -
+	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-	vm->subblock_size = PAGE_SIZE * 1ul << max_t(uint32_t, MAX_ORDER - 1,
-						     pageblock_order);
+	vm->subblock_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
+				  pageblock_nr_pages) * PAGE_SIZE;
 	vm->subblock_size = max_t(uint64_t, vm->device_block_size,
 				  vm->subblock_size);
 	vm->nb_sb_per_mb = memory_block_size_bytes() / vm->subblock_size;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
