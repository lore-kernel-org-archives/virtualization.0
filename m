Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B9C388F7
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA14722240
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWRdWdWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA14722240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 29BA62E1F2;
	Thu, 12 Nov 2020 13:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5HAXUBBBXyiQ; Thu, 12 Nov 2020 13:39:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A8AAE2E1ED;
	Thu, 12 Nov 2020 13:39:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E73DC088B;
	Thu, 12 Nov 2020 13:39:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D335BC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CDFC986BCB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7znMwSYsscAk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D03B385C77
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQWuQpB4pjLl90rK0Omw5u5bMcOOotDzg31ONQIX8/s=;
 b=LWRdWdWeH3WLVb8psDg40L+WoJQZuIYjPqRstO7yGJ/z6ZTWmNzPDp3pIhph4QzJX23geq
 fA7UyGyqAmJKGsWpiHRr5x5bKEI0W1tIK/svL8Wy09X65Sw6lja6DEWTvQuNQfux5xgTpO
 i6F0iL1BFsIcPuhM4BB0f+/KrJ5xAIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-EBi2ESqeMIC6rZ_bmhHLXA-1; Thu, 12 Nov 2020 08:39:41 -0500
X-MC-Unique: EBi2ESqeMIC6rZ_bmhHLXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8F0818BA28E;
 Thu, 12 Nov 2020 13:39:39 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46C9275132;
 Thu, 12 Nov 2020 13:39:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/29] virtio-mem: factor out adding/removing memory from
 Linux
Date: Thu, 12 Nov 2020 14:38:10 +0100
Message-Id: <20201112133815.13332-25-david@redhat.com>
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

Let's use wrappers for the low-level functions that dev_dbg/dev_warn
and work on addr + size, such that we can reuse them for adding/removing
in other granularity.

We only warn when adding memory failed, because that's something to pay
attention to. We won't warn when removing failed, we'll reuse that in
racy context soon (and we do have proper BUG_ON() statements in the
current cases where it must never happen).

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 107 ++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 34 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index cdcf67e55a56..95fa0262af1d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -451,18 +451,16 @@ static bool virtio_mem_could_add_memory(struct virtio_mem *vm, uint64_t size)
 }
 
 /*
- * Try to add a memory block to Linux. This will usually only fail
- * if out of memory.
+ * Try adding memory to Linux. Will usually only fail if out of memory.
  *
  * Must not be called with the vm->hotplug_mutex held (possible deadlock with
  * onlining code).
  *
- * Will not modify the state of the memory block.
+ * Will not modify the state of memory blocks in virtio-mem.
  */
-static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
+static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
+				 uint64_t size)
 {
-	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	const uint64_t size = memory_block_size_bytes();
 	int rc;
 
 	/*
@@ -476,32 +474,50 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 			return -ENOMEM;
 	}
 
-	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
+	dev_dbg(&vm->vdev->dev, "adding memory: 0x%llx - 0x%llx\n", addr,
+		addr + size - 1);
 	/* Memory might get onlined immediately. */
 	atomic64_add(size, &vm->offline_size);
 	rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
 				       MEMHP_MERGE_RESOURCE);
-	if (rc)
+	if (rc) {
 		atomic64_sub(size, &vm->offline_size);
+		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
+		/*
+		 * TODO: Linux MM does not properly clean up yet in all cases
+		 * where adding of memory failed - especially on -ENOMEM.
+		 */
+	}
 	return rc;
 }
 
 /*
- * Try to remove a memory block from Linux. Will only fail if the memory block
- * is not offline.
+ * See virtio_mem_add_memory(): Try adding a single Linux memory block.
+ */
+static int virtio_mem_sbm_add_mb(struct virtio_mem *vm, unsigned long mb_id)
+{
+	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	const uint64_t size = memory_block_size_bytes();
+
+	return virtio_mem_add_memory(vm, addr, size);
+}
+
+/*
+ * Try removing memory from Linux. Will only fail if memory blocks aren't
+ * offline.
  *
  * Must not be called with the vm->hotplug_mutex held (possible deadlock with
  * onlining code).
  *
- * Will not modify the state of the memory block.
+ * Will not modify the state of memory blocks in virtio-mem.
  */
-static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
+static int virtio_mem_remove_memory(struct virtio_mem *vm, uint64_t addr,
+				    uint64_t size)
 {
-	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	const uint64_t size = memory_block_size_bytes();
 	int rc;
 
-	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
+	dev_dbg(&vm->vdev->dev, "removing memory: 0x%llx - 0x%llx\n", addr,
+		addr + size - 1);
 	rc = remove_memory(vm->nid, addr, size);
 	if (!rc) {
 		atomic64_sub(size, &vm->offline_size);
@@ -510,27 +526,41 @@ static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
 		 * immediately instead of waiting.
 		 */
 		virtio_mem_retry(vm);
+	} else {
+		dev_dbg(&vm->vdev->dev, "removing memory failed: %d\n", rc);
 	}
 	return rc;
 }
 
 /*
- * Try to offline and remove a memory block from Linux.
+ * See virtio_mem_remove_memory(): Try removing a single Linux memory block.
+ */
+static int virtio_mem_sbm_remove_mb(struct virtio_mem *vm, unsigned long mb_id)
+{
+	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	const uint64_t size = memory_block_size_bytes();
+
+	return virtio_mem_remove_memory(vm, addr, size);
+}
+
+/*
+ * Try offlining and removing memory from Linux.
  *
  * Must not be called with the vm->hotplug_mutex held (possible deadlock with
  * onlining code).
  *
- * Will not modify the state of the memory block.
+ * Will not modify the state of memory blocks in virtio-mem.
  */
-static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
-					    unsigned long mb_id)
+static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
+						uint64_t addr,
+						uint64_t size)
 {
-	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	const uint64_t size = memory_block_size_bytes();
 	int rc;
 
-	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
-		mb_id);
+	dev_dbg(&vm->vdev->dev,
+		"offlining and removing memory: 0x%llx - 0x%llx\n", addr,
+		addr + size - 1);
+
 	rc = offline_and_remove_memory(vm->nid, addr, size);
 	if (!rc) {
 		atomic64_sub(size, &vm->offline_size);
@@ -539,10 +569,26 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
 		 * immediately instead of waiting.
 		 */
 		virtio_mem_retry(vm);
+	} else {
+		dev_dbg(&vm->vdev->dev,
+			"offlining and removing memory failed: %d\n", rc);
 	}
 	return rc;
 }
 
+/*
+ * See virtio_mem_offline_and_remove_memory(): Try offlining and removing
+ * a single Linux memory block.
+ */
+static int virtio_mem_sbm_offline_and_remove_mb(struct virtio_mem *vm,
+						unsigned long mb_id)
+{
+	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	const uint64_t size = memory_block_size_bytes();
+
+	return virtio_mem_offline_and_remove_memory(vm, addr, size);
+}
+
 /*
  * Trigger the workqueue so the device can perform its magic.
  */
@@ -1248,17 +1294,10 @@ static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
 					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
 
 	/* Add the memory block to linux - if that fails, try to unplug. */
-	rc = virtio_mem_mb_add(vm, mb_id);
+	rc = virtio_mem_sbm_add_mb(vm, mb_id);
 	if (rc) {
 		int new_state = VIRTIO_MEM_SBM_MB_UNUSED;
 
-		dev_err(&vm->vdev->dev,
-			"adding memory block %lu failed with %d\n", mb_id, rc);
-
-		/*
-		 * TODO: Linux MM does not properly clean up yet in all cases
-		 * where adding of memory failed - especially on -ENOMEM.
-		 */
 		if (virtio_mem_sbm_unplug_sb(vm, mb_id, 0, count))
 			new_state = VIRTIO_MEM_SBM_MB_PLUGGED;
 		virtio_mem_sbm_set_mb_state(vm, mb_id, new_state);
@@ -1429,7 +1468,7 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
 					    VIRTIO_MEM_SBM_MB_UNUSED);
 
 		mutex_unlock(&vm->hotplug_mutex);
-		rc = virtio_mem_mb_remove(vm, mb_id);
+		rc = virtio_mem_sbm_remove_mb(vm, mb_id);
 		BUG_ON(rc);
 		mutex_lock(&vm->hotplug_mutex);
 	}
@@ -1522,7 +1561,7 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
 	 */
 	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
 		mutex_unlock(&vm->hotplug_mutex);
-		rc = virtio_mem_mb_offline_and_remove(vm, mb_id);
+		rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
 		mutex_lock(&vm->hotplug_mutex);
 		if (!rc)
 			virtio_mem_sbm_set_mb_state(vm, mb_id,
@@ -2009,7 +2048,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	 */
 	virtio_mem_sbm_for_each_mb(vm, mb_id,
 				   VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
-		rc = virtio_mem_mb_remove(vm, mb_id);
+		rc = virtio_mem_sbm_remove_mb(vm, mb_id);
 		BUG_ON(rc);
 		virtio_mem_sbm_set_mb_state(vm, mb_id,
 					    VIRTIO_MEM_SBM_MB_UNUSED);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
