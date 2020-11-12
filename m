Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A9AC2D0A3
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2826D22249
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNx0cm8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2826D22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B100F870BE;
	Thu, 12 Nov 2020 13:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ovDatzt-Tjyf; Thu, 12 Nov 2020 13:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 458398709E;
	Thu, 12 Nov 2020 13:38:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E2DEC088B;
	Thu, 12 Nov 2020 13:38:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE117C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E58D4870C4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r3Homq7BIbI5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CEB6D870E1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/q5ADxWs1ReqxtomGdawJvY3H3MZGMG2OFcFur4kQ1Y=;
 b=ZNx0cm8kKfL5a8sA49zcRelHu7cePFlZT+nhDfQvvK+6dpl8KTc7FRQHA7HrJVN0tPsJJr
 TUbrrdgNPMQyg55tSrb6ZbfQMbuxv/DDP9FpOud7/PTLu+jOh52xIX978WczS74HoP51/q
 /+LwuTAXpoiHlDfrlvoZQmba2N0t2aQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-CBo_IWUqMcyu5d0Rg8eMPg-1; Thu, 12 Nov 2020 08:38:37 -0500
X-MC-Unique: CBo_IWUqMcyu5d0Rg8eMPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFF7809DE5;
 Thu, 12 Nov 2020 13:38:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA7FC75132;
 Thu, 12 Nov 2020 13:38:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/29] virtio-mem: use "unsigned long" for nr_pages when
 fake onlining/offlining
Date: Thu, 12 Nov 2020 14:37:51 +0100
Message-Id: <20201112133815.13332-6-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
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

No harm done, but let's be consistent.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 4f18d9855a0e..94451b401fba 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -717,7 +717,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
  * (via generic_online_page()) using PageDirty().
  */
 static void virtio_mem_set_fake_offline(unsigned long pfn,
-					unsigned int nr_pages, bool onlined)
+					unsigned long nr_pages, bool onlined)
 {
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
@@ -736,7 +736,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
  * (via generic_online_page()), clear PageDirty().
  */
 static void virtio_mem_clear_fake_offline(unsigned long pfn,
-					  unsigned int nr_pages, bool onlined)
+					  unsigned long nr_pages, bool onlined)
 {
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
@@ -751,10 +751,10 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
  * Release a range of fake-offline pages to the buddy, effectively
  * fake-onlining them.
  */
-static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
+static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 {
 	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
-	int i;
+	unsigned long i;
 
 	/*
 	 * We are always called at least with MAX_ORDER_NR_PAGES
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
