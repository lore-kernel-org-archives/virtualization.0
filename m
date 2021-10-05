Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4F2C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 12:18:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E12461409
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 12:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E12461409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1738983D58;
	Tue,  5 Oct 2021 12:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31kqI9HuPeg4; Tue,  5 Oct 2021 12:18:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A7D8083D43;
	Tue,  5 Oct 2021 12:18:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 810B1C0011;
	Tue,  5 Oct 2021 12:18:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21264C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 100CD83D4A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:18:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SuFNu1ihkdg2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:18:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5327E83D43
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633436284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbXdn+v660VV5bsfwvBwOBATR8SkkHZUOKA5MNOOqCo=;
 b=aIZK3kicIJIoX7EkLwlqGPuatokGYH3OuQQ+EaHoWPGrq7/YneUqy1RfGMbyJ7NKxooccy
 PjltuAjS0PNb3Rijq6Fo+FdyTMwz/B2KDKBEbZvB8ibrm11Azq2YTUXUjhGKHkawQsoK+V
 G6XFEC9N0eIDNw0L3GzFJcrMdp724Uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-7eXJYInqNRydT23wsOE_6w-1; Tue, 05 Oct 2021 08:18:03 -0400
X-MC-Unique: 7eXJYInqNRydT23wsOE_6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B62881006AA2;
 Tue,  5 Oct 2021 12:18:00 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F149E1F41E;
 Tue,  5 Oct 2021 12:17:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] virtio-mem: factor out hotplug specifics from
 virtio_mem_init() into virtio_mem_init_hotplug()
Date: Tue,  5 Oct 2021 14:14:27 +0200
Message-Id: <20211005121430.30136-7-david@redhat.com>
In-Reply-To: <20211005121430.30136-1-david@redhat.com>
References: <20211005121430.30136-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Michal Hocko <mhocko@suse.com>, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Baoquan He <bhe@redhat.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 kexec@lists.infradead.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>
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

Let's prepare for a new virtio-mem kdump mode in which we don't actually
hot(un)plug any memory but only observe the state of device blocks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 81 ++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index bef8ad6bf466..2ba7e8d6ba8d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2392,41 +2392,10 @@ static int virtio_mem_init_vq(struct virtio_mem *vm)
 	return 0;
 }
 
-static int virtio_mem_init(struct virtio_mem *vm)
+static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 {
 	const struct range pluggable_range = mhp_get_pluggable_range(true);
 	uint64_t sb_size, addr;
-	uint16_t node_id;
-
-	if (!vm->vdev->config->get) {
-		dev_err(&vm->vdev->dev, "config access disabled\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * We don't want to (un)plug or reuse any memory when in kdump. The
-	 * memory is still accessible (but not mapped).
-	 */
-	if (is_kdump_kernel()) {
-		dev_warn(&vm->vdev->dev, "disabled in kdump kernel\n");
-		return -EBUSY;
-	}
-
-	/* Fetch all properties that can't change. */
-	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
-			&vm->plugged_size);
-	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
-			&vm->device_block_size);
-	virtio_cread_le(vm->vdev, struct virtio_mem_config, node_id,
-			&node_id);
-	vm->nid = virtio_mem_translate_node_id(vm, node_id);
-	virtio_cread_le(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
-	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
-			&vm->region_size);
-
-	/* Determine the nid for the device based on the lowest address. */
-	if (vm->nid == NUMA_NO_NODE)
-		vm->nid = memory_add_physaddr_to_nid(vm->addr);
 
 	/* bad device setup - warn only */
 	if (!IS_ALIGNED(vm->addr, memory_block_size_bytes()))
@@ -2496,10 +2465,6 @@ static int virtio_mem_init(struct virtio_mem *vm)
 					      vm->offline_threshold);
 	}
 
-	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
-	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
-	dev_info(&vm->vdev->dev, "device block size: 0x%llx",
-		 (unsigned long long)vm->device_block_size);
 	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
 		 memory_block_size_bytes());
 	if (vm->in_sbm)
@@ -2508,10 +2473,52 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	else
 		dev_info(&vm->vdev->dev, "big block size: 0x%llx",
 			 (unsigned long long)vm->bbm.bb_size);
+
+	return 0;
+}
+
+static int virtio_mem_init(struct virtio_mem *vm)
+{
+	uint16_t node_id;
+
+	if (!vm->vdev->config->get) {
+		dev_err(&vm->vdev->dev, "config access disabled\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * We don't want to (un)plug or reuse any memory when in kdump. The
+	 * memory is still accessible (but not mapped).
+	 */
+	if (is_kdump_kernel()) {
+		dev_warn(&vm->vdev->dev, "disabled in kdump kernel\n");
+		return -EBUSY;
+	}
+
+	/* Fetch all properties that can't change. */
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
+			&vm->plugged_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
+			&vm->device_block_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, node_id,
+			&node_id);
+	vm->nid = virtio_mem_translate_node_id(vm, node_id);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
+			&vm->region_size);
+
+	/* Determine the nid for the device based on the lowest address. */
+	if (vm->nid == NUMA_NO_NODE)
+		vm->nid = memory_add_physaddr_to_nid(vm->addr);
+
+	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
+	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
+	dev_info(&vm->vdev->dev, "device block size: 0x%llx",
+		 (unsigned long long)vm->device_block_size);
 	if (vm->nid != NUMA_NO_NODE && IS_ENABLED(CONFIG_NUMA))
 		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
 
-	return 0;
+	return virtio_mem_init_hotplug(vm);
 }
 
 static int virtio_mem_create_resource(struct virtio_mem *vm)
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
