Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D850DC61DD8
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD6F22249
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSEA0Ost"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD6F22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE3ED87796;
	Thu, 12 Nov 2020 13:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y0L2Zge61lmW; Thu, 12 Nov 2020 13:38:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 41B68877AA;
	Thu, 12 Nov 2020 13:38:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD91C088B;
	Thu, 12 Nov 2020 13:38:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 691E1C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1E3A22010F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eOUkURucTD1m
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id D7AFC2E1B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whRB7fqvEtHYEsoDQkuEHgauodp8esw7rtmEk6rZXVc=;
 b=JSEA0OstQUt+UHV/s5TSlGU6Xh0310ZBx9EW4eTtQg82OjT0JkSB8mXQQs5wVl4GM+7jHP
 4XvFAJO4eztQUro8IiSxudMLAxA+V6Ra0Atxjc9LEN0PN0ttice05dxjg4gZasTMW5qOEt
 fBibG2vb/UL1xKTIOo+QNrD3oBA5pno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-0Z8WCwcuNXyAJtPJYsPZ1A-1; Thu, 12 Nov 2020 08:38:50 -0500
X-MC-Unique: 0Z8WCwcuNXyAJtPJYsPZ1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742FA107ACF8;
 Thu, 12 Nov 2020 13:38:49 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAB4955765;
 Thu, 12 Nov 2020 13:38:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/29] virtio-mem: factor out fake-offlining into
 virtio_mem_fake_offline()
Date: Thu, 12 Nov 2020 14:37:54 +0100
Message-Id: <20201112133815.13332-9-david@redhat.com>
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

... which now matches virtio_mem_fake_online(). We'll reuse this
functionality soon.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 4742497feff0..fedfea27967e 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -793,6 +793,27 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 	}
 }
 
+/*
+ * Try to allocate a range, marking pages fake-offline, effectively
+ * fake-offlining them.
+ */
+static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
+{
+	int rc;
+
+	rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
+				GFP_KERNEL);
+	if (rc == -ENOMEM)
+		/* whoops, out of memory */
+		return rc;
+	if (rc)
+		return -EBUSY;
+
+	virtio_mem_set_fake_offline(pfn, nr_pages, true);
+	adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
+	return 0;
+}
+
 static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 {
 	const unsigned long addr = page_to_phys(page);
@@ -1328,17 +1349,10 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
 
 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			     sb_id * vm->subblock_size);
-	rc = alloc_contig_range(start_pfn, start_pfn + nr_pages,
-				MIGRATE_MOVABLE, GFP_KERNEL);
-	if (rc == -ENOMEM)
-		/* whoops, out of memory */
-		return rc;
-	if (rc)
-		return -EBUSY;
 
-	/* Mark it as fake-offline before unplugging it */
-	virtio_mem_set_fake_offline(start_pfn, nr_pages, true);
-	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+	rc = virtio_mem_fake_offline(start_pfn, nr_pages);
+	if (rc)
+		return rc;
 
 	/* Try to unplug the allocated memory */
 	rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
