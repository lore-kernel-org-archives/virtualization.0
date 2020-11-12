Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E95C6369E
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D29F2224B
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0gIAFpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D29F2224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D1BB1870E1;
	Thu, 12 Nov 2020 13:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id arD7euPcKXno; Thu, 12 Nov 2020 13:38:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 95DAC870E5;
	Thu, 12 Nov 2020 13:38:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66366C088B;
	Thu, 12 Nov 2020 13:38:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB7DC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8A4F8870CE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AyfTbUjqy0Dd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B0979870D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkQpMojYRxFsLYxPlbZFOn8fec/qzZm0sDp3kHAbNA0=;
 b=C0gIAFpauBErBsgMuHayKdI4Giure5yT9A5BVektwa28RbMM3wr0ECCx4Kb5YxFy+YQ6nx
 vN1dm+VkhAUDRuk9TXByX137vEpi0rXI3+0w5Zv7Vx7BWNM/p3r8Pfmu+NmnsbaJdzV5fr
 Ptr44RR6MABMYGRRx4Yjsp3X38FAp6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-RXNbrCGMPiub07vAByCy4A-1; Thu, 12 Nov 2020 08:38:52 -0500
X-MC-Unique: RXNbrCGMPiub07vAByCy4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73C641030988;
 Thu, 12 Nov 2020 13:38:51 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAEE155765;
 Thu, 12 Nov 2020 13:38:49 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/29] virtio-mem: factor out handling of fake-offline
 pages in memory notifier
Date: Thu, 12 Nov 2020 14:37:55 +0100
Message-Id: <20201112133815.13332-10-david@redhat.com>
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

Let's factor out the core pieces and place the implementation next to
virtio_mem_fake_offline(). We'll reuse this functionality soon.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 73 +++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index fedfea27967e..c24055248f9d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -160,6 +160,10 @@ static DEFINE_MUTEX(virtio_mem_mutex);
 static LIST_HEAD(virtio_mem_devices);
 
 static void virtio_mem_online_page_cb(struct page *page, unsigned int order);
+static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
+						  unsigned long nr_pages);
+static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
+						   unsigned long nr_pages);
 
 /*
  * Register a virtio-mem device so it will be considered for the online_page
@@ -586,27 +590,15 @@ static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
-	struct page *page;
 	unsigned long pfn;
-	int sb_id, i;
+	int sb_id;
 
 	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
 		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
-		/*
-		 * Drop our reference to the pages so the memory can get
-		 * offlined and add the unplugged pages to the managed
-		 * page counters (so offlining code can correctly subtract
-		 * them again).
-		 */
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			       sb_id * vm->subblock_size);
-		adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
-		for (i = 0; i < nr_pages; i++) {
-			page = pfn_to_page(pfn + i);
-			if (WARN_ON(!page_ref_dec_and_test(page)))
-				dump_page(page, "unplugged page referenced");
-		}
+		virtio_mem_fake_offline_going_offline(pfn, nr_pages);
 	}
 }
 
@@ -615,21 +607,14 @@ static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
 	unsigned long pfn;
-	int sb_id, i;
+	int sb_id;
 
 	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
 		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
-		/*
-		 * Get the reference we dropped when going offline and
-		 * subtract the unplugged pages from the managed page
-		 * counters.
-		 */
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			       sb_id * vm->subblock_size);
-		adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
-		for (i = 0; i < nr_pages; i++)
-			page_ref_inc(pfn_to_page(pfn + i));
+		virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
 	}
 }
 
@@ -814,6 +799,48 @@ static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
 	return 0;
 }
 
+/*
+ * Handle fake-offline pages when memory is going offline - such that the
+ * pages can be skipped by mm-core when offlining.
+ */
+static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
+						  unsigned long nr_pages)
+{
+	struct page *page;
+	unsigned long i;
+
+	/*
+	 * Drop our reference to the pages so the memory can get offlined
+	 * and add the unplugged pages to the managed page counters (so
+	 * offlining code can correctly subtract them again).
+	 */
+	adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
+	/* Drop our reference to the pages so the memory can get offlined. */
+	for (i = 0; i < nr_pages; i++) {
+		page = pfn_to_page(pfn + i);
+		if (WARN_ON(!page_ref_dec_and_test(page)))
+			dump_page(page, "fake-offline page referenced");
+	}
+}
+
+/*
+ * Handle fake-offline pages when memory offlining is canceled - to undo
+ * what we did in virtio_mem_fake_offline_going_offline().
+ */
+static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
+						   unsigned long nr_pages)
+{
+	unsigned long i;
+
+	/*
+	 * Get the reference we dropped when going offline and subtract the
+	 * unplugged pages from the managed page counters.
+	 */
+	adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
+	for (i = 0; i < nr_pages; i++)
+		page_ref_inc(pfn_to_page(pfn + i));
+}
+
 static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 {
 	const unsigned long addr = page_to_phys(page);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
