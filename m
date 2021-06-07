Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF796C47094
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 19:56:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACBA61139
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 19:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACBA61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DD3F40003;
	Mon,  7 Jun 2021 19:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yQozOYEGab1r; Mon,  7 Jun 2021 19:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2147D403AA;
	Mon,  7 Jun 2021 19:56:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1A29C000E;
	Mon,  7 Jun 2021 19:56:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4505C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4FDA40300
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wNp4nOKxFqIm
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:55:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF402402F6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623095758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=we7KxiONd+RRHM3f3H50fIrTEzJMZrnOephVGh+JFPs=;
 b=WdnFdViSheFgKahjFxkS//1nYBEkwzbKMpRxQIGMbChxx57f6x8rBSJH/W3J8paBU57niI
 +lUeJj97MKO5OkD9xY+S9v0eD4r+QakJ+pIcDb2MfT3N5/Dgd8VuyQ4un9GoS9OArK5Q9p
 2AOmpgrRJeJliH95Rc2++E5Gul28mEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-xue4KIEMN8mt8Nf3IR86ZA-1; Mon, 07 Jun 2021 15:55:57 -0400
X-MC-Unique: xue4KIEMN8mt8Nf3IR86ZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF854100748D;
 Mon,  7 Jun 2021 19:55:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-9.ams2.redhat.com [10.36.112.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE9101002D71;
 Mon,  7 Jun 2021 19:55:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/12] virtio-mem: use a single dynamic memory group for a
 single virtio-mem device
Date: Mon,  7 Jun 2021 21:54:28 +0200
Message-Id: <20210607195430.48228-11-david@redhat.com>
In-Reply-To: <20210607195430.48228-1-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hui Zhu <teawater@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Kedzierski <mkedzier@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

Let's use a single dynamic memory group.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e327fb878143..6b9b8b7bf89d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -139,6 +139,8 @@ struct virtio_mem {
 	 * add_memory_driver_managed().
 	 */
 	const char *resource_name;
+	/* Memory group identification. */
+	int mgid;
 
 	/*
 	 * We don't want to add too much memory if it's not getting onlined,
@@ -622,8 +624,8 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
 		addr + size - 1);
 	/* Memory might get onlined immediately. */
 	atomic64_add(size, &vm->offline_size);
-	rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
-				       MHP_MERGE_RESOURCE);
+	rc = add_memory_driver_managed(vm->mgid, addr, size, vm->resource_name,
+				       MHP_MERGE_RESOURCE | MHP_NID_IS_MGID);
 	if (rc) {
 		atomic64_sub(size, &vm->offline_size);
 		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
@@ -2550,6 +2552,7 @@ static bool virtio_mem_has_memory_added(struct virtio_mem *vm)
 static int virtio_mem_probe(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm;
+	uint64_t unit_pages;
 	int rc;
 
 	BUILD_BUG_ON(sizeof(struct virtio_mem_req) != 24);
@@ -2584,6 +2587,16 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	if (rc)
 		goto out_del_vq;
 
+	/* use a single dynamic memory group to cover the whole memory device */
+	if (vm->in_sbm)
+		unit_pages = PHYS_PFN(memory_block_size_bytes());
+	else
+		unit_pages = PHYS_PFN(vm->bbm.bb_size);
+	rc = register_dynamic_memory_group(vm->nid, unit_pages);
+	if (rc < 0)
+		goto out_del_resource;
+	vm->mgid = rc;
+
 	/*
 	 * If we still have memory plugged, we have to unplug all memory first.
 	 * Registering our parent resource makes sure that this memory isn't
@@ -2598,7 +2611,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	vm->memory_notifier.notifier_call = virtio_mem_memory_notifier_cb;
 	rc = register_memory_notifier(&vm->memory_notifier);
 	if (rc)
-		goto out_del_resource;
+		goto out_unreg_group;
 	rc = register_virtio_mem_device(vm);
 	if (rc)
 		goto out_unreg_mem;
@@ -2612,6 +2625,8 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	return 0;
 out_unreg_mem:
 	unregister_memory_notifier(&vm->memory_notifier);
+out_unreg_group:
+	unregister_memory_group(vm->mgid);
 out_del_resource:
 	virtio_mem_delete_resource(vm);
 out_del_vq:
@@ -2676,6 +2691,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	} else {
 		virtio_mem_delete_resource(vm);
 		kfree_const(vm->resource_name);
+		unregister_memory_group(vm->mgid);
 	}
 
 	/* remove all tracking data - no locking needed */
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
