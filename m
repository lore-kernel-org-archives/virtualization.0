Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC55C47096
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 18:58:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51E2613E9
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 18:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51E2613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70F7F40548;
	Wed,  2 Jun 2021 18:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zCw-5lZGYzBI; Wed,  2 Jun 2021 18:58:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B9124053C;
	Wed,  2 Jun 2021 18:58:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 450D4C000E;
	Wed,  2 Jun 2021 18:58:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 297F3C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A73640265
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EGzHDvhk9DqT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:58:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3457E400AE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622660279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gd8uzZwFJ8pHYnrxMQBkbl2rE25HoIkxoK5pX+TDCFU=;
 b=UpEQ1qf9JQTYwpeKSXmYxBWQ6lbWeBiB3owoapx2hn36nM5LBzkObDC97O1Ve6f0uaF4CF
 tZ0Ei3lVpqukoGA/+o7596Ymh4JZZrhtHrQAh84bBZNi0Y+5f07524c/pFGm+SlP5ExWAM
 8Zf+u/Jok1rjfEoyF0DEkuyJqGcNqqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-B2e0lhOmNU-qi2sTrzxVQA-1; Wed, 02 Jun 2021 14:57:58 -0400
X-MC-Unique: B2e0lhOmNU-qi2sTrzxVQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500BC802690;
 Wed,  2 Jun 2021 18:57:56 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-159.ams2.redhat.com [10.36.114.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6842110074EF;
 Wed,  2 Jun 2021 18:57:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] virtio-mem: prioritize unplug from ZONE_MOVABLE in Sub
 Block Mode
Date: Wed,  2 Jun 2021 20:57:18 +0200
Message-Id: <20210602185720.31821-6-david@redhat.com>
In-Reply-To: <20210602185720.31821-1-david@redhat.com>
References: <20210602185720.31821-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
 Marek Kedzierski <mkedzier@redhat.com>, Hui Zhu <teawater@gmail.com>,
 Oscar Salvador <osalvador@suse.de>
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

Until now, memory provided by a single virtio-mem device was usually
either onlined completely to ZONE_MOVABLE (online_movable) or to
ZONE_NORMAL (online_kernel); however, that will change in the future.

There are two reasons why we want to track to which zone a memory blocks
belongs to and prioritize ZONE_MOVABLE blocks:

1) Memory managed by ZONE_MOVABLE can more likely get unplugged, therefore,
   resulting in a faster memory hotunplug process. Further, we can more
   reliably unplug and remove complete memory blocks, removing metadata
   allocated for the whole memory block.

2) We want to avoid corner cases where unplugging with the current scheme
   (highest to lowest address) could result in accidential zone imbalances,
   whereby we remove too much ZONE_NORMAL memory for ZONE_MOVABLE memory
   of the same device.

Let's track the zone via memory block states and try unplug from
ZONE_MOVABLE first. Rename VIRTIO_MEM_SBM_MB_ONLINE* to
VIRTIO_MEM_SBM_MB_KERNEL* to avoid even longer state names.

In commit 27f852795a06 ("virtio-mem: don't special-case ZONE_MOVABLE"),
we removed slightly similar tracking for fully plugged memory blocks to
support unplugging from ZONE_MOVABLE at all -- as we didn't allow partially
plugged memory blocks in ZONE_MOVABLE before that. That commit already
mentioned "In the future, we might want to remember the zone again and use
the information when (un)plugging memory."

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 72 ++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index d54bb34a7ed8..156a79ceb9fc 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -75,10 +75,14 @@ enum virtio_mem_sbm_mb_state {
 	VIRTIO_MEM_SBM_MB_OFFLINE,
 	/* Partially plugged, fully added to Linux, offline. */
 	VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL,
-	/* Fully plugged, fully added to Linux, online. */
-	VIRTIO_MEM_SBM_MB_ONLINE,
-	/* Partially plugged, fully added to Linux, online. */
-	VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL,
+	/* Fully plugged, fully added to Linux, onlined to a kernel zone. */
+	VIRTIO_MEM_SBM_MB_KERNEL,
+	/* Partially plugged, fully added to Linux, online to a kernel zone */
+	VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL,
+	/* Fully plugged, fully added to Linux, onlined to ZONE_MOVABLE. */
+	VIRTIO_MEM_SBM_MB_MOVABLE,
+	/* Partially plugged, fully added to Linux, onlined to ZONE_MOVABLE. */
+	VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL,
 	VIRTIO_MEM_SBM_MB_COUNT
 };
 
@@ -832,11 +836,13 @@ static void virtio_mem_sbm_notify_offline(struct virtio_mem *vm,
 					  unsigned long mb_id)
 {
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
-	case VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL:
+	case VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL:
+	case VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL:
 		virtio_mem_sbm_set_mb_state(vm, mb_id,
 					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
 		break;
-	case VIRTIO_MEM_SBM_MB_ONLINE:
+	case VIRTIO_MEM_SBM_MB_KERNEL:
+	case VIRTIO_MEM_SBM_MB_MOVABLE:
 		virtio_mem_sbm_set_mb_state(vm, mb_id,
 					    VIRTIO_MEM_SBM_MB_OFFLINE);
 		break;
@@ -847,21 +853,29 @@ static void virtio_mem_sbm_notify_offline(struct virtio_mem *vm,
 }
 
 static void virtio_mem_sbm_notify_online(struct virtio_mem *vm,
-					 unsigned long mb_id)
+					 unsigned long mb_id,
+					 unsigned long start_pfn)
 {
+	const bool is_movable = page_zonenum(pfn_to_page(start_pfn)) ==
+				ZONE_MOVABLE;
+	int new_state;
+
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
 	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
-		virtio_mem_sbm_set_mb_state(vm, mb_id,
-					VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL);
+		new_state = VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL;
+		if (is_movable)
+			new_state = VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL;
 		break;
 	case VIRTIO_MEM_SBM_MB_OFFLINE:
-		virtio_mem_sbm_set_mb_state(vm, mb_id,
-					    VIRTIO_MEM_SBM_MB_ONLINE);
+		new_state = VIRTIO_MEM_SBM_MB_KERNEL;
+		if (is_movable)
+			new_state = VIRTIO_MEM_SBM_MB_MOVABLE;
 		break;
 	default:
 		BUG();
 		break;
 	}
+	virtio_mem_sbm_set_mb_state(vm, mb_id, new_state);
 }
 
 static void virtio_mem_sbm_notify_going_offline(struct virtio_mem *vm,
@@ -1015,7 +1029,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		break;
 	case MEM_ONLINE:
 		if (vm->in_sbm)
-			virtio_mem_sbm_notify_online(vm, id);
+			virtio_mem_sbm_notify_online(vm, id, mhp->start_pfn);
 
 		atomic64_sub(size, &vm->offline_size);
 		/*
@@ -1626,7 +1640,8 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
 static int virtio_mem_sbm_plug_request(struct virtio_mem *vm, uint64_t diff)
 {
 	const int mb_states[] = {
-		VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL,
+		VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL,
+		VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL,
 		VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL,
 	};
 	uint64_t nb_sb = diff / vm->sbm.sb_size;
@@ -1843,6 +1858,7 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 					   int count)
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size) * count;
+	const int old_state = virtio_mem_sbm_get_mb_state(vm, mb_id);
 	unsigned long start_pfn;
 	int rc;
 
@@ -1861,8 +1877,17 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 		return rc;
 	}
 
-	virtio_mem_sbm_set_mb_state(vm, mb_id,
-				    VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL);
+	switch (old_state) {
+	case VIRTIO_MEM_SBM_MB_KERNEL:
+		virtio_mem_sbm_set_mb_state(vm, mb_id,
+					    VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL);
+		break;
+	case VIRTIO_MEM_SBM_MB_MOVABLE:
+		virtio_mem_sbm_set_mb_state(vm, mb_id,
+					    VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL);
+		break;
+	}
+
 	return 0;
 }
 
@@ -1948,8 +1973,10 @@ static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
 	const int old_state = virtio_mem_sbm_get_mb_state(vm, mb_id);
 
 	switch (old_state) {
-	case VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL:
-	case VIRTIO_MEM_SBM_MB_ONLINE:
+	case VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL:
+	case VIRTIO_MEM_SBM_MB_KERNEL:
+	case VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL:
+	case VIRTIO_MEM_SBM_MB_MOVABLE:
 		return virtio_mem_sbm_unplug_any_sb_online(vm, mb_id, nb_sb);
 	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
 	case VIRTIO_MEM_SBM_MB_OFFLINE:
@@ -1963,8 +1990,10 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	const int mb_states[] = {
 		VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL,
 		VIRTIO_MEM_SBM_MB_OFFLINE,
-		VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL,
-		VIRTIO_MEM_SBM_MB_ONLINE,
+		VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL,
+		VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL,
+		VIRTIO_MEM_SBM_MB_MOVABLE,
+		VIRTIO_MEM_SBM_MB_KERNEL,
 	};
 	uint64_t nb_sb = diff / vm->sbm.sb_size;
 	unsigned long mb_id;
@@ -1982,7 +2011,10 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 
 	/*
 	 * We try unplug from partially plugged blocks first, to try removing
-	 * whole memory blocks along with metadata.
+	 * whole memory blocks along with metadata. We prioritize ZONE_MOVABLE
+	 * as it's more reliable to unplug memory and remove whole memory
+	 * blocks, and we don't want to trigger a zone imbalances by
+	 * accidentially removing too much kernel memory.
 	 */
 	for (i = 0; i < ARRAY_SIZE(mb_states); i++) {
 		virtio_mem_sbm_for_each_mb_rev(vm, mb_id, mb_states[i]) {
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
