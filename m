Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D674C433E7
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEC721BE5
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzmdmnGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEC721BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E5BFB2094B;
	Mon, 12 Oct 2020 12:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNnbTXMEhqus; Mon, 12 Oct 2020 12:57:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 07038207A6;
	Mon, 12 Oct 2020 12:57:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5810C07FF;
	Mon, 12 Oct 2020 12:57:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66B14C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6185A207B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6h71AxtRE2H
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 8A9DC207A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602507430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asIQsS+oC8Mh53hgYBA1tcFGDTsXY+ZpGUk2qX42/rw=;
 b=YzmdmnGjunSjsN2wPIbj8YBzTs2EMzm9rND+CMsdPhwaDfUfuKErM7xHylOFuPx2ZNVerC
 4jItV3Gb1VTsM1RNW7wPCnNu0gaUmmibG5HKjm72nR7ljwZkk7zQsdCr9pcUCZtANNyI69
 rHmDTAJECiUepu0bl2yqnUbMXQiAfgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-LEt0s25AMBaPT6YEHVoaUw-1; Mon, 12 Oct 2020 08:57:06 -0400
X-MC-Unique: LEt0s25AMBaPT6YEHVoaUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05422107464C;
 Mon, 12 Oct 2020 12:57:05 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C44F960C07;
 Mon, 12 Oct 2020 12:56:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 26/29] virtio-mem: allow to force Big Block Mode (BBM) and
 set the big block size
Date: Mon, 12 Oct 2020 14:53:20 +0200
Message-Id: <20201012125323.17509-27-david@redhat.com>
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

Let's allow to force BBM, even if subblocks would be possible. Take care
of properly calculating the first big block id, because the start
address might no longer be aligned to the big block size.

Also, allow to manually configure the size of Big Blocks.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 4d396ef98a92..94cf44b15cbf 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -27,6 +27,16 @@ static bool unplug_online = true;
 module_param(unplug_online, bool, 0644);
 MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
 
+static bool force_bbm;
+module_param(force_bbm, bool, 0444);
+MODULE_PARM_DESC(force_bbm,
+		"Force Big Block Mode. Default is 0 (auto-selection)");
+
+static unsigned long bbm_block_size;
+module_param(bbm_block_size, ulong, 0444);
+MODULE_PARM_DESC(bbm_block_size,
+		 "Big Block size in bytes. Default is 0 (auto-detection).");
+
 /*
  * virtio-mem currently supports the following modes of operation:
  *
@@ -2164,7 +2174,7 @@ static int virtio_mem_init(struct virtio_mem *vm)
 			pageblock_nr_pages) * PAGE_SIZE;
 	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
 
-	if (sb_size < memory_block_size_bytes()) {
+	if (sb_size < memory_block_size_bytes() && !force_bbm) {
 		/* SBM: At least two subblocks per Linux memory block. */
 		vm->in_sbm = true;
 		vm->sbm.sb_size = sb_size;
@@ -2177,9 +2187,24 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		vm->sbm.next_mb_id = vm->sbm.first_mb_id;
 	} else {
 		/* BBM: At least one Linux memory block. */
-		vm->bbm.bb_size = vm->device_block_size;
+		vm->bbm.bb_size = max_t(uint64_t, vm->device_block_size,
+					memory_block_size_bytes());
+
+		if (bbm_block_size) {
+			if (!is_power_of_2(bbm_block_size)) {
+				dev_warn(&vm->vdev->dev,
+					 "bbm_block_size is not a power of 2");
+			} else if (bbm_block_size < vm->bbm.bb_size) {
+				dev_warn(&vm->vdev->dev,
+					 "bbm_block_size is too small");
+			} else {
+				vm->bbm.bb_size = bbm_block_size;
+			}
+		}
 
-		vm->bbm.first_bb_id = virtio_mem_phys_to_bb_id(vm, vm->addr);
+		/* Round up to the next aligned big block */
+		addr = vm->addr + vm->bbm.bb_size - 1;
+		vm->bbm.first_bb_id = virtio_mem_phys_to_bb_id(vm, addr);
 		vm->bbm.next_bb_id = vm->bbm.first_bb_id;
 	}
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
