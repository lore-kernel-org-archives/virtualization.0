Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD2C001E0
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C898083D17;
	Thu, 13 Jul 2023 14:56:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C898083D17
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ckP2DaeZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-Afz3b8kGlX; Thu, 13 Jul 2023 14:56:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B03283D12;
	Thu, 13 Jul 2023 14:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B03283D12
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89FC9C0DD6;
	Thu, 13 Jul 2023 14:56:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AC08C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0585A83D0D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0585A83D0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K6PkTTKUsbbB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28D0C83CEC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28D0C83CEC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689260161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOmThcBQ38XDQnqrguekPpebm9LB32j86WbUbdRAymk=;
 b=ckP2DaeZp6yd41hYpo24COXZYVXu5A8TiFzIc3yySFV+z4hViJvMtaQQxspdtgZGZ5beD/
 hDRb1mpKhtqYEMk400uZbdfmXy91Zfvi3XLDRp8vA/f9T0tStXlbM/V24Vq/umO7eZr5nW
 tFoceyVhexTSPK7yJYV0eHQfGhUjsKc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-j4H8HIhJMpCZyM7rsWcs1g-1; Thu, 13 Jul 2023 10:55:57 -0400
X-MC-Unique: j4H8HIhJMpCZyM7rsWcs1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FD7A29A9D36;
 Thu, 13 Jul 2023 14:55:57 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4780F66D1;
 Thu, 13 Jul 2023 14:55:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] virtio-mem: remove unsafe unplug in Big Block Mode
 (BBM)
Date: Thu, 13 Jul 2023 16:55:48 +0200
Message-ID: <20230713145551.2824980-2-david@redhat.com>
In-Reply-To: <20230713145551.2824980-1-david@redhat.com>
References: <20230713145551.2824980-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

When "unsafe unplug" is enabled, we don't fake-offline all memory ahead of
actual memory offlining using alloc_contig_range(). Instead, we rely on
offline_pages() to also perform actual page migration, which might fail
or take a very long time.

In that case, it's possible to easily run into endless loops that cannot be
aborted anymore (as offlining is triggered by a workqueue then): For
example, a single (accidentally) permanently unmovable page in
ZONE_MOVABLE results in an endless loop. For ZONE_NORMAL, races between
isolating the pageblock (and checking for unmovable pages) and
concurrent page allocation are possible and similarly result in endless
loops.

The idea of the unsafe unplug mode was to make it possible to more
reliably unplug large memory blocks. However, (a) we really should be
tackling that differently, by extending the alloc_contig_range()-based
mechanism; and (b) this mode is not the default and as far as I know,
it's unused either way.

So let's simply get rid of it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 51 +++++++++++++++----------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 835f6cc2fb66..ed15d2a4bd96 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -38,11 +38,6 @@ module_param(bbm_block_size, ulong, 0444);
 MODULE_PARM_DESC(bbm_block_size,
 		 "Big Block size in bytes. Default is 0 (auto-detection).");
 
-static bool bbm_safe_unplug = true;
-module_param(bbm_safe_unplug, bool, 0444);
-MODULE_PARM_DESC(bbm_safe_unplug,
-	     "Use a safe unplug mechanism in BBM, avoiding long/endless loops");
-
 /*
  * virtio-mem currently supports the following modes of operation:
  *
@@ -2111,38 +2106,32 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 			 VIRTIO_MEM_BBM_BB_ADDED))
 		return -EINVAL;
 
-	if (bbm_safe_unplug) {
-		/*
-		 * Start by fake-offlining all memory. Once we marked the device
-		 * block as fake-offline, all newly onlined memory will
-		 * automatically be kept fake-offline. Protect from concurrent
-		 * onlining/offlining until we have a consistent state.
-		 */
-		mutex_lock(&vm->hotplug_mutex);
-		virtio_mem_bbm_set_bb_state(vm, bb_id,
-					    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
+	/*
+	 * Start by fake-offlining all memory. Once we marked the device
+	 * block as fake-offline, all newly onlined memory will
+	 * automatically be kept fake-offline. Protect from concurrent
+	 * onlining/offlining until we have a consistent state.
+	 */
+	mutex_lock(&vm->hotplug_mutex);
+	virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
 
-		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-			page = pfn_to_online_page(pfn);
-			if (!page)
-				continue;
+	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		page = pfn_to_online_page(pfn);
+		if (!page)
+			continue;
 
-			rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
-			if (rc) {
-				end_pfn = pfn;
-				goto rollback_safe_unplug;
-			}
+		rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
+		if (rc) {
+			end_pfn = pfn;
+			goto rollback;
 		}
-		mutex_unlock(&vm->hotplug_mutex);
 	}
+	mutex_unlock(&vm->hotplug_mutex);
 
 	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
 	if (rc) {
-		if (bbm_safe_unplug) {
-			mutex_lock(&vm->hotplug_mutex);
-			goto rollback_safe_unplug;
-		}
-		return rc;
+		mutex_lock(&vm->hotplug_mutex);
+		goto rollback;
 	}
 
 	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
@@ -2154,7 +2143,7 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 					    VIRTIO_MEM_BBM_BB_UNUSED);
 	return rc;
 
-rollback_safe_unplug:
+rollback:
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		page = pfn_to_online_page(pfn);
 		if (!page)
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
