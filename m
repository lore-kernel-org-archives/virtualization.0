Return-Path: <SRS0=sYkO=OK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AA4C433EF
	for <virtualization@archiver.kernel.org>; Mon, 20 Sep 2021 14:29:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFDE61159
	for <virtualization@archiver.kernel.org>; Mon, 20 Sep 2021 14:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEFDE61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACB5B403AC;
	Mon, 20 Sep 2021 14:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ls3e3y7ofeQV; Mon, 20 Sep 2021 14:29:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3789A403B1;
	Mon, 20 Sep 2021 14:29:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11199C0011;
	Mon, 20 Sep 2021 14:29:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94283C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 764396064D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id stfdF9g_VmFV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:29:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 19ED4605F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632148164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eKxXCIY3RXYoZJT+3h0svXLPmqhFXlaxuuqqZnTjWlM=;
 b=dhfPmkqwhXaEa8shNjoY5uxwRnu5hno3qkCoGcneFPTAuvCzI4TtGOtONLsM+yK6oZpPsu
 a1XlTNVnZJCw6PLZJ6SGY8CJrHGEoI7apboIzLVXFP2wmDT5jy6a8pFqqpK42I/l0eAhwB
 EWNV3fLzjH2rp6dMTRBnHYbSBaXsRWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Qsnarz32N5KVyUroFOyqHA-1; Mon, 20 Sep 2021 10:29:23 -0400
X-MC-Unique: Qsnarz32N5KVyUroFOyqHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63E348CEA20;
 Mon, 20 Sep 2021 14:29:21 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E117B60C17;
 Mon, 20 Sep 2021 14:28:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] virtio-mem: disallow mapping virtio-mem memory via
 /dev/mem
Date: Mon, 20 Sep 2021 16:28:53 +0200
Message-Id: <20210920142856.17758-1-david@redhat.com>
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

@Andrew, can you take this via the -mm tree?

--

Let's add the basic infrastructure to exclude some physical memory
regions marked as "IORESOURCE_SYSTEM_RAM" completely from /dev/mem access,
even though they are not marked IORESOURCE_BUSY and even though
"iomem=relaxed" is set. Resource IORESOURCE_EXCLUSIVE for that purpose
instead of adding new flags to express something similar to
"soft-busy" or "not busy yet, but already prepared by a driver and not
to be mapped by user space".

Use it for virtio-mem, to disallow mapping any virtio-mem memory via
/dev/mem to user space after the virtio-mem driver was loaded.

Details can be found in patch #2 and #3.

v4 -> v5:
- "kernel/resource: disallow access to exclusive system RAM regions"
-- Add CONFIG_EXCLUSIVE_SYSTEM_RAM
- "virtio-mem: disallow mapping virtio-mem memory via /dev/mem"
-- Use CONFIG_EXCLUSIVE_SYSTEM_RAM
-- Add ACK from MST

v3 -> v4:
- Added Dans RBs (thanks!)
- Actually send the patches to the CC list ...

v2 -> v3:
- "kernel/resource: clean up and optimize iomem_is_exclusive()"
-- Reshuffled and moved for_each_resource() etc. into this patch
- "kernel/resource: disallow access to exclusive system RAM regions"
-- Leave CONFIG_STRICT_DEVMEM=n alone. Hoog into iomem_is_exclusive()
   instead.
-- Improve comments
- "virtio-mem: disallow mapping virtio-mem memory via /dev/mem"
-- Don't allow building virtio_mem without CONFIG_STRICT_DEVMEM when we
   have CONFIG_DEVMEM, where we don't have any guarantees.
- Rework all patch descriptions

v1 -> v2:
- "/dev/mem: disallow access to explicitly excluded system RAM regions"
-- Introduce and use for_each_resource() and next_resource_skip_children()
-- s/iomem_range_contains_excluded/iomem_range_contains_excluded_devmem/
- "kernel/resource: cleanup and optimize iomem_is_exclusive()"
-- Use for_each_resource()

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org

David Hildenbrand (3):
  kernel/resource: clean up and optimize iomem_is_exclusive()
  kernel/resource: disallow access to exclusive system RAM regions
  virtio-mem: disallow mapping virtio-mem memory via /dev/mem

 drivers/virtio/Kconfig      |  1 +
 drivers/virtio/virtio_mem.c |  4 ++-
 kernel/resource.c           | 54 ++++++++++++++++++++++++++-----------
 mm/Kconfig                  |  7 +++++
 4 files changed, 50 insertions(+), 16 deletions(-)


base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
