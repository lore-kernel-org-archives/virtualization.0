Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE52C2D0A3
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732C322240
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9iw0IXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732C322240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0B4D72E1EA;
	Thu, 12 Nov 2020 13:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id egyxT9Su-51f; Thu, 12 Nov 2020 13:39:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6205E2E1EB;
	Thu, 12 Nov 2020 13:39:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41ACAC088B;
	Thu, 12 Nov 2020 13:39:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B26ACC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A1F02870D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QGJPgs0OKZCI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 692AF870D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SH7/zMuucYc38WKT8Zuy5DdrbkMQ6dVwermbW/0jv8=;
 b=A9iw0IXcfXAinacKO8EgfdhhbzoOfsvHgXN64IHzMchB0DJGjGhJDqPZ6RyiyG82mo+6ck
 mqw2J9w0SoHo0m8MT+jQxZtZKVZsdozTbij/ruiflHHW0gFKRBCK4T/yPL3pMPkWEjk4xt
 qAVWru1qlu7tIKeqcnY6gCOSoiLDH0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-ioUlaChROb-8Yha3I6z71w-1; Thu, 12 Nov 2020 08:39:22 -0500
X-MC-Unique: ioUlaChROb-8Yha3I6z71w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4202809DE6;
 Thu, 12 Nov 2020 13:39:20 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B846475132;
 Thu, 12 Nov 2020 13:39:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/29] virito-mem: subblock states are specific to Sub
 Block Mode (SBM)
Date: Thu, 12 Nov 2020 14:38:05 +0100
Message-Id: <20201112133815.13332-20-david@redhat.com>
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

Let's rename and move accordingly. While at it, rename sb_bitmap to
"sb_states".

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 132 +++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 63 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index c6cc301c78e1..851cddf5c606 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -137,17 +137,23 @@ struct virtio_mem {
 		 * memory in one 4 KiB page.
 		 */
 		uint8_t *mb_states;
-	} sbm;
 
-	/*
-	 * $nb_sb_per_mb bit per memory block. Handled similar to sbm.mb_states.
-	 *
-	 * With 4MB subblocks, we manage 128GB of memory in one page.
-	 */
-	unsigned long *sb_bitmap;
+		/*
+		 * Bitmap: one bit per subblock. Allocated similar to
+		 * sbm.mb_states.
+		 *
+		 * A set bit means the corresponding subblock is plugged,
+		 * otherwise it's unblocked.
+		 *
+		 * With 4 MiB subblocks, we manage 128 GiB of memory in one
+		 * 4 KiB page.
+		 */
+		unsigned long *sb_states;
+	} sbm;
 
 	/*
-	 * Mutex that protects the sbm.mb_count, sbm.mb_states, and sb_bitmap.
+	 * Mutex that protects the sbm.mb_count, sbm.mb_states, and
+	 * sbm.sb_states.
 	 *
 	 * When this lock is held the pointers can't change, ONLINE and
 	 * OFFLINE blocks can't change the state and no subblocks will get
@@ -323,8 +329,8 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
  * Calculate the bit number in the subblock bitmap for the given subblock
  * inside the given memory block.
  */
-static int virtio_mem_sb_bitmap_bit_nr(struct virtio_mem *vm,
-				       unsigned long mb_id, int sb_id)
+static int virtio_mem_sbm_sb_state_bit_nr(struct virtio_mem *vm,
+					  unsigned long mb_id, int sb_id)
 {
 	return (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
 }
@@ -334,13 +340,13 @@ static int virtio_mem_sb_bitmap_bit_nr(struct virtio_mem *vm,
  *
  * Will not modify the state of the memory block.
  */
-static void virtio_mem_mb_set_sb_plugged(struct virtio_mem *vm,
-					 unsigned long mb_id, int sb_id,
-					 int count)
+static void virtio_mem_sbm_set_sb_plugged(struct virtio_mem *vm,
+					  unsigned long mb_id, int sb_id,
+					  int count)
 {
-	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
-	__bitmap_set(vm->sb_bitmap, bit, count);
+	__bitmap_set(vm->sbm.sb_states, bit, count);
 }
 
 /*
@@ -348,86 +354,87 @@ static void virtio_mem_mb_set_sb_plugged(struct virtio_mem *vm,
  *
  * Will not modify the state of the memory block.
  */
-static void virtio_mem_mb_set_sb_unplugged(struct virtio_mem *vm,
-					   unsigned long mb_id, int sb_id,
-					   int count)
+static void virtio_mem_sbm_set_sb_unplugged(struct virtio_mem *vm,
+					    unsigned long mb_id, int sb_id,
+					    int count)
 {
-	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
-	__bitmap_clear(vm->sb_bitmap, bit, count);
+	__bitmap_clear(vm->sbm.sb_states, bit, count);
 }
 
 /*
  * Test if all selected subblocks are plugged.
  */
-static bool virtio_mem_mb_test_sb_plugged(struct virtio_mem *vm,
-					  unsigned long mb_id, int sb_id,
-					  int count)
+static bool virtio_mem_sbm_test_sb_plugged(struct virtio_mem *vm,
+					   unsigned long mb_id, int sb_id,
+					   int count)
 {
-	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	if (count == 1)
-		return test_bit(bit, vm->sb_bitmap);
+		return test_bit(bit, vm->sbm.sb_states);
 
 	/* TODO: Helper similar to bitmap_set() */
-	return find_next_zero_bit(vm->sb_bitmap, bit + count, bit) >=
+	return find_next_zero_bit(vm->sbm.sb_states, bit + count, bit) >=
 	       bit + count;
 }
 
 /*
  * Test if all selected subblocks are unplugged.
  */
-static bool virtio_mem_mb_test_sb_unplugged(struct virtio_mem *vm,
-					    unsigned long mb_id, int sb_id,
-					    int count)
+static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
+					     unsigned long mb_id, int sb_id,
+					     int count)
 {
-	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, sb_id);
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, sb_id);
 
 	/* TODO: Helper similar to bitmap_set() */
-	return find_next_bit(vm->sb_bitmap, bit + count, bit) >= bit + count;
+	return find_next_bit(vm->sbm.sb_states, bit + count, bit) >=
+	       bit + count;
 }
 
 /*
  * Find the first unplugged subblock. Returns vm->nb_sb_per_mb in case there is
  * none.
  */
-static int virtio_mem_mb_first_unplugged_sb(struct virtio_mem *vm,
+static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
-	const int bit = virtio_mem_sb_bitmap_bit_nr(vm, mb_id, 0);
+	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, 0);
 
-	return find_next_zero_bit(vm->sb_bitmap, bit + vm->nb_sb_per_mb, bit) -
-	       bit;
+	return find_next_zero_bit(vm->sbm.sb_states,
+				  bit + vm->nb_sb_per_mb, bit) - bit;
 }
 
 /*
  * Prepare the subblock bitmap for the next memory block.
  */
-static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
+static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
 {
 	const unsigned long old_nb_mb = vm->next_mb_id - vm->first_mb_id;
 	const unsigned long old_nb_bits = old_nb_mb * vm->nb_sb_per_mb;
 	const unsigned long new_nb_bits = (old_nb_mb + 1) * vm->nb_sb_per_mb;
 	int old_pages = PFN_UP(BITS_TO_LONGS(old_nb_bits) * sizeof(long));
 	int new_pages = PFN_UP(BITS_TO_LONGS(new_nb_bits) * sizeof(long));
-	unsigned long *new_sb_bitmap, *old_sb_bitmap;
+	unsigned long *new_bitmap, *old_bitmap;
 
-	if (vm->sb_bitmap && old_pages == new_pages)
+	if (vm->sbm.sb_states && old_pages == new_pages)
 		return 0;
 
-	new_sb_bitmap = vzalloc(new_pages * PAGE_SIZE);
-	if (!new_sb_bitmap)
+	new_bitmap = vzalloc(new_pages * PAGE_SIZE);
+	if (!new_bitmap)
 		return -ENOMEM;
 
 	mutex_lock(&vm->hotplug_mutex);
-	if (new_sb_bitmap)
-		memcpy(new_sb_bitmap, vm->sb_bitmap, old_pages * PAGE_SIZE);
+	if (new_bitmap)
+		memcpy(new_bitmap, vm->sbm.sb_states, old_pages * PAGE_SIZE);
 
-	old_sb_bitmap = vm->sb_bitmap;
-	vm->sb_bitmap = new_sb_bitmap;
+	old_bitmap = vm->sbm.sb_states;
+	vm->sbm.sb_states = new_bitmap;
 	mutex_unlock(&vm->hotplug_mutex);
 
-	vfree(old_sb_bitmap);
+	vfree(old_bitmap);
 	return 0;
 }
 
@@ -638,7 +645,7 @@ static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
 	int sb_id;
 
 	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
-		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			       sb_id * vm->subblock_size);
@@ -654,7 +661,7 @@ static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
 	int sb_id;
 
 	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
-		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			       sb_id * vm->subblock_size);
@@ -944,7 +951,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 		 * If plugged, online the pages, otherwise, set them fake
 		 * offline (PageOffline).
 		 */
-		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
 			generic_online_page(page, order);
 		else
 			virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
@@ -1102,7 +1109,7 @@ static int virtio_mem_mb_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
 
 	rc = virtio_mem_send_plug_request(vm, addr, size);
 	if (!rc)
-		virtio_mem_mb_set_sb_plugged(vm, mb_id, sb_id, count);
+		virtio_mem_sbm_set_sb_plugged(vm, mb_id, sb_id, count);
 	return rc;
 }
 
@@ -1120,7 +1127,7 @@ static int virtio_mem_mb_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
 
 	rc = virtio_mem_send_unplug_request(vm, addr, size);
 	if (!rc)
-		virtio_mem_mb_set_sb_unplugged(vm, mb_id, sb_id, count);
+		virtio_mem_sbm_set_sb_unplugged(vm, mb_id, sb_id, count);
 	return rc;
 }
 
@@ -1143,14 +1150,14 @@ static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
 	while (*nb_sb) {
 		/* Find the next candidate subblock */
 		while (sb_id >= 0 &&
-		       virtio_mem_mb_test_sb_unplugged(vm, mb_id, sb_id, 1))
+		       virtio_mem_sbm_test_sb_unplugged(vm, mb_id, sb_id, 1))
 			sb_id--;
 		if (sb_id < 0)
 			break;
 		/* Try to unplug multiple subblocks at a time */
 		count = 1;
 		while (count < *nb_sb && sb_id > 0 &&
-		       virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id - 1, 1)) {
+		       virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id - 1, 1)) {
 			count++;
 			sb_id--;
 		}
@@ -1196,7 +1203,7 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
 		return rc;
 
 	/* Resize the subblock bitmap if required. */
-	rc = virtio_mem_sb_bitmap_prepare_next_mb(vm);
+	rc = virtio_mem_sbm_sb_states_prepare_next_mb(vm);
 	if (rc)
 		return rc;
 
@@ -1281,14 +1288,13 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
 		return -EINVAL;
 
 	while (*nb_sb) {
-		sb_id = virtio_mem_mb_first_unplugged_sb(vm, mb_id);
+		sb_id = virtio_mem_sbm_first_unplugged_sb(vm, mb_id);
 		if (sb_id >= vm->nb_sb_per_mb)
 			break;
 		count = 1;
 		while (count < *nb_sb &&
 		       sb_id + count < vm->nb_sb_per_mb &&
-		       !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id + count,
-						      1))
+		       !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id + count, 1))
 			count++;
 
 		rc = virtio_mem_mb_plug_sb(vm, mb_id, sb_id, count);
@@ -1305,7 +1311,7 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
 		virtio_mem_fake_online(pfn, nr_pages);
 	}
 
-	if (virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+	if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
 		if (online)
 			virtio_mem_sbm_set_mb_state(vm, mb_id,
 						    VIRTIO_MEM_SBM_MB_ONLINE);
@@ -1405,13 +1411,13 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
 	rc = virtio_mem_mb_unplug_any_sb(vm, mb_id, nb_sb);
 
 	/* some subblocks might have been unplugged even on failure */
-	if (!virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
+	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
 		virtio_mem_sbm_set_mb_state(vm, mb_id,
 					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
 	if (rc)
 		return rc;
 
-	if (virtio_mem_mb_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
 		/*
 		 * Remove the block from Linux - this should never fail.
 		 * Hinder the block from getting onlined by marking it
@@ -1480,7 +1486,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
 
 	/* If possible, try to unplug the complete block in one shot. */
 	if (*nb_sb >= vm->nb_sb_per_mb &&
-	    virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+	    virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
 		rc = virtio_mem_mb_unplug_sb_online(vm, mb_id, 0,
 						    vm->nb_sb_per_mb);
 		if (!rc) {
@@ -1494,7 +1500,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
 	for (sb_id = vm->nb_sb_per_mb - 1; sb_id >= 0 && *nb_sb; sb_id--) {
 		/* Find the next candidate subblock */
 		while (sb_id >= 0 &&
-		       !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+		       !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
 			sb_id--;
 		if (sb_id < 0)
 			break;
@@ -1513,7 +1519,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
 	 * remove it. This will usually not fail, as no memory is in use
 	 * anymore - however some other notifiers might NACK the request.
 	 */
-	if (virtio_mem_mb_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
 		mutex_unlock(&vm->hotplug_mutex);
 		rc = virtio_mem_mb_offline_and_remove(vm, mb_id);
 		mutex_lock(&vm->hotplug_mutex);
@@ -2035,7 +2041,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 
 	/* remove all tracking data - no locking needed */
 	vfree(vm->sbm.mb_states);
-	vfree(vm->sb_bitmap);
+	vfree(vm->sbm.sb_states);
 
 	/* reset the device and cleanup the queues */
 	vdev->config->reset(vdev);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
