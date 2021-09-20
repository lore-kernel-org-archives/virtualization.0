Return-Path: <SRS0=sYkO=OK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FCCC433FE
	for <virtualization@archiver.kernel.org>; Mon, 20 Sep 2021 14:30:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81223610A3
	for <virtualization@archiver.kernel.org>; Mon, 20 Sep 2021 14:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81223610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA1FC83E7D;
	Mon, 20 Sep 2021 14:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 79fBigJsFDxU; Mon, 20 Sep 2021 14:30:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D41C482C61;
	Mon, 20 Sep 2021 14:30:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB354C001E;
	Mon, 20 Sep 2021 14:30:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45A65C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E89582993
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbvXKoearRhm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:30:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFBFC82894
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632148238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xw4p12rNhpw8xyA7/N2Zq43KStyN0IgZ3lBn9YKbLA8=;
 b=LooQ9eZb55q+7biaeQ3BHfWiqFYaS984YzExQMcZyXyjcVTniVlH3TmP0uhoVgzHfboWhg
 red3vhjLBNabtEK/4Ni018Lfd7iqbtK40u1hTFYShHoFCCrvQoVXrLbp7wyDw1aIZL+K3D
 IwZvPZiVV8CQY236L61y9XIi9iVMnfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-fHb1zMzKNaOZyNsMm_CB8w-1; Mon, 20 Sep 2021 10:30:37 -0400
X-MC-Unique: fHb1zMzKNaOZyNsMm_CB8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC6C4802928;
 Mon, 20 Sep 2021 14:30:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD97D60C17;
 Mon, 20 Sep 2021 14:30:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] kernel/resource: disallow access to exclusive system
 RAM regions
Date: Mon, 20 Sep 2021 16:28:55 +0200
Message-Id: <20210920142856.17758-3-david@redhat.com>
In-Reply-To: <20210920142856.17758-1-david@redhat.com>
References: <20210920142856.17758-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

In contrast to physical devices, like a DIMM, the virtio-mem driver
is required to actually make use of any of the device-provided memory,
because it performs the handshake with the hypervisor. virtio-mem memory
cannot simply be access via /dev/mem without a driver.

There is no safe way to:
a) Access plugged memory blocks via /dev/mem, as they might contain
   unplugged holes or might get silently unplugged by the virtio-mem
   driver and consequently turned inaccessible.
b) Access unplugged memory blocks via /dev/mem because the virtio-mem
   driver is required to make them actually accessible first.

The virtio-spec states that unplugged memory blocks MUST NOT be
written, and only selected unplugged memory blocks MAY be read. We want
to make sure, this is the case in sane environments -- where the
virtio-mem driver was loaded.

We want to make sure that in a sane environment, nobody "accidentially"
accesses unplugged memory inside the device managed region. For example,
a user might spot a memory region in /proc/iomem and try accessing it via
/dev/mem via gdb or dumping it via something else. By the time the mmap()
happens, the memory might already have been removed by the virtio-mem
driver silently: the mmap() would succeeed and user space might
accidentially access unplugged memory.

So once the driver was loaded and detected the device along the
device-managed region, we just want to disallow any access via
/dev/mem to it.

In an ideal world, we would mark the whole region as busy ("owned by a
driver") and exclude it; however, that would be wrong, as we don't
really have actual system RAM at these ranges added to Linux ("busy system
RAM"). Instead, we want to mark such ranges as "not actual busy system RAM
but still soft-reserved and prepared by a driver for future use."

Let's teach iomem_is_exclusive() to reject access to any range
with "IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE", even if not busy
and even if "iomem=relaxed" is set. Introduce EXCLUSIVE_SYSTEM_RAM
to make it easier for applicable drivers to depend on this setting in
their Kconfig.

For now, there are no applicable ranges and we'll modify virtio-mem next to
properly set IORESOURCE_EXCLUSIVE on the parent resource container it
creates to contain all actual busy system RAM added via
add_memory_driver_managed().

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/resource.c | 29 +++++++++++++++++++----------
 mm/Kconfig        |  7 +++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 2999f57da38c..5ad3eba619ba 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1719,26 +1719,23 @@ static int strict_iomem_checks;
 #endif
 
 /*
- * check if an address is reserved in the iomem resource tree
- * returns true if reserved, false if not reserved.
+ * Check if an address is exclusive to the kernel and must not be mapped to
+ * user space, for example, via /dev/mem.
+ *
+ * Returns true if exclusive to the kernel, otherwise returns false.
  */
 bool iomem_is_exclusive(u64 addr)
 {
+	const unsigned int exclusive_system_ram = IORESOURCE_SYSTEM_RAM |
+						  IORESOURCE_EXCLUSIVE;
 	bool skip_children = false, err = false;
 	int size = PAGE_SIZE;
 	struct resource *p;
 
-	if (!strict_iomem_checks)
-		return false;
-
 	addr = addr & PAGE_MASK;
 
 	read_lock(&resource_lock);
 	for_each_resource(&iomem_resource, p, skip_children) {
-		/*
-		 * We can probably skip the resources without
-		 * IORESOURCE_IO attribute?
-		 */
 		if (p->start >= addr + size)
 			break;
 		if (p->end < addr) {
@@ -1747,12 +1744,24 @@ bool iomem_is_exclusive(u64 addr)
 		}
 		skip_children = false;
 
+		/*
+		 * IORESOURCE_SYSTEM_RAM resources are exclusive if
+		 * IORESOURCE_EXCLUSIVE is set, even if they
+		 * are not busy and even if "iomem=relaxed" is set. The
+		 * responsible driver dynamically adds/removes system RAM within
+		 * such an area and uncontrolled access is dangerous.
+		 */
+		if ((p->flags & exclusive_system_ram) == exclusive_system_ram) {
+			err = true;
+			break;
+		}
+
 		/*
 		 * A resource is exclusive if IORESOURCE_EXCLUSIVE is set
 		 * or CONFIG_IO_STRICT_DEVMEM is enabled and the
 		 * resource is busy.
 		 */
-		if ((p->flags & IORESOURCE_BUSY) == 0)
+		if (!strict_iomem_checks || !(p->flags & IORESOURCE_BUSY))
 			continue;
 		if (IS_ENABLED(CONFIG_IO_STRICT_DEVMEM)
 				|| p->flags & IORESOURCE_EXCLUSIVE) {
diff --git a/mm/Kconfig b/mm/Kconfig
index d16ba9249bc5..87a9b98924cd 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -109,6 +109,13 @@ config NUMA_KEEP_MEMINFO
 config MEMORY_ISOLATION
 	bool
 
+# IORESOURCE_SYSTEM_RAM regions in the kernel resource tree that are marked
+# IORESOURCE_EXCLUSIVE cannot be mapped to user space, for example, via
+# /dev/mem.
+config EXCLUSIVE_SYSTEM_RAM
+	def_bool y
+	depends on !DEVMEM || STRICT_DEVMEM
+
 #
 # Only be set on architectures that have completely implemented memory hotplug
 # feature. If you are not sure, don't touch it.
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
