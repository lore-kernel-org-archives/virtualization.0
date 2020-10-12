Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6934C43457
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:55:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51412221EB
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXjbWBfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51412221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F6D987492;
	Mon, 12 Oct 2020 12:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zu6MUl+wGWW6; Mon, 12 Oct 2020 12:54:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2231C873D5;
	Mon, 12 Oct 2020 12:54:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05451C07FF;
	Mon, 12 Oct 2020 12:54:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEE8AC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C65B185F79
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9e0BgWDfg_6N
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 967E185F6F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602507295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lNgGPuUWhHPLbbNwUf6slTr9Mpg9CiMj0jLIC7eI5M=;
 b=iXjbWBfvQvmeP8wJIUFb2MBC8qm35JKQsRwUdUO/R9Ac34sxkJCmhWXjdgkYQDTyd7UGrB
 JUerIE/bG4UIFTJHQu5pVMb6vkzw98k2+PmMJ9Hxt7cUI71ubMU/Aa4TaiOwQFdKhIspiN
 zCFBc9OT+ztb36R8KLkXwp9ZqmZwdl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-h6Re677iMwiYv_T7k_tQsA-1; Mon, 12 Oct 2020 08:54:53 -0400
X-MC-Unique: h6Re677iMwiYv_T7k_tQsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E23180F058;
 Mon, 12 Oct 2020 12:54:51 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B843B60C07;
 Mon, 12 Oct 2020 12:54:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/29] virtio-mem: generalize handling when memory is
 getting onlined deferred
Date: Mon, 12 Oct 2020 14:53:04 +0200
Message-Id: <20201012125323.17509-11-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
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

We don't want to add too much memory when it's not getting onlined
immediately, to avoid running OOM. Generalize the handling, to avoid
making use of memory block states. Use a threshold of 1 GiB for now.

Properly adjust the offline size when adding/removing memory. As we are
not always protected by a lock when touching the offline size, use an
atomic64_t. We don't care about races (e.g., someone offlining memory
while we are adding more), only about consistent values.

(1 GiB needs a memmap of ~16MiB - which sounds reasonable even for
 setups with little boot memory and (possibly) one virtio-mem device per
 node)

We don't want to retrigger when onlining is caused immediately by our
action (e.g., adding memory which immediately gets onlined), so use a
flag to indicate if the workqueue is active and use that as an
indicator whether to trigger a retry.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 95 ++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 8ea00f0b2ecd..cb2e8f254650 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -51,6 +51,7 @@ struct virtio_mem {
 
 	/* Workqueue that processes the plug/unplug requests. */
 	struct work_struct wq;
+	atomic_t wq_active;
 	atomic_t config_changed;
 
 	/* Virtqueue for guest->host requests. */
@@ -99,7 +100,15 @@ struct virtio_mem {
 
 	/* Summary of all memory block states. */
 	unsigned long nb_mb_state[VIRTIO_MEM_MB_STATE_COUNT];
-#define VIRTIO_MEM_NB_OFFLINE_THRESHOLD		10
+
+	/*
+	 * We don't want to add too much memory if it's not getting onlined,
+	 * to avoid running OOM. Besides this threshold, we allow to have at
+	 * least two offline blocks at a time (whatever is bigger).
+	 */
+#define VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD		(1024 * 1024 * 1024)
+	atomic64_t offline_size;
+	uint64_t offline_threshold;
 
 	/*
 	 * One byte state per memory block.
@@ -393,6 +402,18 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
 	return 0;
 }
 
+/*
+ * Test if we could add memory without creating too much offline memory -
+ * to avoid running OOM if memory is getting onlined deferred.
+ */
+static bool virtio_mem_could_add_memory(struct virtio_mem *vm, uint64_t size)
+{
+	if (WARN_ON_ONCE(size > vm->offline_threshold))
+		return false;
+
+	return atomic64_read(&vm->offline_size) + size <= vm->offline_threshold;
+}
+
 /*
  * Try to add a memory block to Linux. This will usually only fail
  * if out of memory.
@@ -405,6 +426,8 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
 static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	const uint64_t size = memory_block_size_bytes();
+	int rc;
 
 	/*
 	 * When force-unloading the driver and we still have memory added to
@@ -418,10 +441,13 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 	}
 
 	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
-	return add_memory_driver_managed(vm->nid, addr,
-					 memory_block_size_bytes(),
-					 vm->resource_name,
-					 MEMHP_MERGE_RESOURCE);
+	/* Memory might get onlined immediately. */
+	atomic64_add(size, &vm->offline_size);
+	rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
+				       MEMHP_MERGE_RESOURCE);
+	if (rc)
+		atomic64_sub(size, &vm->offline_size);
+	return rc;
 }
 
 /*
@@ -436,16 +462,19 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	const uint64_t size = memory_block_size_bytes();
 	int rc;
 
 	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
-	rc = remove_memory(vm->nid, addr, memory_block_size_bytes());
-	if (!rc)
+	rc = remove_memory(vm->nid, addr, size);
+	if (!rc) {
+		atomic64_sub(size, &vm->offline_size);
 		/*
 		 * We might have freed up memory we can now unplug, retry
 		 * immediately instead of waiting.
 		 */
 		virtio_mem_retry(vm);
+	}
 	return rc;
 }
 
@@ -461,18 +490,20 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	const uint64_t size = memory_block_size_bytes();
 	int rc;
 
 	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
 		mb_id);
-	rc = offline_and_remove_memory(vm->nid, addr,
-				       memory_block_size_bytes());
-	if (!rc)
+	rc = offline_and_remove_memory(vm->nid, addr, size);
+	if (!rc) {
+		atomic64_sub(size, &vm->offline_size);
 		/*
 		 * We might have freed up memory we can now unplug, retry
 		 * immediately instead of waiting.
 		 */
 		virtio_mem_retry(vm);
+	}
 	return rc;
 }
 
@@ -555,8 +586,6 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
 
 static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
 {
-	unsigned long nb_offline;
-
 	switch (virtio_mem_mb_get_state(vm, mb_id)) {
 	case VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL:
 		virtio_mem_mb_set_state(vm, mb_id,
@@ -569,12 +598,6 @@ static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
 		BUG();
 		break;
 	}
-	nb_offline = vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] +
-		     vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL];
-
-	/* see if we can add new blocks now that we onlined one block */
-	if (nb_offline == VIRTIO_MEM_NB_OFFLINE_THRESHOLD - 1)
-		virtio_mem_retry(vm);
 }
 
 static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
@@ -688,6 +711,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 	case MEM_OFFLINE:
 		virtio_mem_notify_offline(vm, mb_id);
 
+		atomic64_add(size, &vm->offline_size);
 		/*
 		 * Trigger the workqueue. Now that we have some offline memory,
 		 * maybe we can handle pending unplug requests.
@@ -700,6 +724,18 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		break;
 	case MEM_ONLINE:
 		virtio_mem_notify_online(vm, mb_id);
+
+		atomic64_sub(size, &vm->offline_size);
+		/*
+		 * Start adding more memory once we onlined half of our
+		 * threshold. Don't trigger if it's possibly due to our actipn
+		 * (e.g., us adding memory which gets onlined immediately from
+		 * the core).
+		 */
+		if (!atomic_read(&vm->wq_active) &&
+		    virtio_mem_could_add_memory(vm, vm->offline_threshold / 2))
+			virtio_mem_retry(vm);
+
 		vm->hotplug_active = false;
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
@@ -1060,18 +1096,6 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
 	return 0;
 }
 
-/*
- * Don't add too many blocks that are not onlined yet to avoid running OOM.
- */
-static bool virtio_mem_too_many_mb_offline(struct virtio_mem *vm)
-{
-	unsigned long nb_offline;
-
-	nb_offline = vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] +
-		     vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL];
-	return nb_offline >= VIRTIO_MEM_NB_OFFLINE_THRESHOLD;
-}
-
 /*
  * Try to plug the desired number of subblocks and add the memory block
  * to Linux.
@@ -1225,7 +1249,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 
 	/* Try to plug and add unused blocks */
 	virtio_mem_for_each_mb_state(vm, mb_id, VIRTIO_MEM_MB_STATE_UNUSED) {
-		if (virtio_mem_too_many_mb_offline(vm))
+		if (!virtio_mem_could_add_memory(vm, memory_block_size_bytes()))
 			return -ENOSPC;
 
 		rc = virtio_mem_mb_plug_and_add(vm, mb_id, &nb_sb);
@@ -1236,7 +1260,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 
 	/* Try to prepare, plug and add new blocks */
 	while (nb_sb) {
-		if (virtio_mem_too_many_mb_offline(vm))
+		if (!virtio_mem_could_add_memory(vm, memory_block_size_bytes()))
 			return -ENOSPC;
 
 		rc = virtio_mem_prepare_next_mb(vm, &mb_id);
@@ -1536,6 +1560,7 @@ static void virtio_mem_run_wq(struct work_struct *work)
 	if (vm->broken)
 		return;
 
+	atomic_set(&vm->wq_active, 1);
 retry:
 	rc = 0;
 
@@ -1596,6 +1621,8 @@ static void virtio_mem_run_wq(struct work_struct *work)
 			"unknown error, marking device broken: %d\n", rc);
 		vm->broken = true;
 	}
+
+	atomic_set(&vm->wq_active, 0);
 }
 
 static enum hrtimer_restart virtio_mem_timer_expired(struct hrtimer *timer)
@@ -1704,6 +1731,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
 						   memory_block_size_bytes());
 	vm->next_mb_id = vm->first_mb_id;
 
+	/* Prepare the offline threshold - make sure we can add two blocks. */
+	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
+				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
+
 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
 	dev_info(&vm->vdev->dev, "device block size: 0x%llx",
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
