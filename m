Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AFAC0015E
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF143613BF;
	Thu, 13 Jul 2023 14:56:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF143613BF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gNSwROuc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lf8qqW7fEAft; Thu, 13 Jul 2023 14:56:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 59503613B5;
	Thu, 13 Jul 2023 14:56:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59503613B5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34CD9C0071;
	Thu, 13 Jul 2023 14:56:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DFFAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 161E9613B5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 161E9613B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kx0BJifHmJgY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 21C336139F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21C336139F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689260166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bk+toP/Ed4qPpAgMLWeptgvuADn7go/7Jo6jlttF96s=;
 b=gNSwROucsZMlcoBwn+p2eERWuaXeVuw+ri+Gq2TpGXSI3q7kzYg33kF9tQXZx3K5T6J9dH
 NC/cKna0b6CNW7GLFa17Rt/WRrMgnBOuXgOfSbZTPPNWhXCER+4RI5KaUX8ddsaXfqsO0i
 IBJ94gFqHvglentirGpwYhLealUd3l4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-pEnhlwaAPsitRYud8qL9ig-1; Thu, 13 Jul 2023 10:56:02 -0400
X-MC-Unique: pEnhlwaAPsitRYud8qL9ig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58A8086F122;
 Thu, 13 Jul 2023 14:56:02 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 197A0F66CB;
 Thu, 13 Jul 2023 14:56:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] virtio-mem: check if the config changed before fake
 offlining memory
Date: Thu, 13 Jul 2023 16:55:51 +0200
Message-ID: <20230713145551.2824980-5-david@redhat.com>
In-Reply-To: <20230713145551.2824980-1-david@redhat.com>
References: <20230713145551.2824980-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org
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

If we repeatedly fail to fake offline memory to unplug it, we won't be
sending any unplug requests to the device. However, we only check if the
config changed when sending such (un)plug requests.

We could end up trying for a long time to unplug memory, even though
the config changed already and we're not supposed to unplug memory
anymore. For example, the hypervisor might detect a low-memory situation
while unplugging memory and decide to replug some memory. Continuing
trying to unplug memory in that case can be problematic.

So let's check on a more regular basis.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a5cf92e3e5af..fa5226c198cc 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1189,7 +1189,8 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
  * Try to allocate a range, marking pages fake-offline, effectively
  * fake-offlining them.
  */
-static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
+static int virtio_mem_fake_offline(struct virtio_mem *vm, unsigned long pfn,
+				   unsigned long nr_pages)
 {
 	const bool is_movable = is_zone_movable_page(pfn_to_page(pfn));
 	int rc, retry_count;
@@ -1202,6 +1203,14 @@ static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
 	 * some guarantees.
 	 */
 	for (retry_count = 0; retry_count < 5; retry_count++) {
+		/*
+		 * If the config changed, stop immediately and go back to the
+		 * main loop: avoid trying to keep unplugging if the device
+		 * might have decided to not remove any more memory.
+		 */
+		if (atomic_read(&vm->config_changed))
+			return -EAGAIN;
+
 		rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
 					GFP_KERNEL);
 		if (rc == -ENOMEM)
@@ -1951,7 +1960,7 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			     sb_id * vm->sbm.sb_size);
 
-	rc = virtio_mem_fake_offline(start_pfn, nr_pages);
+	rc = virtio_mem_fake_offline(vm, start_pfn, nr_pages);
 	if (rc)
 		return rc;
 
@@ -2149,7 +2158,7 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 		if (!page)
 			continue;
 
-		rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
+		rc = virtio_mem_fake_offline(vm, pfn, PAGES_PER_SECTION);
 		if (rc) {
 			end_pfn = pfn;
 			goto rollback;
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
