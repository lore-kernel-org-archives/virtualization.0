Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B91C0015E
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5521A41759;
	Thu, 13 Jul 2023 14:56:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5521A41759
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sq8VJqeM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0j5Wqd3E3QYf; Thu, 13 Jul 2023 14:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E19F441763;
	Thu, 13 Jul 2023 14:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E19F441763
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCD00C0DD4;
	Thu, 13 Jul 2023 14:56:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6548DC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F2124208D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F2124208D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sq8VJqeM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J3fcMaJGIIyk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71EFD4208C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71EFD4208C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689260161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvagZqP7r7JhOH2HSmKVW5dMeNgJcBr/tywkzsCuQEE=;
 b=Sq8VJqeMMVAW+HhHwmBoefB78zv3aqKFmtPLTQfZW+DSOI2fQaxueB5f/URpV48EWmHOdh
 0TCOX/fr0GvyVOUGrvdu2WVHIedS02RJ++mOMa96JOnY6PtTwC+JBijtPVGHcW2JmSdl1a
 p/nxtP7O+TnkD+2s8PNxa5nkeyvXT+A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-nm4gKlnDNE-L9galCwEr3g-1; Thu, 13 Jul 2023 10:55:59 -0400
X-MC-Unique: nm4gKlnDNE-L9galCwEr3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 640A63815F7E;
 Thu, 13 Jul 2023 14:55:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0225F66D7;
 Thu, 13 Jul 2023 14:55:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] virtio-mem: convert most offline_and_remove_memory()
 errors to -EBUSY
Date: Thu, 13 Jul 2023 16:55:49 +0200
Message-ID: <20230713145551.2824980-3-david@redhat.com>
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

Just like we do with alloc_contig_range(), let's convert all unknown
errors to -EBUSY, but WARN so we can look into the issue. For example,
offline_pages() could fail with -EINTR, which would be unexpected in our
case.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index ed15d2a4bd96..1a76ba2bc118 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -741,11 +741,15 @@ static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
 		 * immediately instead of waiting.
 		 */
 		virtio_mem_retry(vm);
-	} else {
-		dev_dbg(&vm->vdev->dev,
-			"offlining and removing memory failed: %d\n", rc);
+		return 0;
 	}
-	return rc;
+	dev_dbg(&vm->vdev->dev, "offlining and removing memory failed: %d\n", rc);
+	/*
+	 * We don't really expect this to fail, because we fake-offlined all
+	 * memory already. But it could fail in corner cases.
+	 */
+	WARN_ON_ONCE(rc != -ENOMEM && rc != -EBUSY);
+	return rc == -ENOMEM ? -ENOMEM : -EBUSY;
 }
 
 /*
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
