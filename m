Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56893C04EBE
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:56:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67AF21BE5
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI0K3SGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67AF21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 88108874EB;
	Mon, 12 Oct 2020 12:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id liV2uvL3U8dr; Mon, 12 Oct 2020 12:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 81B3587466;
	Mon, 12 Oct 2020 12:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D28AC07FF;
	Mon, 12 Oct 2020 12:56:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13005C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0FC4086A86
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BfeqWqoGS5GR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A530886A62
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602507373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4bvkUxyyKzISGghN4M2iQ9MP3vmYfGeztwF7KWUS3c=;
 b=hI0K3SGii+hfMx/c+0e6yVPTn1A5tj5jABSU0Pv/Phg6DdYsy0zTcOB48a40ZdA7Q+DMLX
 hFWUCv7yXxbSfPAe4LYVm6LtGX8fZdvbYnua2TCE07GspinWx1/upX0UAenSA0HHmm6HfY
 bWzW0AyygEIwZY+oFpXNBKZuBhr5yj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-33XV-UWMNZG0T9QX1F77UQ-1; Mon, 12 Oct 2020 08:56:12 -0400
X-MC-Unique: 33XV-UWMNZG0T9QX1F77UQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5B67835B49;
 Mon, 12 Oct 2020 12:56:10 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87CF660C07;
 Mon, 12 Oct 2020 12:56:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 20/29] virtio-mem: nb_sb_per_mb and subblock_size are
 specific to Sub Block Mode (SBM)
Date: Mon, 12 Oct 2020 14:53:14 +0200
Message-Id: <20201012125323.17509-21-david@redhat.com>
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

Let's rename to "sbs_per_mb" and "sb_size" and move accordingly.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 96 ++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index fc2b1ff3beed..3a772714fec9 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -96,11 +96,6 @@ struct virtio_mem {
 	/* Maximum region size in bytes. */
 	uint64_t region_size;
 
-	/* The subblock size. */
-	uint64_t subblock_size;
-	/* The number of subblocks per memory block. */
-	uint32_t nb_sb_per_mb;
-
 	/* Id of the first memory block of this device. */
 	unsigned long first_mb_id;
 	/* Id of the last usable memory block of this device. */
@@ -126,6 +121,11 @@ struct virtio_mem {
 	uint64_t offline_threshold;
 
 	struct {
+		/* The subblock size. */
+		uint64_t sb_size;
+		/* The number of subblocks per Linux memory block. */
+		uint32_t sbs_per_mb;
+
 		/* Summary of all memory block states. */
 		unsigned long mb_count[VIRTIO_MEM_SBM_MB_COUNT];
 
@@ -256,7 +256,7 @@ static unsigned long virtio_mem_phys_to_sb_id(struct virtio_mem *vm,
 	const unsigned long mb_id = virtio_mem_phys_to_mb_id(addr);
 	const unsigned long mb_addr = virtio_mem_mb_id_to_phys(mb_id);
 
-	return (addr - mb_addr) / vm->subblock_size;
+	return (addr - mb_addr) / vm->sbm.sb_size;
 }
 
 /*
@@ -334,7 +334,7 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
 static int virtio_mem_sbm_sb_state_bit_nr(struct virtio_mem *vm,
 					  unsigned long mb_id, int sb_id)
 {
-	return (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+	return (mb_id - vm->first_mb_id) * vm->sbm.sbs_per_mb + sb_id;
 }
 
 /*
@@ -397,7 +397,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
 }
 
 /*
- * Find the first unplugged subblock. Returns vm->nb_sb_per_mb in case there is
+ * Find the first unplugged subblock. Returns vm->sbm.sbs_per_mb in case there is
  * none.
  */
 static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
@@ -406,7 +406,7 @@ static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
 	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, 0);
 
 	return find_next_zero_bit(vm->sbm.sb_states,
-				  bit + vm->nb_sb_per_mb, bit) - bit;
+				  bit + vm->sbm.sbs_per_mb, bit) - bit;
 }
 
 /*
@@ -415,8 +415,8 @@ static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
 static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
 {
 	const unsigned long old_nb_mb = vm->next_mb_id - vm->first_mb_id;
-	const unsigned long old_nb_bits = old_nb_mb * vm->nb_sb_per_mb;
-	const unsigned long new_nb_bits = (old_nb_mb + 1) * vm->nb_sb_per_mb;
+	const unsigned long old_nb_bits = old_nb_mb * vm->sbm.sbs_per_mb;
+	const unsigned long new_nb_bits = (old_nb_mb + 1) * vm->sbm.sbs_per_mb;
 	int old_pages = PFN_UP(BITS_TO_LONGS(old_nb_bits) * sizeof(long));
 	int new_pages = PFN_UP(BITS_TO_LONGS(new_nb_bits) * sizeof(long));
 	unsigned long *new_bitmap, *old_bitmap;
@@ -642,15 +642,15 @@ static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
 static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
-	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
+	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
 	unsigned long pfn;
 	int sb_id;
 
-	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
+	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
 		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
-			       sb_id * vm->subblock_size);
+			       sb_id * vm->sbm.sb_size);
 		virtio_mem_fake_offline_going_offline(pfn, nr_pages);
 	}
 }
@@ -658,15 +658,15 @@ static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
 static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
 					     unsigned long mb_id)
 {
-	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
+	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
 	unsigned long pfn;
 	int sb_id;
 
-	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
+	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
 		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
-			       sb_id * vm->subblock_size);
+			       sb_id * vm->sbm.sb_size);
 		virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
 	}
 }
@@ -1079,8 +1079,8 @@ static int virtio_mem_sbm_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
 				  int sb_id, int count)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id) +
-			      sb_id * vm->subblock_size;
-	const uint64_t size = count * vm->subblock_size;
+			      sb_id * vm->sbm.sb_size;
+	const uint64_t size = count * vm->sbm.sb_size;
 	int rc;
 
 	dev_dbg(&vm->vdev->dev, "plugging memory block: %lu : %i - %i\n", mb_id,
@@ -1100,8 +1100,8 @@ static int virtio_mem_sbm_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
 				    int sb_id, int count)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id) +
-			      sb_id * vm->subblock_size;
-	const uint64_t size = count * vm->subblock_size;
+			      sb_id * vm->sbm.sb_size;
+	const uint64_t size = count * vm->sbm.sb_size;
 	int rc;
 
 	dev_dbg(&vm->vdev->dev, "unplugging memory block: %lu : %i - %i\n",
@@ -1128,7 +1128,7 @@ static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
 	int sb_id, count;
 	int rc;
 
-	sb_id = vm->nb_sb_per_mb - 1;
+	sb_id = vm->sbm.sbs_per_mb - 1;
 	while (*nb_sb) {
 		/* Find the next candidate subblock */
 		while (sb_id >= 0 &&
@@ -1163,7 +1163,7 @@ static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
  */
 static int virtio_mem_sbm_unplug_mb(struct virtio_mem *vm, unsigned long mb_id)
 {
-	uint64_t nb_sb = vm->nb_sb_per_mb;
+	uint64_t nb_sb = vm->sbm.sbs_per_mb;
 
 	return virtio_mem_sbm_unplug_any_sb(vm, mb_id, &nb_sb);
 }
@@ -1203,7 +1203,7 @@ static int virtio_mem_sbm_prepare_next_mb(struct virtio_mem *vm,
 static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
 					  unsigned long mb_id, uint64_t *nb_sb)
 {
-	const int count = min_t(int, *nb_sb, vm->nb_sb_per_mb);
+	const int count = min_t(int, *nb_sb, vm->sbm.sbs_per_mb);
 	int rc;
 
 	if (WARN_ON_ONCE(!count))
@@ -1221,7 +1221,7 @@ static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
 	 * Mark the block properly offline before adding it to Linux,
 	 * so the memory notifiers will find the block in the right state.
 	 */
-	if (count == vm->nb_sb_per_mb)
+	if (count == vm->sbm.sbs_per_mb)
 		virtio_mem_sbm_set_mb_state(vm, mb_id,
 					    VIRTIO_MEM_SBM_MB_OFFLINE);
 	else
@@ -1271,11 +1271,11 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
 
 	while (*nb_sb) {
 		sb_id = virtio_mem_sbm_first_unplugged_sb(vm, mb_id);
-		if (sb_id >= vm->nb_sb_per_mb)
+		if (sb_id >= vm->sbm.sbs_per_mb)
 			break;
 		count = 1;
 		while (count < *nb_sb &&
-		       sb_id + count < vm->nb_sb_per_mb &&
+		       sb_id + count < vm->sbm.sbs_per_mb &&
 		       !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id + count, 1))
 			count++;
 
@@ -1288,12 +1288,12 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
 
 		/* fake-online the pages if the memory block is online */
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
-			       sb_id * vm->subblock_size);
-		nr_pages = PFN_DOWN(count * vm->subblock_size);
+			       sb_id * vm->sbm.sb_size);
+		nr_pages = PFN_DOWN(count * vm->sbm.sb_size);
 		virtio_mem_fake_online(pfn, nr_pages);
 	}
 
-	if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+	if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
 		if (online)
 			virtio_mem_sbm_set_mb_state(vm, mb_id,
 						    VIRTIO_MEM_SBM_MB_ONLINE);
@@ -1310,7 +1310,7 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
  */
 static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 {
-	uint64_t nb_sb = diff / vm->subblock_size;
+	uint64_t nb_sb = diff / vm->sbm.sb_size;
 	unsigned long mb_id;
 	int rc;
 
@@ -1393,13 +1393,13 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
 	rc = virtio_mem_sbm_unplug_any_sb(vm, mb_id, nb_sb);
 
 	/* some subblocks might have been unplugged even on failure */
-	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
+	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
 		virtio_mem_sbm_set_mb_state(vm, mb_id,
 					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
 	if (rc)
 		return rc;
 
-	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
 		/*
 		 * Remove the block from Linux - this should never fail.
 		 * Hinder the block from getting onlined by marking it
@@ -1426,12 +1426,12 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 					   unsigned long mb_id, int sb_id,
 					   int count)
 {
-	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size) * count;
+	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size) * count;
 	unsigned long start_pfn;
 	int rc;
 
 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
-			     sb_id * vm->subblock_size);
+			     sb_id * vm->sbm.sb_size);
 
 	rc = virtio_mem_fake_offline(start_pfn, nr_pages);
 	if (rc)
@@ -1467,19 +1467,19 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
 	int rc, sb_id;
 
 	/* If possible, try to unplug the complete block in one shot. */
-	if (*nb_sb >= vm->nb_sb_per_mb &&
-	    virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+	if (*nb_sb >= vm->sbm.sbs_per_mb &&
+	    virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
 		rc = virtio_mem_sbm_unplug_sb_online(vm, mb_id, 0,
-						     vm->nb_sb_per_mb);
+						     vm->sbm.sbs_per_mb);
 		if (!rc) {
-			*nb_sb -= vm->nb_sb_per_mb;
+			*nb_sb -= vm->sbm.sbs_per_mb;
 			goto unplugged;
 		} else if (rc != -EBUSY)
 			return rc;
 	}
 
 	/* Fallback to single subblocks. */
-	for (sb_id = vm->nb_sb_per_mb - 1; sb_id >= 0 && *nb_sb; sb_id--) {
+	for (sb_id = vm->sbm.sbs_per_mb - 1; sb_id >= 0 && *nb_sb; sb_id--) {
 		/* Find the next candidate subblock */
 		while (sb_id >= 0 &&
 		       !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
@@ -1501,7 +1501,7 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
 	 * remove it. This will usually not fail, as no memory is in use
 	 * anymore - however some other notifiers might NACK the request.
 	 */
-	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
 		mutex_unlock(&vm->hotplug_mutex);
 		rc = virtio_mem_mb_offline_and_remove(vm, mb_id);
 		mutex_lock(&vm->hotplug_mutex);
@@ -1518,7 +1518,7 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
  */
 static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 {
-	uint64_t nb_sb = diff / vm->subblock_size;
+	uint64_t nb_sb = diff / vm->sbm.sb_size;
 	unsigned long mb_id;
 	int rc;
 
@@ -1805,11 +1805,11 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-	vm->subblock_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
-				  pageblock_nr_pages) * PAGE_SIZE;
-	vm->subblock_size = max_t(uint64_t, vm->device_block_size,
-				  vm->subblock_size);
-	vm->nb_sb_per_mb = memory_block_size_bytes() / vm->subblock_size;
+	vm->sbm.sb_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
+				pageblock_nr_pages) * PAGE_SIZE;
+	vm->sbm.sb_size = max_t(uint64_t, vm->device_block_size,
+				vm->sbm.sb_size);
+	vm->sbm.sbs_per_mb = memory_block_size_bytes() / vm->sbm.sb_size;
 
 	/* Round up to the next full memory block */
 	vm->first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
@@ -1827,7 +1827,7 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
 		 memory_block_size_bytes());
 	dev_info(&vm->vdev->dev, "subblock size: 0x%llx",
-		 (unsigned long long)vm->subblock_size);
+		 (unsigned long long)vm->sbm.sb_size);
 	if (vm->nid != NUMA_NO_NODE && IS_ENABLED(CONFIG_NUMA))
 		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
