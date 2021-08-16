Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699FAC4320A
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 14:25:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DEEE6108E
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 14:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DEEE6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C18CF4020C;
	Mon, 16 Aug 2021 14:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UzYZ3LgMhNS8; Mon, 16 Aug 2021 14:25:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B12C4023B;
	Mon, 16 Aug 2021 14:25:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03CC6C0010;
	Mon, 16 Aug 2021 14:25:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1542C0022
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 14:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9702C60655
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 14:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E_0iDZxbBxrZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 14:25:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B510860600
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 14:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629123926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8pjQKq20MMRmVk9/QVKtqOInRYsV34BOk9l4UcdvY8=;
 b=BlS9U9f0JdTcGmXRuifZ6cNDawPkwMcl5NYhzz0mVaNuNd3ESCNfT5llxKHvF1QFHskh+H
 3v6OFl8bFZ/ErKVK0/BsCwKxWgqq+zMTK4LYFc2mvvPRwx9cMHLw8qUWyqrtuXn1BoCsvX
 zXMMv8QGvAzRDmOk5qqQdnCt95q40XY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-VNTWgVUEN-qLOricDucEtA-1; Mon, 16 Aug 2021 10:25:25 -0400
X-MC-Unique: VNTWgVUEN-qLOricDucEtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D47107BEFC;
 Mon, 16 Aug 2021 14:25:23 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1866D17A63;
 Mon, 16 Aug 2021 14:25:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] /dev/mem: disallow access to explicitly excluded
 system RAM regions
Date: Mon, 16 Aug 2021 16:25:03 +0200
Message-Id: <20210816142505.28359-2-david@redhat.com>
In-Reply-To: <20210816142505.28359-1-david@redhat.com>
References: <20210816142505.28359-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
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

virtio-mem dynamically exposes memory inside a device memory region as
system RAM to Linux, coordinating with the hypervisor which parts are
actually "plugged" and consequently usable/accessible. On the one hand, the
virtio-mem driver adds/removes whole memory blocks, creating/removing busy
IORESOURCE_SYSTEM_RAM resources, on the other hand, it logically (un)plugs
memory inside added memory blocks, dynamically either exposing them to
the buddy or hiding them from the buddy and marking them PG_offline.

virtio-mem wants to make sure that in a sane environment, nobody
"accidentially" accesses unplugged memory inside the device managed
region. After /proc/kcore has been sanitized and /dev/kmem has been
removed, /dev/mem is the remaining interface that still allows uncontrolled
access to the device-managed region of virtio-mem devices from user
space.

There is no known sane use case for mapping virtio-mem device memory
via /dev/mem while virtio-mem driver concurrently (un)plugs memory inside
that region. So once the driver was loaded and detected the device
along the device-managed region, we just want to disallow any access via
/dev/mem to it.

Let's add the basic infrastructure to exclude some physical memory
regions completely from /dev/mem access, on any architecture and under
any system configuration (independent of CONFIG_STRICT_DEVMEM and
independent of "iomem=").

Any range marked with "IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE"
will be excluded, even if not busy. For now, there are no applicable
ranges and we'll modify virtio-mem next to properly set
IORESOURCE_EXCLUSIVE on the parent resource.

As next_resource() will iterate over children although we might want to
skip a certain range completely, let's add and use
next_range_skip_children() and for_each_resource(), to optimize that case,
avoding having to traverse subtrees that are not of interest.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/char/mem.c     | 22 ++++++++------------
 include/linux/ioport.h |  1 +
 kernel/resource.c      | 47 ++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug      |  4 +++-
 4 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 1c596b5cdb27..1829dc6a1f29 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -60,13 +60,18 @@ static inline int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 }
 #endif
 
-#ifdef CONFIG_STRICT_DEVMEM
 static inline int page_is_allowed(unsigned long pfn)
 {
-	return devmem_is_allowed(pfn);
+#ifdef CONFIG_STRICT_DEVMEM
+	if (!devmem_is_allowed(pfn))
+		return 0;
+#endif /* CONFIG_STRICT_DEVMEM */
+	return !iomem_range_contains_excluded_devmem(PFN_PHYS(pfn), PAGE_SIZE);
 }
+
 static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 {
+#ifdef CONFIG_STRICT_DEVMEM
 	u64 from = ((u64)pfn) << PAGE_SHIFT;
 	u64 to = from + size;
 	u64 cursor = from;
@@ -77,18 +82,9 @@ static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 		cursor += PAGE_SIZE;
 		pfn++;
 	}
-	return 1;
-}
-#else
-static inline int page_is_allowed(unsigned long pfn)
-{
-	return 1;
-}
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	return 1;
+#endif /* CONFIG_STRICT_DEVMEM */
+	return !iomem_range_contains_excluded_devmem(PFN_PHYS(pfn), size);
 }
-#endif
 
 #ifndef unxlate_dev_mem_ptr
 #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8359c50f9988..d31f83281327 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -308,6 +308,7 @@ extern struct resource * __devm_request_region(struct device *dev,
 extern void __devm_release_region(struct device *dev, struct resource *parent,
 				  resource_size_t start, resource_size_t n);
 extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
+extern bool iomem_range_contains_excluded_devmem(u64 addr, u64 size);
 extern bool iomem_is_exclusive(u64 addr);
 
 extern int
diff --git a/kernel/resource.c b/kernel/resource.c
index ca9f5198a01f..f57a14617c49 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -73,6 +73,18 @@ static struct resource *next_resource(struct resource *p)
 	return p->sibling;
 }
 
+static struct resource *next_resource_skip_children(struct resource *p)
+{
+	while (!p->sibling && p->parent)
+		p = p->parent;
+	return p->sibling;
+}
+
+#define for_each_resource(_root, _p, _skip_children) \
+	for ((_p) = (_root)->child; (_p); \
+	     (_p) = (_skip_children) ? next_resource_skip_children(_p) : \
+				       next_resource(_p))
+
 static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct resource *p = v;
@@ -1700,6 +1712,41 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 	return err;
 }
 
+/*
+ * Check if a physical memory range is completely excluded from getting
+ * mapped/accessed via /dev/mem.
+ */
+bool iomem_range_contains_excluded_devmem(u64 addr, u64 size)
+{
+	const unsigned int flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE;
+	bool skip_children = false, excluded = false;
+	struct resource *p;
+
+	read_lock(&resource_lock);
+	for_each_resource(&iomem_resource, p, skip_children) {
+		if (p->start >= addr + size)
+			break;
+		if (p->end < addr) {
+			skip_children = true;
+			continue;
+		}
+		skip_children = false;
+
+		/*
+		 * A system RAM resource is excluded if IORESOURCE_EXCLUSIVE
+		 * is set, even if not busy and even if we don't have strict
+		 * checks enabled -- no ifs or buts.
+		 */
+		if ((p->flags & flags) == flags) {
+			excluded = true;
+			break;
+		}
+	}
+	read_unlock(&resource_lock);
+
+	return excluded;
+}
+
 #ifdef CONFIG_STRICT_DEVMEM
 static int strict_iomem_checks = 1;
 #else
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ddd575159fb..d0ce6e23a6db 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1780,7 +1780,9 @@ config STRICT_DEVMEM
 	  access to this is obviously disastrous, but specific access can
 	  be used by people debugging the kernel. Note that with PAT support
 	  enabled, even in this case there are restrictions on /dev/mem
-	  use due to the cache aliasing requirements.
+	  use due to the cache aliasing requirements. Further, some drivers
+	  will still restrict access to some physical memory regions either
+	  already used or to be used in the future as system RAM.
 
 	  If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
 	  file only allows userspace access to PCI space and the BIOS code and
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
