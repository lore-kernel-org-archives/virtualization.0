Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65655C388F7
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D990722249
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCQDYN8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D990722249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6132687797;
	Thu, 12 Nov 2020 13:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hfzIw5+e6QDK; Thu, 12 Nov 2020 13:39:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A5DBD8779B;
	Thu, 12 Nov 2020 13:39:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 903D9C08A1;
	Thu, 12 Nov 2020 13:39:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3D73C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 930178779B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2fT-Rk2CB-sL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D0FD687797
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xphG/IuRhKrkrWA+HPHS7+CmXDjosEiPk8o83eIJLv8=;
 b=OCQDYN8x4CvdV5/BjCvNSrNizBh81oe9mXXI+AlzFMDxq9kUNna4LvL0u7wkHzhG0IaA9p
 k7SbN6WyJBZK7eqzXUmiy5W/spElvqNlcx1SE7GlrNEA7sXTWu7TL88ehLv9ldS3Qwpvb1
 RxPcf36X2z6RRZ6zYJMbKKiKHjON3w8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-EVcPSrYpOMesENoQyDD_8Q-1; Thu, 12 Nov 2020 08:39:29 -0500
X-MC-Unique: EVcPSrYpOMesENoQyDD_8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BF12809DC0;
 Thu, 12 Nov 2020 13:39:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5275F55766;
 Thu, 12 Nov 2020 13:39:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/29] virtio-mem: memory block ids are specific to Sub
 Block Mode (SBM)
Date: Thu, 12 Nov 2020 14:38:07 +0100
Message-Id: <20201112133815.13332-22-david@redhat.com>
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

Let's move first_mb_id/next_mb_id/last_usable_mb_id accordingly.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 6395c3090252..248d28e653a9 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -96,13 +96,6 @@ struct virtio_mem {
 	/* Maximum region size in bytes. */
 	uint64_t region_size;
 
-	/* Id of the first memory block of this device. */
-	unsigned long first_mb_id;
-	/* Id of the last usable memory block of this device. */
-	unsigned long last_usable_mb_id;
-	/* Id of the next memory bock to prepare when needed. */
-	unsigned long next_mb_id;
-
 	/* The parent resource for all memory added via this device. */
 	struct resource *parent_resource;
 	/*
@@ -121,6 +114,13 @@ struct virtio_mem {
 	uint64_t offline_threshold;
 
 	struct {
+		/* Id of the first memory block of this device. */
+		unsigned long first_mb_id;
+		/* Id of the last usable memory block of this device. */
+		unsigned long last_usable_mb_id;
+		/* Id of the next memory bock to prepare when needed. */
+		unsigned long next_mb_id;
+
 		/* The subblock size. */
 		uint64_t sb_size;
 		/* The number of subblocks per Linux memory block. */
@@ -265,7 +265,7 @@ static unsigned long virtio_mem_phys_to_sb_id(struct virtio_mem *vm,
 static void virtio_mem_sbm_set_mb_state(struct virtio_mem *vm,
 					unsigned long mb_id, uint8_t state)
 {
-	const unsigned long idx = mb_id - vm->first_mb_id;
+	const unsigned long idx = mb_id - vm->sbm.first_mb_id;
 	uint8_t old_state;
 
 	old_state = vm->sbm.mb_states[idx];
@@ -282,7 +282,7 @@ static void virtio_mem_sbm_set_mb_state(struct virtio_mem *vm,
 static uint8_t virtio_mem_sbm_get_mb_state(struct virtio_mem *vm,
 					   unsigned long mb_id)
 {
-	const unsigned long idx = mb_id - vm->first_mb_id;
+	const unsigned long idx = mb_id - vm->sbm.first_mb_id;
 
 	return vm->sbm.mb_states[idx];
 }
@@ -292,8 +292,8 @@ static uint8_t virtio_mem_sbm_get_mb_state(struct virtio_mem *vm,
  */
 static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
 {
-	int old_pages = PFN_UP(vm->next_mb_id - vm->first_mb_id);
-	int new_pages = PFN_UP(vm->next_mb_id - vm->first_mb_id + 1);
+	int old_pages = PFN_UP(vm->sbm.next_mb_id - vm->sbm.first_mb_id);
+	int new_pages = PFN_UP(vm->sbm.next_mb_id - vm->sbm.first_mb_id + 1);
 	uint8_t *new_array;
 
 	if (vm->sbm.mb_states && old_pages == new_pages)
@@ -314,14 +314,14 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
 }
 
 #define virtio_mem_sbm_for_each_mb(_vm, _mb_id, _state) \
-	for (_mb_id = _vm->first_mb_id; \
-	     _mb_id < _vm->next_mb_id && _vm->sbm.mb_count[_state]; \
+	for (_mb_id = _vm->sbm.first_mb_id; \
+	     _mb_id < _vm->sbm.next_mb_id && _vm->sbm.mb_count[_state]; \
 	     _mb_id++) \
 		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
 
 #define virtio_mem_sbm_for_each_mb_rev(_vm, _mb_id, _state) \
-	for (_mb_id = _vm->next_mb_id - 1; \
-	     _mb_id >= _vm->first_mb_id && _vm->sbm.mb_count[_state]; \
+	for (_mb_id = _vm->sbm.next_mb_id - 1; \
+	     _mb_id >= _vm->sbm.first_mb_id && _vm->sbm.mb_count[_state]; \
 	     _mb_id--) \
 		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
 
@@ -332,7 +332,7 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
 static int virtio_mem_sbm_sb_state_bit_nr(struct virtio_mem *vm,
 					  unsigned long mb_id, int sb_id)
 {
-	return (mb_id - vm->first_mb_id) * vm->sbm.sbs_per_mb + sb_id;
+	return (mb_id - vm->sbm.first_mb_id) * vm->sbm.sbs_per_mb + sb_id;
 }
 
 /*
@@ -412,7 +412,7 @@ static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
  */
 static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
 {
-	const unsigned long old_nb_mb = vm->next_mb_id - vm->first_mb_id;
+	const unsigned long old_nb_mb = vm->sbm.next_mb_id - vm->sbm.first_mb_id;
 	const unsigned long old_nb_bits = old_nb_mb * vm->sbm.sbs_per_mb;
 	const unsigned long new_nb_bits = (old_nb_mb + 1) * vm->sbm.sbs_per_mb;
 	int old_pages = PFN_UP(BITS_TO_LONGS(old_nb_bits) * sizeof(long));
@@ -1194,7 +1194,7 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
 {
 	int rc;
 
-	if (vm->next_mb_id > vm->last_usable_mb_id)
+	if (vm->sbm.next_mb_id > vm->sbm.last_usable_mb_id)
 		return -ENOSPC;
 
 	/* Resize the state array if required. */
@@ -1208,7 +1208,7 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
 		return rc;
 
 	vm->sbm.mb_count[VIRTIO_MEM_SBM_MB_UNUSED]++;
-	*mb_id = vm->next_mb_id++;
+	*mb_id = vm->sbm.next_mb_id++;
 	return 0;
 }
 
@@ -1643,7 +1643,7 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
 			usable_region_size, &usable_region_size);
 	end_addr = vm->addr + usable_region_size;
 	end_addr = min(end_addr, phys_limit);
-	vm->last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr) - 1;
+	vm->sbm.last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr) - 1;
 
 	/* see if there is a request to change the size */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, requested_size,
@@ -1834,9 +1834,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	vm->sbm.sbs_per_mb = memory_block_size_bytes() / vm->sbm.sb_size;
 
 	/* Round up to the next full memory block */
-	vm->first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
-						   memory_block_size_bytes());
-	vm->next_mb_id = vm->first_mb_id;
+	vm->sbm.first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
+						       memory_block_size_bytes());
+	vm->sbm.next_mb_id = vm->sbm.first_mb_id;
 
 	/* Prepare the offline threshold - make sure we can add two blocks. */
 	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
