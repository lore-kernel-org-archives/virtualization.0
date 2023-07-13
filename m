Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57D5C00528
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFA1960B98;
	Thu, 13 Jul 2023 14:56:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFA1960B98
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IE0nWF0E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yK38ceph_4AV; Thu, 13 Jul 2023 14:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CD7A613BC;
	Thu, 13 Jul 2023 14:56:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CD7A613BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00852C0DD8;
	Thu, 13 Jul 2023 14:56:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7A7BC0DD8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2F34613A2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2F34613A2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id itfYnS749oZ4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF69D60B98
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF69D60B98
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689260162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/51NS5IdbGhAF1WTe4etoP/bWkQWV6fSApbrFXQZ0Fk=;
 b=IE0nWF0EfZ0FTGN6xNJOBQT7m6GoeWBAsCnEHXsT6+fqxnMItzYmM7IYZ7m7own95iOCW9
 Kx7bASwrIYD6eZwulKeDfC6ivkA0NEx7s2MlIctllbYgv0W5hgqmSHGcA3dkrYSe9ZhlIg
 J1A5VY7LGoSfnU/wpDk/mbKvXkzrTtU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-Cnd2LY13MK-Zy4GC5ZFc9w-1; Thu, 13 Jul 2023 10:56:01 -0400
X-MC-Unique: Cnd2LY13MK-Zy4GC5ZFc9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7FA283FC20;
 Thu, 13 Jul 2023 14:56:00 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F036F66D1;
 Thu, 13 Jul 2023 14:55:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] virtio-mem: keep retrying on
 offline_and_remove_memory() errors in Sub Block Mode (SBM)
Date: Thu, 13 Jul 2023 16:55:50 +0200
Message-ID: <20230713145551.2824980-4-david@redhat.com>
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

In case offline_and_remove_memory() fails in SBM, we leave a completely
unplugged Linux memory block stick around until we try plugging memory
again. We won't try removing that memory block again.

offline_and_remove_memory() may, for example, fail if we're racing with
another alloc_contig_range() user, if allocating temporary memory fails,
or if some memory notifier rejected the offlining request.

Let's handle that case better, by simple retrying to offline and remove
such memory.

Tested using CONFIG_MEMORY_NOTIFIER_ERROR_INJECT.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 92 +++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1a76ba2bc118..a5cf92e3e5af 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -168,6 +168,13 @@ struct virtio_mem {
 			/* The number of subblocks per Linux memory block. */
 			uint32_t sbs_per_mb;
 
+			/*
+			 * Some of the Linux memory blocks tracked as "partially
+			 * plugged" are completely unplugged and can be offlined
+			 * and removed -- which previously failed.
+			 */
+			bool have_unplugged_mb;
+
 			/* Summary of all memory block states. */
 			unsigned long mb_count[VIRTIO_MEM_SBM_MB_COUNT];
 
@@ -765,6 +772,34 @@ static int virtio_mem_sbm_offline_and_remove_mb(struct virtio_mem *vm,
 	return virtio_mem_offline_and_remove_memory(vm, addr, size);
 }
 
+/*
+ * Try (offlining and) removing memory from Linux in case all subblocks are
+ * unplugged. Can be called on online and offline memory blocks.
+ *
+ * May modify the state of memory blocks in virtio-mem.
+ */
+static int virtio_mem_sbm_try_remove_unplugged_mb(struct virtio_mem *vm,
+						  unsigned long mb_id)
+{
+	int rc;
+
+	/*
+	 * Once all subblocks of a memory block were unplugged, offline and
+	 * remove it.
+	 */
+	if (!virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
+		return 0;
+
+	/* offline_and_remove_memory() works for online and offline memory. */
+	mutex_unlock(&vm->hotplug_mutex);
+	rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
+	mutex_lock(&vm->hotplug_mutex);
+	if (!rc)
+		virtio_mem_sbm_set_mb_state(vm, mb_id,
+					    VIRTIO_MEM_SBM_MB_UNUSED);
+	return rc;
+}
+
 /*
  * See virtio_mem_offline_and_remove_memory(): Try to offline and remove a
  * all Linux memory blocks covered by the big block.
@@ -1988,20 +2023,10 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
 	}
 
 unplugged:
-	/*
-	 * Once all subblocks of a memory block were unplugged, offline and
-	 * remove it. This will usually not fail, as no memory is in use
-	 * anymore - however some other notifiers might NACK the request.
-	 */
-	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
-		mutex_unlock(&vm->hotplug_mutex);
-		rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
-		mutex_lock(&vm->hotplug_mutex);
-		if (!rc)
-			virtio_mem_sbm_set_mb_state(vm, mb_id,
-						    VIRTIO_MEM_SBM_MB_UNUSED);
-	}
-
+	rc = virtio_mem_sbm_try_remove_unplugged_mb(vm, mb_id);
+	if (rc)
+		vm->sbm.have_unplugged_mb = 1;
+	/* Ignore errors, this is not critical. We'll retry later. */
 	return 0;
 }
 
@@ -2253,12 +2278,13 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 
 /*
  * Try to unplug all blocks that couldn't be unplugged before, for example,
- * because the hypervisor was busy.
+ * because the hypervisor was busy. Further, offline and remove any memory
+ * blocks where we previously failed.
  */
-static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
+static int virtio_mem_cleanup_pending_mb(struct virtio_mem *vm)
 {
 	unsigned long id;
-	int rc;
+	int rc = 0;
 
 	if (!vm->in_sbm) {
 		virtio_mem_bbm_for_each_bb(vm, id,
@@ -2280,6 +2306,27 @@ static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
 					    VIRTIO_MEM_SBM_MB_UNUSED);
 	}
 
+	if (!vm->sbm.have_unplugged_mb)
+		return 0;
+
+	/*
+	 * Let's retry (offlining and) removing completely unplugged Linux
+	 * memory blocks.
+	 */
+	vm->sbm.have_unplugged_mb = false;
+
+	mutex_lock(&vm->hotplug_mutex);
+	virtio_mem_sbm_for_each_mb(vm, id, VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL)
+		rc |= virtio_mem_sbm_try_remove_unplugged_mb(vm, id);
+	virtio_mem_sbm_for_each_mb(vm, id, VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL)
+		rc |= virtio_mem_sbm_try_remove_unplugged_mb(vm, id);
+	virtio_mem_sbm_for_each_mb(vm, id, VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL)
+		rc |= virtio_mem_sbm_try_remove_unplugged_mb(vm, id);
+	mutex_unlock(&vm->hotplug_mutex);
+
+	if (rc)
+		vm->sbm.have_unplugged_mb = true;
+	/* Ignore errors, this is not critical. We'll retry later. */
 	return 0;
 }
 
@@ -2361,9 +2408,9 @@ static void virtio_mem_run_wq(struct work_struct *work)
 		virtio_mem_refresh_config(vm);
 	}
 
-	/* Unplug any leftovers from previous runs */
+	/* Cleanup any leftovers from previous runs */
 	if (!rc)
-		rc = virtio_mem_unplug_pending_mb(vm);
+		rc = virtio_mem_cleanup_pending_mb(vm);
 
 	if (!rc && vm->requested_size != vm->plugged_size) {
 		if (vm->requested_size > vm->plugged_size) {
@@ -2375,6 +2422,13 @@ static void virtio_mem_run_wq(struct work_struct *work)
 		}
 	}
 
+	/*
+	 * Keep retrying to offline and remove completely unplugged Linux
+	 * memory blocks.
+	 */
+	if (!rc && vm->in_sbm && vm->sbm.have_unplugged_mb)
+		rc = -EBUSY;
+
 	switch (rc) {
 	case 0:
 		vm->retry_timer_ms = VIRTIO_MEM_RETRY_TIMER_MIN_MS;
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
