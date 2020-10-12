Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4F3C43467
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC07206D4
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4iUFi5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC07206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E990E86AF6;
	Mon, 12 Oct 2020 12:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZAslr4lky0OH; Mon, 12 Oct 2020 12:57:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3C83586AEE;
	Mon, 12 Oct 2020 12:57:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34132C07FF;
	Mon, 12 Oct 2020 12:57:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88870C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8118C207B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJ-GfLjBzZur
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 17EFD207A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602507445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0oDb6ZiE+J+ruRF91Otjbi8LwSZmBARuqAieXPiQD0=;
 b=B4iUFi5PuUAgsjaPk16J5ZJvT2dyYk/P6ZTJ0CTQZuXclRQ0+dM2//tJUNwvl0X9+TjC9h
 ixMJ7lv3laYQZFQTyoSQMtOtTRO4A4gRjXzNCQja+v1cIuE1kZW6b3YZ2WQ+pLzRssnB3N
 4c/5zioa1rvDoM/1RDxXD6QGssgGdGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-pEcttyr8NBCWAOKkzx2eUw-1; Mon, 12 Oct 2020 08:57:21 -0400
X-MC-Unique: pEcttyr8NBCWAOKkzx2eUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E3921800D4A;
 Mon, 12 Oct 2020 12:57:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04B6D60C07;
 Mon, 12 Oct 2020 12:57:05 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 27/29] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Date: Mon, 12 Oct 2020 14:53:21 +0200
Message-Id: <20201012125323.17509-28-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
 Oscar Salvador <osalvador@suse.de>
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

virtio-mem soon wants to use offline_and_remove_memory() memory that
exceeds a single Linux memory block (memory_block_size_bytes()). Let's
remove that restriction.

Let's remember the old state and try to restore that if anything goes
wrong. While re-onlining can, in general, fail, it's highly unlikely to
happen (usually only when a notifier fails to allocate memory, and these
are rather rare).

This will be used by virtio-mem to offline+remove memory ranges that are
bigger than a single memory block - for example, with a device block
size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
block size of 128MB.

While we could compress the state into 2 bit, using 8 bit is much
easier.

This handling is similar, but different to acpi_scan_try_to_offline():

a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
optimization is still relevant - it should only apply to ZONE_NORMAL
(where we have no guarantees). If relevant, we can always add it.

b) acpi_scan_try_to_offline() simply onlines all memory in case
something goes wrong. It doesn't restore previous online type. Let's do
that, so we won't overwrite what e.g., user space configured.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 16 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b44d4c7ba73b..217080ca93e5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1806,39 +1806,112 @@ int remove_memory(int nid, u64 start, u64 size)
 }
 EXPORT_SYMBOL_GPL(remove_memory);
 
+static int try_offline_memory_block(struct memory_block *mem, void *arg)
+{
+	uint8_t online_type = MMOP_ONLINE_KERNEL;
+	uint8_t **online_types = arg;
+	struct page *page;
+	int rc;
+
+	/*
+	 * Sense the online_type via the zone of the memory block. Offlining
+	 * with multiple zones within one memory block will be rejected
+	 * by offlining code ... so we don't care about that.
+	 */
+	page = pfn_to_online_page(section_nr_to_pfn(mem->start_section_nr));
+	if (page && zone_idx(page_zone(page)) == ZONE_MOVABLE)
+		online_type = MMOP_ONLINE_MOVABLE;
+
+	rc = device_offline(&mem->dev);
+	/*
+	 * Default is MMOP_OFFLINE - change it only if offlining succeeded,
+	 * so try_reonline_memory_block() can do the right thing.
+	 */
+	if (!rc)
+		**online_types = online_type;
+
+	(*online_types)++;
+	/* Ignore if already offline. */
+	return rc < 0 ? rc : 0;
+}
+
+static int try_reonline_memory_block(struct memory_block *mem, void *arg)
+{
+	uint8_t **online_types = arg;
+	int rc;
+
+	if (**online_types != MMOP_OFFLINE) {
+		mem->online_type = **online_types;
+		rc = device_online(&mem->dev);
+		if (rc < 0)
+			pr_warn("%s: Failed to re-online memory: %d",
+				__func__, rc);
+	}
+
+	/* Continue processing all remaining memory blocks. */
+	(*online_types)++;
+	return 0;
+}
+
 /*
- * Try to offline and remove a memory block. Might take a long time to
- * finish in case memory is still in use. Primarily useful for memory devices
- * that logically unplugged all memory (so it's no longer in use) and want to
- * offline + remove the memory block.
+ * Try to offline and remove memory. Might take a long time to finish in case
+ * memory is still in use. Primarily useful for memory devices that logically
+ * unplugged all memory (so it's no longer in use) and want to offline + remove
+ * that memory.
  */
 int offline_and_remove_memory(int nid, u64 start, u64 size)
 {
-	struct memory_block *mem;
-	int rc = -EINVAL;
+	const unsigned long mb_count = size / memory_block_size_bytes();
+	uint8_t *online_types, *tmp;
+	int rc;
 
 	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
-	    size != memory_block_size_bytes())
-		return rc;
+	    !IS_ALIGNED(size, memory_block_size_bytes()) || !size)
+		return -EINVAL;
+
+	/*
+	 * We'll remember the old online type of each memory block, so we can
+	 * try to revert whatever we did when offlining one memory block fails
+	 * after offlining some others succeeded.
+	 */
+	online_types = kmalloc_array(mb_count, sizeof(*online_types),
+				     GFP_KERNEL);
+	if (!online_types)
+		return -ENOMEM;
+	/*
+	 * Initialize all states to MMOP_OFFLINE, so when we abort processing in
+	 * try_offline_memory_block(), we'll skip all unprocessed blocks in
+	 * try_reonline_memory_block().
+	 */
+	memset(online_types, MMOP_OFFLINE, mb_count);
 
 	lock_device_hotplug();
-	mem = find_memory_block(__pfn_to_section(PFN_DOWN(start)));
-	if (mem)
-		rc = device_offline(&mem->dev);
-	/* Ignore if the device is already offline. */
-	if (rc > 0)
-		rc = 0;
+
+	tmp = online_types;
+	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
 
 	/*
-	 * In case we succeeded to offline the memory block, remove it.
+	 * In case we succeeded to offline all memory, remove it.
 	 * This cannot fail as it cannot get onlined in the meantime.
 	 */
 	if (!rc) {
 		rc = try_remove_memory(nid, start, size);
-		WARN_ON_ONCE(rc);
+		if (rc)
+			pr_err("%s: Failed to remove memory: %d", __func__, rc);
+	}
+
+	/*
+	 * Rollback what we did. While memory onlining might theoretically fail
+	 * (nacked by a notifier), it barely ever happens.
+	 */
+	if (rc) {
+		tmp = online_types;
+		walk_memory_blocks(start, size, &tmp,
+				   try_reonline_memory_block);
 	}
 	unlock_device_hotplug();
 
+	kfree(online_types);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(offline_and_remove_memory);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
