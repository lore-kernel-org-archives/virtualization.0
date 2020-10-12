Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA48AC433DF
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B582076E
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpRkKtYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B582076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7143C2094E;
	Mon, 12 Oct 2020 12:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DyWdAfNL89Ad; Mon, 12 Oct 2020 12:57:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7AB2F207A6;
	Mon, 12 Oct 2020 12:57:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 665D5C07FF;
	Mon, 12 Oct 2020 12:57:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73E23C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 61B8686B1C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ELw4U-1tcShZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 55D0686B06
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602507454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GC8VOJiDkG6ErANTb/WlUuIOAAehbykdKgaBnzsSpVw=;
 b=ZpRkKtYUc7BCN76AUBNJ4Yg++gk+n7+LVeUDScjNnKre9sBWa5DSnWOGU8bkwCbKobsA4U
 b2PjTC95yJpXvxib2V4FZ3N8snQyl6tzXn3ckPxqKZqQcnPBjHzuUD2SVl++CTviHDY81j
 MvwdSYjScudn+b6RBIaXqLz/AS/JJq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-pUaSbvp5NBOvnPhuhjfrhg-1; Mon, 12 Oct 2020 08:57:30 -0400
X-MC-Unique: pUaSbvp5NBOvnPhuhjfrhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E74851074658;
 Mon, 12 Oct 2020 12:57:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5621160C07;
 Mon, 12 Oct 2020 12:57:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 28/29] virtio-mem: Big Block Mode (BBM) - basic memory
 hotunplug
Date: Mon, 12 Oct 2020 14:53:22 +0200
Message-Id: <20201012125323.17509-29-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
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

Let's try to unplug completely offline big blocks first. Then, (if
enabled via unplug_offline) try to offline and remove whole big blocks.

No locking necessary - we can deal with concurrent onlining/offlining
just fine.

Note1: This is sub-optimal and might be dangerous in some environments: we
could end up in an infinite loop when offlining (e.g., long-term pinnings),
similar as with DIMMs. We'll introduce safe memory hotunplug via
fake-offlining next, and use this basic mode only when explicitly enabled.

Note2: Without ZONE_MOVABLE, memory unplug will be extremely unreliable
with bigger block sizes.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 156 +++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 94cf44b15cbf..6bcd0acbff32 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -388,6 +388,12 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
 	     _bb_id++) \
 		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
 
+#define virtio_mem_bbm_for_each_bb_rev(_vm, _bb_id, _state) \
+	for (_bb_id = vm->bbm.next_bb_id - 1; \
+	     _bb_id >= vm->bbm.first_bb_id && _vm->bbm.bb_count[_state]; \
+	     _bb_id--) \
+		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
+
 /*
  * Set the state of a memory block, taking care of the state counter.
  */
@@ -685,6 +691,18 @@ static int virtio_mem_sbm_remove_mb(struct virtio_mem *vm, unsigned long mb_id)
 	return virtio_mem_remove_memory(vm, addr, size);
 }
 
+/*
+ * See virtio_mem_remove_memory(): Try to remove all Linux memory blocks covered
+ * by the big block.
+ */
+static int virtio_mem_bbm_remove_bb(struct virtio_mem *vm, unsigned long bb_id)
+{
+	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
+	const uint64_t size = vm->bbm.bb_size;
+
+	return virtio_mem_remove_memory(vm, addr, size);
+}
+
 /*
  * Try offlining and removing memory from Linux.
  *
@@ -731,6 +749,19 @@ static int virtio_mem_sbm_offline_and_remove_mb(struct virtio_mem *vm,
 	return virtio_mem_offline_and_remove_memory(vm, addr, size);
 }
 
+/*
+ * See virtio_mem_offline_and_remove_memory(): Try to offline and remove a
+ * all Linux memory blocks covered by the big block.
+ */
+static int virtio_mem_bbm_offline_and_remove_bb(struct virtio_mem *vm,
+						unsigned long bb_id)
+{
+	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
+	const uint64_t size = vm->bbm.bb_size;
+
+	return virtio_mem_offline_and_remove_memory(vm, addr, size);
+}
+
 /*
  * Trigger the workqueue so the device can perform its magic.
  */
@@ -1928,6 +1959,129 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	return rc;
 }
 
+/*
+ * Try to offline and remove a big block from Linux and unplug it. Will fail
+ * with -EBUSY if some memory is busy and cannot get unplugged.
+ *
+ * Will modify the state of the memory block. Might temporarily drop the
+ * hotplug_mutex.
+ */
+static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
+						       unsigned long bb_id)
+{
+	int rc;
+
+	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
+			 VIRTIO_MEM_BBM_BB_ADDED))
+		return -EINVAL;
+
+	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
+	if (rc)
+		return rc;
+
+	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
+	if (rc)
+		virtio_mem_bbm_set_bb_state(vm, bb_id,
+					    VIRTIO_MEM_BBM_BB_PLUGGED);
+	else
+		virtio_mem_bbm_set_bb_state(vm, bb_id,
+					    VIRTIO_MEM_BBM_BB_UNUSED);
+	return rc;
+}
+
+/*
+ * Try to remove a big block from Linux and unplug it. Will fail with
+ * -EBUSY if some memory is online.
+ *
+ * Will modify the state of the memory block.
+ */
+static int virtio_mem_bbm_remove_and_unplug_bb(struct virtio_mem *vm,
+					       unsigned long bb_id)
+{
+	int rc;
+
+	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
+			 VIRTIO_MEM_BBM_BB_ADDED))
+		return -EINVAL;
+
+	rc = virtio_mem_bbm_remove_bb(vm, bb_id);
+	if (rc)
+		return -EBUSY;
+
+	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
+	if (rc)
+		virtio_mem_bbm_set_bb_state(vm, bb_id,
+					    VIRTIO_MEM_BBM_BB_PLUGGED);
+	else
+		virtio_mem_bbm_set_bb_state(vm, bb_id,
+					    VIRTIO_MEM_BBM_BB_UNUSED);
+	return rc;
+}
+
+/*
+ * Test if a big block is completely offline.
+ */
+static bool virtio_mem_bbm_bb_is_offline(struct virtio_mem *vm,
+					 unsigned long bb_id)
+{
+	const unsigned long start_pfn = PFN_DOWN(virtio_mem_bb_id_to_phys(vm, bb_id));
+	const unsigned long nr_pages = PFN_DOWN(vm->bbm.bb_size);
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < start_pfn + nr_pages;
+	     pfn += PAGES_PER_SECTION) {
+		if (pfn_to_online_page(pfn))
+			return false;
+	}
+
+	return true;
+}
+
+static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
+{
+	uint64_t nb_bb = diff / vm->bbm.bb_size;
+	uint64_t bb_id;
+	int rc;
+
+	if (!nb_bb)
+		return 0;
+
+	/* Try to unplug completely offline big blocks first. */
+	virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
+		cond_resched();
+		/*
+		 * As we're holding no locks, this check is racy as memory
+		 * can get onlined in the meantime - but we'll fail gracefully.
+		 */
+		if (!virtio_mem_bbm_bb_is_offline(vm, bb_id))
+			continue;
+		rc = virtio_mem_bbm_remove_and_unplug_bb(vm, bb_id);
+		if (rc == -EBUSY)
+			continue;
+		if (!rc)
+			nb_bb--;
+		if (rc || !nb_bb)
+			return rc;
+	}
+
+	if (!unplug_online)
+		return 0;
+
+	/* Try to unplug any big blocks. */
+	virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
+		cond_resched();
+		rc = virtio_mem_bbm_offline_remove_and_unplug_bb(vm, bb_id);
+		if (rc == -EBUSY)
+			continue;
+		if (!rc)
+			nb_bb--;
+		if (rc || !nb_bb)
+			return rc;
+	}
+
+	return nb_bb ? -EBUSY : 0;
+}
+
 /*
  * Try to unplug the requested amount of memory.
  */
@@ -1935,7 +2089,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 {
 	if (vm->in_sbm)
 		return virtio_mem_sbm_unplug_request(vm, diff);
-	return -EBUSY;
+	return virtio_mem_bbm_unplug_request(vm, diff);
 }
 
 /*
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
