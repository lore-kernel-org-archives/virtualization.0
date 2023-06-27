Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F02EB64DC
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 11:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B93C41720;
	Tue, 27 Jun 2023 11:22:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B93C41720
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B0XUmtXq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0imh0GsIR4qe; Tue, 27 Jun 2023 11:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1C68402E5;
	Tue, 27 Jun 2023 11:22:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1C68402E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F3D8C007C;
	Tue, 27 Jun 2023 11:22:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77442C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 420914175D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 420914175D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B0XUmtXq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LtTU1LRkHx8M
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2E3E41D6E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2E3E41D6E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687864959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fr+vpotgatzONrB41R1RGYN75/TLbh/yXCu/qwGS3Ro=;
 b=B0XUmtXqbClOQr4B6glfkmKN0EiE+QLa8COqa0uTMpwlsiq3OVnzxqXLuPURGvprtMniwg
 un+DPurtDvn95ymNJa0M1rCrVEWvP0b3ElIG8bNHySdPlsC4qmME4k4MIyw1rkfPRNd+KS
 AQBaG9TTLOVx4jlpPuvr8k1dsuTFPYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-5tImlbEUOjm-C3jcDkwNPA-1; Tue, 27 Jun 2023 07:22:34 -0400
X-MC-Unique: 5tImlbEUOjm-C3jcDkwNPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9866800962;
 Tue, 27 Jun 2023 11:22:33 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10AC1200A3AD;
 Tue, 27 Jun 2023 11:22:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] mm/memory_hotplug: make offline_and_remove_memory()
 timeout instead of failing on fatal signals
Date: Tue, 27 Jun 2023 13:22:18 +0200
Message-Id: <20230627112220.229240-4-david@redhat.com>
In-Reply-To: <20230627112220.229240-1-david@redhat.com>
References: <20230627112220.229240-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
 John Hubbard <jhubbard@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
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

John Hubbard writes [1]:

        Some device drivers add memory to the system via memory hotplug.
        When the driver is unloaded, that memory is hot-unplugged.

        However, memory hot unplug can fail. And these days, it fails a
        little too easily, with respect to the above case. Specifically, if
        a signal is pending on the process, hot unplug fails.

        [...]

        So in this case, other things (unmovable pages, un-splittable huge
        pages) can also cause the above problem. However, those are
        demonstrably less common than simply having a pending signal. I've
        got bug reports from users who can trivially reproduce this by
        killing their process with a "kill -9", for example.

Especially with ZONE_MOVABLE, offlining is supposed to work in most
cases when offlining actually hotplugged (not boot) memory, and only fail
in rare corner cases (e.g., some driver holds a reference to a page in
ZONE_MOVABLE, turning it unmovable).

In these corner cases we really don't want to be stuck forever in
offline_and_remove_memory(). But in the general cases, we really want to
do our best to make memory offlining succeed -- in a reasonable
timeframe.

Reliably failing in the described case when there is a fatal signal pending
is sub-optimal. The pending signal check is mostly only relevant when user
space explicitly triggers offlining of memory using sysfs device attributes
("state" or "online" attribute), but not when coming via
offline_and_remove_memory().

So let's use a timer instead and ignore fatal signals, because they are
not really expressive for offline_and_remove_memory() users. Let's default
to 30 seconds if no timeout was specified, and limit the timeout to 120
seconds.

This change is also valuable for virtio-mem in BBM (Big Block Mode) with
"bbm_safe_unplug=off", to avoid endless loops when stuck forever in
offline_and_remove_memory().

While at it, drop the "extern" from offline_and_remove_memory() to make
it fit into a single line.

[1] https://lkml.kernel.org/r/20230620011719.155379-1-jhubbard@nvidia.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c    |  2 +-
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 50 ++++++++++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index cb8bc6f6aa90..f8792223f1db 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -738,7 +738,7 @@ static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
 		"offlining and removing memory: 0x%llx - 0x%llx\n", addr,
 		addr + size - 1);
 
-	rc = offline_and_remove_memory(addr, size);
+	rc = offline_and_remove_memory(addr, size, 0);
 	if (!rc) {
 		atomic64_sub(size, &vm->offline_size);
 		/*
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 9fcbf5706595..d5f9e8b5a4a4 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -307,7 +307,7 @@ extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			 struct zone *zone, struct memory_group *group);
 extern int remove_memory(u64 start, u64 size);
 extern void __remove_memory(u64 start, u64 size);
-extern int offline_and_remove_memory(u64 start, u64 size);
+int offline_and_remove_memory(u64 start, u64 size, unsigned int timeout_ms);
 
 #else
 static inline void try_offline_node(int nid) {}
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0d2151df4ee1..ca635121644a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -152,6 +152,22 @@ void put_online_mems(void)
 
 bool movable_node_enabled = false;
 
+/*
+ * Protected by the device hotplug lock: offline_and_remove_memory()
+ * will activate a timer such that offlining cannot be stuck forever.
+ *
+ * With an active timer, fatal signals will be ignored, because they can be
+ * counter-productive when dying user space triggers device unplug/driver
+ * unloading that ends up offlining+removing device memory.
+ */
+static bool mhp_offlining_timer_active;
+static atomic_t mhp_offlining_timer_expired;
+
+static void mhp_offline_timer_fn(struct timer_list *unused)
+{
+	atomic_set(&mhp_offlining_timer_expired, 1);
+}
+
 #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
 int mhp_default_online_type = MMOP_OFFLINE;
 #else
@@ -1879,7 +1895,18 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	do {
 		pfn = start_pfn;
 		do {
-			if (fatal_signal_pending(current)) {
+			/*
+			 * If a timer is active, we're coming via
+			 * offline_and_remove_memory() and want to ignore even
+			 * fatal signals.
+			 */
+			if (mhp_offlining_timer_active) {
+				if (atomic_read(&mhp_offlining_timer_expired)) {
+					ret = -ETIMEDOUT;
+					reason = "timeout";
+					goto failed_removal_isolated;
+				}
+			} else if (fatal_signal_pending(current)) {
 				ret = -EINTR;
 				reason = "signal backoff";
 				goto failed_removal_isolated;
@@ -2232,11 +2259,17 @@ static int try_reonline_memory_block(struct memory_block *mem, void *arg)
  * memory is still in use. Primarily useful for memory devices that logically
  * unplugged all memory (so it's no longer in use) and want to offline + remove
  * that memory.
+ *
+ * offline_and_remove_memory() will not fail on fatal signals. Instead, it will
+ * fail once the timeout has been reached and offlining was not completed. If
+ * no timeout was specified, it will timeout after 30 seconds. The timeout is
+ * limited to 120 seconds.
  */
-int offline_and_remove_memory(u64 start, u64 size)
+int offline_and_remove_memory(u64 start, u64 size, unsigned int timeout_ms)
 {
 	const unsigned long mb_count = size / memory_block_size_bytes();
 	uint8_t *online_types, *tmp;
+	struct timer_list timer;
 	int rc;
 
 	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
@@ -2261,9 +2294,22 @@ int offline_and_remove_memory(u64 start, u64 size)
 
 	lock_device_hotplug();
 
+	if (!timeout_ms)
+		timeout_ms = 30 * MSEC_PER_SEC;
+	timeout_ms = min_t(unsigned int, timeout_ms, 120 * MSEC_PER_SEC);
+
+	timer_setup_on_stack(&timer, mhp_offline_timer_fn, 0);
+	mod_timer(&timer, jiffies + msecs_to_jiffies(timeout_ms));
+	mhp_offlining_timer_active = true;
+
 	tmp = online_types;
 	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
 
+	timer_delete_sync(&timer);
+	atomic_set(&mhp_offlining_timer_expired, 0);
+	mhp_offlining_timer_active = false;
+	destroy_timer_on_stack(&timer);
+
 	/*
 	 * In case we succeeded to offline all memory, remove it.
 	 * This cannot fail as it cannot get onlined in the meantime.
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
