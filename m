Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D3BC2D0A3
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BD52224D
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaFLI2m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BD52224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D0D3870BB;
	Thu, 12 Nov 2020 13:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d8fUbrrRW6w4; Thu, 12 Nov 2020 13:38:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7D67870C1;
	Thu, 12 Nov 2020 13:38:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81B23C088B;
	Thu, 12 Nov 2020 13:38:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B4D1C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 54F9B87791
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zyu9wdA6mqN3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F29B087796
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltZDSIoS0Xw0v7eJldXMPtd3qGlDKG6FNekXfZuHaYY=;
 b=gaFLI2m+CgjcjAYID6c16Zh4FWrn8sRhMmiWao4ySCQkrScsRjBiVNmFuyCA/un3Wk3YPz
 KrM7Jf0fZiU6x6kD33K5Pw8TZqCFHmca9pZZuQfHa7dV8gxrlpZRqkk1SGwBC5lSz7Mk5r
 aQM5eJpSIaCQRtZLkQ998HSYFXAniVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-ted8Bh7COsWnFjEJxHWb_w-1; Thu, 12 Nov 2020 08:38:29 -0500
X-MC-Unique: ted8Bh7COsWnFjEJxHWb_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70A7F18B9F84;
 Thu, 12 Nov 2020 13:38:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82F1A55765;
 Thu, 12 Nov 2020 13:38:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/29] virtio-mem: determine nid only once using
 memory_add_physaddr_to_nid()
Date: Thu, 12 Nov 2020 14:37:47 +0100
Message-Id: <20201112133815.13332-2-david@redhat.com>
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

Let's determine the target nid only once in case we have none specified -
usually, we'll end up with node 0 either way.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 181e2f18beae..a37fd73588da 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -70,7 +70,7 @@ struct virtio_mem {
 
 	/* The device block size (for communicating with the device). */
 	uint64_t device_block_size;
-	/* The translated node id. NUMA_NO_NODE in case not specified. */
+	/* The determined node id for all memory of the device. */
 	int nid;
 	/* Physical start address of the memory region. */
 	uint64_t addr;
@@ -406,10 +406,6 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
 static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	int nid = vm->nid;
-
-	if (nid == NUMA_NO_NODE)
-		nid = memory_add_physaddr_to_nid(addr);
 
 	/*
 	 * When force-unloading the driver and we still have memory added to
@@ -423,7 +419,8 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 	}
 
 	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
-	return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
+	return add_memory_driver_managed(vm->nid, addr,
+					 memory_block_size_bytes(),
 					 vm->resource_name,
 					 MEMHP_MERGE_RESOURCE);
 }
@@ -440,13 +437,9 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	int nid = vm->nid;
-
-	if (nid == NUMA_NO_NODE)
-		nid = memory_add_physaddr_to_nid(addr);
 
 	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
-	return remove_memory(nid, addr, memory_block_size_bytes());
+	return remove_memory(vm->nid, addr, memory_block_size_bytes());
 }
 
 /*
@@ -461,14 +454,11 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	int nid = vm->nid;
-
-	if (nid == NUMA_NO_NODE)
-		nid = memory_add_physaddr_to_nid(addr);
 
 	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
 		mb_id);
-	return offline_and_remove_memory(nid, addr, memory_block_size_bytes());
+	return offline_and_remove_memory(vm->nid, addr,
+					 memory_block_size_bytes());
 }
 
 /*
@@ -1659,6 +1649,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
 			&vm->region_size);
 
+	/* Determine the nid for the device based on the lowest address. */
+	if (vm->nid == NUMA_NO_NODE)
+		vm->nid = memory_add_physaddr_to_nid(vm->addr);
+
 	/*
 	 * We always hotplug memory in memory block granularity. This way,
 	 * we have to wait for exactly one memory block to online.
@@ -1707,7 +1701,7 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		 memory_block_size_bytes());
 	dev_info(&vm->vdev->dev, "subblock size: 0x%llx",
 		 (unsigned long long)vm->subblock_size);
-	if (vm->nid != NUMA_NO_NODE)
+	if (vm->nid != NUMA_NO_NODE && IS_ENABLED(CONFIG_NUMA))
 		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
 
 	return 0;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
