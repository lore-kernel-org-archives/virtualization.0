Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FA7C43467
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:54:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534A521D7F
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpfEra2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534A521D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F13687480;
	Mon, 12 Oct 2020 12:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7Ef6Yrgw+SR; Mon, 12 Oct 2020 12:54:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DBE9D873D5;
	Mon, 12 Oct 2020 12:54:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6862C07FF;
	Mon, 12 Oct 2020 12:54:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74BB7C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 61146207A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D6rjwOA3ldmX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 0E6542079A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602507291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqBRdrN+rzKtjpl2XrHaqNhvixrxohgsDeDRZkVA61Y=;
 b=NpfEra2nd72i88fNdS8+JGEuXfY5HxLzm77jvs3b283PWi9ouZm8lhqIeDdSKiiMcj6R/k
 sxqx1lAMVBQWSqTrS13l1rTVVXJCmjYKB897jtk1u+UHt4M3t+vSaLKbdcq7u72j97elB9
 7s2clVdEVSu5GoKQIv7OxhHoT69RqG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-T30Fq8AONu2AuXWUt9jDqA-1; Mon, 12 Oct 2020 08:54:47 -0400
X-MC-Unique: T30Fq8AONu2AuXWUt9jDqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C4E1800D4A;
 Mon, 12 Oct 2020 12:54:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 009C060C13;
 Mon, 12 Oct 2020 12:54:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/29] virtio-mem: don't always trigger the workqueue when
 offlining memory
Date: Mon, 12 Oct 2020 14:53:03 +0200
Message-Id: <20201012125323.17509-10-david@redhat.com>
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

Let's trigger from offlining code when we're not allowed to touch online
memory.

Handle the other case (memmap possibly freeing up another memory block)
when actually removing memory. When removing via virtio_mem_remove(),
virtio_mem_retry() is a NOP and safe to use.

While at it, move retry handling when offlining out of
virtio_mem_notify_offline(), to share it with Device Block Mode (DBM)
soon.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 40 ++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 5c93f8a65eba..8ea00f0b2ecd 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -158,6 +158,7 @@ static DEFINE_MUTEX(virtio_mem_mutex);
 static LIST_HEAD(virtio_mem_devices);
 
 static void virtio_mem_online_page_cb(struct page *page, unsigned int order);
+static void virtio_mem_retry(struct virtio_mem *vm);
 
 /*
  * Register a virtio-mem device so it will be considered for the online_page
@@ -435,9 +436,17 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
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
@@ -452,11 +461,19 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
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
@@ -534,15 +551,6 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
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
@@ -679,6 +687,14 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
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
