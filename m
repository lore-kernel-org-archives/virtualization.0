Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F5C47083
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 18:58:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB40D613D2
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 18:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB40D613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E01E40550;
	Wed,  2 Jun 2021 18:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bTyeYvUT7i1h; Wed,  2 Jun 2021 18:58:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 092CC4053B;
	Wed,  2 Jun 2021 18:58:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7DF3C000E;
	Wed,  2 Jun 2021 18:58:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DA42C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C8FF40541
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CZxY5B6T27Gi
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:58:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B6C64053B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622660295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=di/rBgpO3ofh6oyQUWmcuqLGaaUuBYS2slt2/XE3Gtc=;
 b=BO+G5/BK2L0Km6r7FQLPfgLuXGGQmx3saBaV/7Q3pokYS0SlJf5bWEVZdGv0/hZm7X2mic
 +7TD2z4YHQFjsIOUqVt4lf1sd9myzZkhkl8U5YS3CedFyC909/NL5a6bms/DkadNcoyTJH
 T473NDJ0W2bkzFbP90EnQ95N6TrYuz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-dILL77kCN9SXtJzC6wQM5Q-1; Wed, 02 Jun 2021 14:58:14 -0400
X-MC-Unique: dILL77kCN9SXtJzC6wQM5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 616608015F8;
 Wed,  2 Jun 2021 18:58:12 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-159.ams2.redhat.com [10.36.114.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6C30100238C;
 Wed,  2 Jun 2021 18:57:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/7] virtio-mem: prioritize unplug from ZONE_MOVABLE in Big
 Block Mode
Date: Wed,  2 Jun 2021 20:57:20 +0200
Message-Id: <20210602185720.31821-8-david@redhat.com>
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

Let's handle unplug in Big Block Mode similar to Sub Block Mode --
prioritize memory blocks onlined to ZONE_MOVABLE.

We won't care further about big blocks with mixed zones, as it's
rather a corner case that won't matter in practice.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 43199389c414..d3e874b6b50b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2121,6 +2121,29 @@ static bool virtio_mem_bbm_bb_is_offline(struct virtio_mem *vm,
 	return true;
 }
 
+/*
+ * Test if a big block is completely onlined to ZONE_MOVABLE (or offline).
+ */
+static bool virtio_mem_bbm_bb_is_movable(struct virtio_mem *vm,
+					 unsigned long bb_id)
+{
+	const unsigned long start_pfn = PFN_DOWN(virtio_mem_bb_id_to_phys(vm, bb_id));
+	const unsigned long nr_pages = PFN_DOWN(vm->bbm.bb_size);
+	struct page *page;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < start_pfn + nr_pages;
+	     pfn += PAGES_PER_SECTION) {
+		page = pfn_to_online_page(pfn);
+		if (!page)
+			continue;
+		if (page_zonenum(page) != ZONE_MOVABLE)
+			return false;
+	}
+
+	return true;
+}
+
 static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 {
 	uint64_t nb_bb = diff / vm->bbm.bb_size;
@@ -2134,7 +2157,7 @@ static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	 * Try to unplug big blocks. Similar to SBM, start with offline
 	 * big blocks.
 	 */
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < 3; i++) {
 		virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
 			cond_resched();
 
@@ -2144,6 +2167,8 @@ static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 			 */
 			if (i == 0 && !virtio_mem_bbm_bb_is_offline(vm, bb_id))
 				continue;
+			if (i == 1 && !virtio_mem_bbm_bb_is_movable(vm, bb_id))
+				continue;
 			rc = virtio_mem_bbm_offline_remove_and_unplug_bb(vm, bb_id);
 			if (rc == -EBUSY)
 				continue;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
