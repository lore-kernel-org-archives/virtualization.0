Return-Path: <SRS0=fDOL=NY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E13C88C84
	for <virtualization@archiver.kernel.org>; Thu,  2 Sep 2021 16:25:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBDB61179
	for <virtualization@archiver.kernel.org>; Thu,  2 Sep 2021 16:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BBDB61179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B30082B81;
	Thu,  2 Sep 2021 16:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XnNtN3owm91N; Thu,  2 Sep 2021 16:09:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9988A82C3B;
	Thu,  2 Sep 2021 16:09:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C762C001A;
	Thu,  2 Sep 2021 16:09:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D531C001A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 16:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A37B82C3B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 16:09:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6seyOp1p4aor
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 16:09:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8749382B51
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630598966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mXH2n/UZqZkS6UTydkV0bNVxlvNTafikkYo4yOh5+V8=;
 b=G9BYcg12YhjBYRoP7PZB9943jOJRBT5zsiy7X5i2g1qarG8EZFph7ANRTBWeiJ/xCs4J28
 No+7esdR9IFVCIfa0r7WPfL78JenCUABowTJ+ze+NlJp0Nmu/R7aJF3YVIo3r5scunTajV
 IAUaItgTqSNiYI9WYeFow3N0mjvDWmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-vQyWhdU8OqijUtU0czrTOg-1; Thu, 02 Sep 2021 12:09:25 -0400
X-MC-Unique: vQyWhdU8OqijUtU0czrTOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87C2D835DE0;
 Thu,  2 Sep 2021 16:09:23 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6637360853;
 Thu,  2 Sep 2021 16:09:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] virtio-mem: disallow mapping virtio-mem memory via
 /dev/mem
Date: Thu,  2 Sep 2021 18:09:16 +0200
Message-Id: <20210902160919.25683-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

I think this might be a good fit for the -mm tree, as the actual virtio-mem
changes are rather small.

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
 3 files changed, 43 insertions(+), 16 deletions(-)


base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
