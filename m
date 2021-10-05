Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFA0C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 12:18:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FF461409
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 12:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8FF461409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96CD540761;
	Tue,  5 Oct 2021 12:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zmWI3skGNqxC; Tue,  5 Oct 2021 12:18:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E85FC4020D;
	Tue,  5 Oct 2021 12:18:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC3B0C0011;
	Tue,  5 Oct 2021 12:18:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE38FC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F9B483D51
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pPpPiZ_KJZAn
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:18:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C68A983D4E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 12:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633436311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJ4bVTfY2RBZ7dKHJReSBumHsyhYfakPMn9Oqd8JPC0=;
 b=W7gAEEUD7tIYemQcYLRpiZvqZgQUFu13haAISMlUafHkPYOfGi4HO7Cwaq2i1VhU6FIzBG
 mzoaeyqQUKjr1dBMAvMQVROFVfqX9/1MRyK6bl7nwNlGqE+m5bFs4EVXjuWh6odSkqKVKX
 7D0aRtMs2RZwDDEGYLdlJhNWLhE1N90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-YoFJbj0fMLyMSCfLYRqF7g-1; Tue, 05 Oct 2021 08:18:30 -0400
X-MC-Unique: YoFJbj0fMLyMSCfLYRqF7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FAC1362F8;
 Tue,  5 Oct 2021 12:18:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AD2E1F442;
 Tue,  5 Oct 2021 12:18:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] virtio-mem: factor out hotplug specifics from
 virtio_mem_probe() into virtio_mem_init_hotplug()
Date: Tue,  5 Oct 2021 14:14:28 +0200
Message-Id: <20211005121430.30136-8-david@redhat.com>
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
 drivers/virtio/virtio_mem.c | 87 +++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 2ba7e8d6ba8d..1be3ee7f684d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -260,6 +260,8 @@ static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
 static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
 						   unsigned long nr_pages);
 static void virtio_mem_retry(struct virtio_mem *vm);
+static int virtio_mem_create_resource(struct virtio_mem *vm);
+static void virtio_mem_delete_resource(struct virtio_mem *vm);
 
 /*
  * Register a virtio-mem device so it will be considered for the online_page
@@ -2395,7 +2397,8 @@ static int virtio_mem_init_vq(struct virtio_mem *vm)
 static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 {
 	const struct range pluggable_range = mhp_get_pluggable_range(true);
-	uint64_t sb_size, addr;
+	uint64_t unit_pages, sb_size, addr;
+	int rc;
 
 	/* bad device setup - warn only */
 	if (!IS_ALIGNED(vm->addr, memory_block_size_bytes()))
@@ -2474,7 +2477,48 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 		dev_info(&vm->vdev->dev, "big block size: 0x%llx",
 			 (unsigned long long)vm->bbm.bb_size);
 
+	/* create the parent resource for all memory */
+	rc = virtio_mem_create_resource(vm);
+	if (rc)
+		return rc;
+
+	/* use a single dynamic memory group to cover the whole memory device */
+	if (vm->in_sbm)
+		unit_pages = PHYS_PFN(memory_block_size_bytes());
+	else
+		unit_pages = PHYS_PFN(vm->bbm.bb_size);
+	rc = memory_group_register_dynamic(vm->nid, unit_pages);
+	if (rc < 0)
+		goto out_del_resource;
+	vm->mgid = rc;
+
+	/*
+	 * If we still have memory plugged, we have to unplug all memory first.
+	 * Registering our parent resource makes sure that this memory isn't
+	 * actually in use (e.g., trying to reload the driver).
+	 */
+	if (vm->plugged_size) {
+		vm->unplug_all_required = true;
+		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
+	}
+
+	/* register callbacks */
+	vm->memory_notifier.notifier_call = virtio_mem_memory_notifier_cb;
+	rc = register_memory_notifier(&vm->memory_notifier);
+	if (rc)
+		goto out_unreg_group;
+	rc = register_virtio_mem_device(vm);
+	if (rc)
+		goto out_unreg_mem;
+
 	return 0;
+out_unreg_mem:
+	unregister_memory_notifier(&vm->memory_notifier);
+out_unreg_group:
+	memory_group_unregister(vm->mgid);
+out_del_resource:
+	virtio_mem_delete_resource(vm);
+	return rc;
 }
 
 static int virtio_mem_init(struct virtio_mem *vm)
@@ -2578,7 +2622,6 @@ static bool virtio_mem_has_memory_added(struct virtio_mem *vm)
 static int virtio_mem_probe(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm;
-	uint64_t unit_pages;
 	int rc;
 
 	BUILD_BUG_ON(sizeof(struct virtio_mem_req) != 24);
@@ -2608,40 +2651,6 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	if (rc)
 		goto out_del_vq;
 
-	/* create the parent resource for all memory */
-	rc = virtio_mem_create_resource(vm);
-	if (rc)
-		goto out_del_vq;
-
-	/* use a single dynamic memory group to cover the whole memory device */
-	if (vm->in_sbm)
-		unit_pages = PHYS_PFN(memory_block_size_bytes());
-	else
-		unit_pages = PHYS_PFN(vm->bbm.bb_size);
-	rc = memory_group_register_dynamic(vm->nid, unit_pages);
-	if (rc < 0)
-		goto out_del_resource;
-	vm->mgid = rc;
-
-	/*
-	 * If we still have memory plugged, we have to unplug all memory first.
-	 * Registering our parent resource makes sure that this memory isn't
-	 * actually in use (e.g., trying to reload the driver).
-	 */
-	if (vm->plugged_size) {
-		vm->unplug_all_required = true;
-		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
-	}
-
-	/* register callbacks */
-	vm->memory_notifier.notifier_call = virtio_mem_memory_notifier_cb;
-	rc = register_memory_notifier(&vm->memory_notifier);
-	if (rc)
-		goto out_unreg_group;
-	rc = register_virtio_mem_device(vm);
-	if (rc)
-		goto out_unreg_mem;
-
 	virtio_device_ready(vdev);
 
 	/* trigger a config update to start processing the requested_size */
@@ -2649,12 +2658,6 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	queue_work(system_freezable_wq, &vm->wq);
 
 	return 0;
-out_unreg_mem:
-	unregister_memory_notifier(&vm->memory_notifier);
-out_unreg_group:
-	memory_group_unregister(vm->mgid);
-out_del_resource:
-	virtio_mem_delete_resource(vm);
 out_del_vq:
 	vdev->config->del_vqs(vdev);
 out_free_vm:
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
