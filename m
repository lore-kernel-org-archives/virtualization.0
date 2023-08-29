Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E11AC71153
	for <virtualization@archiver.kernel.org>; Tue, 29 Aug 2023 13:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B24ED4116C;
	Tue, 29 Aug 2023 13:32:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B24ED4116C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c3lKlYLj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VsCqMHdtE94o; Tue, 29 Aug 2023 13:32:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0AB6E4107F;
	Tue, 29 Aug 2023 13:32:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AB6E4107F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA32EC0039;
	Tue, 29 Aug 2023 13:32:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62050C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D4BD41145
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D4BD41145
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BNxMxUTPNLSh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:29 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56A80410A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56A80410A9
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8F49B656DC;
 Tue, 29 Aug 2023 13:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C17CC433CA;
 Tue, 29 Aug 2023 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693315948;
 bh=dy4c5VgYmzO+wokbgPqiCexGvmUpWCAm+FpqFxBYUKk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c3lKlYLjGntIDvc3AQDFcCK/q32CQw24XRaa37oW9YOmfdS/4N4XHHmkx7nytuoGx
 3ihgaS4joPIXzM5ASSQHd+K9AdU5m3UlmUU/I7O4UMvbF9tph1iIU/hA9JGDGMkvDs
 4RFekv7zWfbsCikJvgLloSO6DYv4gk9Qyw4ozTOI5WqAFXsdS2VBMDxMExkb0Bfw7+
 qbcBBSOlSootYBq+74W/NM1qUZ0vIh1PGfWOyZF34WOXuK58hKao/XC72kRZVif567
 HkCSDJwBiT88DZBbFpUqNrYszEPKAHTZYa+k20pb1xPJi2/pwJEJc/nNPVKQj6AyTM
 asCzOQd8C5XGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 08/17] virtio-mem: keep retrying on
 offline_and_remove_memory() errors in Sub Block Mode (SBM)
Date: Tue, 29 Aug 2023 09:31:55 -0400
Message-Id: <20230829133211.519957-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Cc: Sasha Levin <sashal@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

From: David Hildenbrand <david@redhat.com>

[ Upstream commit a31648fd4f96fbe0a4d0aeb16b57a2405c6943c0 ]

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
Message-Id: <20230713145551.2824980-4-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c | 92 +++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1a76ba2bc118c..a5cf92e3e5af2 100644
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
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
