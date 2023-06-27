Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56272EB64DD
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 11:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9FBC8215C;
	Tue, 27 Jun 2023 11:22:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9FBC8215C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=erBmXhLc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WOrBud6w_9HE; Tue, 27 Jun 2023 11:22:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2446F81CBA;
	Tue, 27 Jun 2023 11:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2446F81CBA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3E99C007C;
	Tue, 27 Jun 2023 11:22:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 326A6C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BD9741772
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BD9741772
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=erBmXhLc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nBbJJ9u-GNcA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 210364175D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 210364175D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687864954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4aSs18Pv+ZzmA9Rj2C8nVvP+WDMPcyKRh1O4HH29Hbc=;
 b=erBmXhLcw+gWawuIpu2NJNCejYv8B0uPjOKKZYjhdn7frqBUEMQ57KxKlDzxLbphnqJbtD
 5h3KOoD4xfMQicotbG7SfUGEL3kWvDjKJywwRFDjPzax/gUDq47TQ7gq74ybuUEJCKgk1G
 yQ8m8zPClzZQcRGkLg9WIyu0WS0ItnI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-y_sQWVhBPMapPH_5wxp9qg-1; Tue, 27 Jun 2023 07:22:32 -0400
X-MC-Unique: y_sQWVhBPMapPH_5wxp9qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA5553814947;
 Tue, 27 Jun 2023 11:22:31 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30867200A3AD;
 Tue, 27 Jun 2023 11:22:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] virtio-mem: convert most offline_and_remove_memory()
 errors to -EBUSY
Date: Tue, 27 Jun 2023 13:22:17 +0200
Message-Id: <20230627112220.229240-3-david@redhat.com>
In-Reply-To: <20230627112220.229240-1-david@redhat.com>
References: <20230627112220.229240-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
 John Hubbard <jhubbard@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
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

Let's prepare for offline_and_remove_memory() to return other error
codes that effectively translate to -EBUSY, such as -ETIMEDOUT.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 835f6cc2fb66..cb8bc6f6aa90 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -750,7 +750,15 @@ static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
 		dev_dbg(&vm->vdev->dev,
 			"offlining and removing memory failed: %d\n", rc);
 	}
-	return rc;
+
+	switch (rc) {
+	case 0:
+	case -ENOMEM:
+	case -EINVAL:
+		return rc;
+	default:
+		return -EBUSY;
+	}
 }
 
 /*
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
