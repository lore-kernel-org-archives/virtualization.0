Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FBEC47092
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 18:57:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EF6613E6
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 18:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EF6613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6659D83D7E;
	Wed,  2 Jun 2021 18:57:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lIe5FHPQ7X6D; Wed,  2 Jun 2021 18:57:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DCB983D53;
	Wed,  2 Jun 2021 18:57:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A60B6C0025;
	Wed,  2 Jun 2021 18:57:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4F9BC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A46974043E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8y3EZSeWZgoD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:57:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2A45402C0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622660260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3Rr8y/gYMFVQQ9zxTRXUVMiIYcjAZ+xHEUKvzbChl8=;
 b=C3dkFV54qntLPoEuDeEezmeNd9uQIwTvByWobAPOmWwv7+nl05pg2TtPqTUO/ydX/HB6E1
 aGwu1pOqmyrkb4EoW1RGD/4ym7cCH4BTsnklNYnVaVmmOa+rDIT/VROmD07FC7wvRmdkJe
 Lwpp4rtgqzM3Mnzt6TCqiwoBYsTElgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-KHuHPUvZPG6xV3805T8KUQ-1; Wed, 02 Jun 2021 14:57:37 -0400
X-MC-Unique: KHuHPUvZPG6xV3805T8KUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83205801106;
 Wed,  2 Jun 2021 18:57:35 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-159.ams2.redhat.com [10.36.114.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5960100238C;
 Wed,  2 Jun 2021 18:57:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] virtio-mem: don't read big block size in Sub Block Mode
Date: Wed,  2 Jun 2021 20:57:14 +0200
Message-Id: <20210602185720.31821-2-david@redhat.com>
In-Reply-To: <20210602185720.31821-1-david@redhat.com>
References: <20210602185720.31821-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
 Marek Kedzierski <mkedzier@redhat.com>, Hui Zhu <teawater@gmail.com>,
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

We are reading a Big Block Mode value while in Sub Block Mode
when initializing. Fortunately, vm->bbm.bb_size maps to some counter
in the vm->sbm.mb_count array, which is 0 at that point in time.

No harm done; still, this was unintended and is not future-proof.

Fixes: 4ba50cd3355d ("virtio-mem: Big Block Mode (BBM) memory hotplug")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 10ec60d81e84..3bf08b5bb359 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2420,6 +2420,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		dev_warn(&vm->vdev->dev,
 			 "Some device memory is not addressable/pluggable. This can make some memory unusable.\n");
 
+	/* Prepare the offline threshold - make sure we can add two blocks. */
+	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
+				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
+
 	/*
 	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
 	 * pageblock_nr_pages pages. This:
@@ -2466,14 +2470,11 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		       vm->bbm.bb_size - 1;
 		vm->bbm.first_bb_id = virtio_mem_phys_to_bb_id(vm, addr);
 		vm->bbm.next_bb_id = vm->bbm.first_bb_id;
-	}
 
-	/* Prepare the offline threshold - make sure we can add two blocks. */
-	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
-				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
-	/* In BBM, we also want at least two big blocks. */
-	vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
-				      vm->offline_threshold);
+		/* Make sure we can add two big blocks. */
+		vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
+					      vm->offline_threshold);
+	}
 
 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
