Return-Path: <SRS0=sYkO=OK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E5EC433F5
	for <virtualization@archiver.kernel.org>; Mon, 20 Sep 2021 14:30:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3BF610A3
	for <virtualization@archiver.kernel.org>; Mon, 20 Sep 2021 14:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B3BF610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DE866071C;
	Mon, 20 Sep 2021 14:30:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXH-cRMc6fnP; Mon, 20 Sep 2021 14:30:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0A1BD60708;
	Mon, 20 Sep 2021 14:30:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB38FC0011;
	Mon, 20 Sep 2021 14:30:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15490C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00DDD6075F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yq9CEzg4-_zf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:30:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E8AC6064D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632148243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9TCtQQQDHvFRzvXMYX+z7+x7whiCvDZBWtE0o8SjRw=;
 b=JdB094gPWncT9kiYd34CF4G69LXeT6YYLhakpMGNpLhZ1wjrWBvTIGceJ+jyohpiZ9h28O
 gF6kPighkpjhKW+ATjvatHlqE5YQxRChLAb6nTpqFM7FpndV39mGFetbm68kH3ZCEVGrMh
 dDyL4ceNIb5MBnRPzYQz31R0nrx8fsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-lQdMcZHkM46HaswXCYi9-g-1; Mon, 20 Sep 2021 10:30:42 -0400
X-MC-Unique: lQdMcZHkM46HaswXCYi9-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53797100C670;
 Mon, 20 Sep 2021 14:30:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25EF660C17;
 Mon, 20 Sep 2021 14:30:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] virtio-mem: disallow mapping virtio-mem memory via
 /dev/mem
Date: Mon, 20 Sep 2021 16:28:56 +0200
Message-Id: <20210920142856.17758-4-david@redhat.com>
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

We don't want user space to be able to map virtio-mem device memory
directly (e.g., via /dev/mem) in order to have guarantees that in a sane
setup we'll never accidentially access unplugged memory within the
device-managed region of a virtio-mem device, just as required by the
virtio-spec.

As soon as the virtio-mem driver is loaded, the device region is visible
in /proc/iomem via the parent device region. From that point on user space
is aware of the device region and we want to disallow mapping anything
inside that region (where we will dynamically (un)plug memory) until
the driver has been unloaded cleanly and e.g., another driver might take
over.

By creating our parent IORESOURCE_SYSTEM_RAM resource with
IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
device region until the driver was unloaded cleanly and removed the
parent region. This will work even though only some memory blocks are
actually currently added to Linux and appear as busy in the resource tree.

So access to the region from user space is only possible
a) if we don't load the virtio-mem driver.
b) after unloading the virtio-mem driver cleanly.

Don't build virtio-mem if access to /dev/mem cannot be restricticted --
if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/Kconfig      | 1 +
 drivers/virtio/virtio_mem.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index ce1b3f6ec325..0d974162899d 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -101,6 +101,7 @@ config VIRTIO_MEM
 	depends on MEMORY_HOTPLUG_SPARSE
 	depends on MEMORY_HOTREMOVE
 	depends on CONTIG_ALLOC
+	depends on EXCLUSIVE_SYSTEM_RAM
 	help
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index bef8ad6bf466..c619bc0e46a7 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2525,8 +2525,10 @@ static int virtio_mem_create_resource(struct virtio_mem *vm)
 	if (!name)
 		return -ENOMEM;
 
+	/* Disallow mapping device memory via /dev/mem completely. */
 	vm->parent_resource = __request_mem_region(vm->addr, vm->region_size,
-						   name, IORESOURCE_SYSTEM_RAM);
+						   name, IORESOURCE_SYSTEM_RAM |
+						   IORESOURCE_EXCLUSIVE);
 	if (!vm->parent_resource) {
 		kfree(name);
 		dev_warn(&vm->vdev->dev, "could not reserve device region\n");
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
