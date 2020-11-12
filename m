Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66339C56201
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30512224A
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTYco/53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30512224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 975AE870C8;
	Thu, 12 Nov 2020 13:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e19SAeNISrHT; Thu, 12 Nov 2020 13:39:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11674870CF;
	Thu, 12 Nov 2020 13:39:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBD22C088B;
	Thu, 12 Nov 2020 13:39:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAD12C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A32386D05
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8gVCBo2NCbyL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 575FB86CDE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ft1YSvY9BgdFEI8pvmy+sn5jf3hse4l/Z931OuLpsyQ=;
 b=bTYco/53xpKKx2dFQV6qaWiF+Eyffa2wMWuGqrKdZW7Bb3nMCbsQmT4x4ai0GX//0GrUI7
 /UUKeEmbXR9BiBwIjbEKVlHVUfDPC677kBm6y807AS+XuTEJGMWxD8Nh4LBksqYYZ3yuOr
 yBu5B6RHLpy62AIsjYVqyKzlQ/R53yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-bCjUfemBM1CFGjtQ-6RGAA-1; Thu, 12 Nov 2020 08:39:10 -0500
X-MC-Unique: bCjUfemBM1CFGjtQ-6RGAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 757B9809DE2;
 Thu, 12 Nov 2020 13:39:09 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E060A75138;
 Thu, 12 Nov 2020 13:39:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/29] virtio-mem: don't always trigger the workqueue when
 offlining memory
Date: Thu, 12 Nov 2020 14:38:01 +0100
Message-Id: <20201112133815.13332-16-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
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

Let's trigger from offlining code only when we're not allowed to unplug
online memory. Handle the other case (memmap possibly freeing up another
memory block) when actually removing memory. We now also properly handle
the case when removing already offline memory blocks via
virtio_mem_mb_remove(). When removing via virtio_mem_remove(), when
unloading the driver, virtio_mem_retry() is a NOP and safe to use.

While at it, move retry handling when offlining out of
virtio_mem_notify_offline(), to share it with Big Block Mode (BBM)
soon.

This is a preparation for Big Block Mode (BBM), whereby we can see some
temporary offlining of memory blocks without actually making progress.
Imagine you have a Big Block that spans to Linux memory blocks. Assume
the first Linux memory blocks has no unmovable data on it. When we would
call offline_and_remove_memory() on the big block, we would
	1. Try to offline the first block. Works, notifiers triggered.
	   virtio_mem_retry() called.
	2. Try to offline the second block. Does not work.
	3. Re-online first block.
	4. Exit to main loop, exit workqueue.
	5. Retry immediately (due to virtio_mem_retry()), go to 1.
The result are endless retries.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 40 ++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a7beac5942e0..f86654af8b6b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -162,6 +162,7 @@ static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
 						  unsigned long nr_pages);
 static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
 						   unsigned long nr_pages);
+static void virtio_mem_retry(struct virtio_mem *vm);
 
 /*
  * Register a virtio-mem device so it will be considered for the online_page
@@ -447,9 +448,17 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	int rc;
 
 	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
-	return remove_memory(vm->nid, addr, memory_block_size_bytes());
+	rc = remove_memory(vm->nid, addr, memory_block_size_bytes());
+	if (!rc)
+		/*
+		 * We might have freed up memory we can now unplug, retry
+		 * immediately instead of waiting.
+		 */
+		virtio_mem_retry(vm);
+	return rc;
 }
 
 /*
@@ -464,11 +473,19 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	int rc;
 
 	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
 		mb_id);
-	return offline_and_remove_memory(vm->nid, addr,
-					 memory_block_size_bytes());
+	rc = offline_and_remove_memory(vm->nid, addr,
+				       memory_block_size_bytes());
+	if (!rc)
+		/*
+		 * We might have freed up memory we can now unplug, retry
+		 * immediately instead of waiting.
+		 */
+		virtio_mem_retry(vm);
+	return rc;
 }
 
 /*
@@ -546,15 +563,6 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
 		BUG();
 		break;
 	}
-
-	/*
-	 * Trigger the workqueue, maybe we can now unplug memory. Also,
-	 * when we offline and remove a memory block, this will re-trigger
-	 * us immediately - which is often nice because the removal of
-	 * the memory block (e.g., memmap) might have freed up memory
-	 * on other memory blocks we manage.
-	 */
-	virtio_mem_retry(vm);
 }
 
 static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
@@ -672,6 +680,14 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		break;
 	case MEM_OFFLINE:
 		virtio_mem_notify_offline(vm, mb_id);
+
+		/*
+		 * Trigger the workqueue. Now that we have some offline memory,
+		 * maybe we can handle pending unplug requests.
+		 */
+		if (!unplug_online)
+			virtio_mem_retry(vm);
+
 		vm->hotplug_active = false;
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
