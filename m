Return-Path: <SRS0=Jt+z=NQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3D1C4338F
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 10:24:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B05D6120A
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 10:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B05D6120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D09A360BD3;
	Wed, 25 Aug 2021 10:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r_SwkyPoBJPU; Wed, 25 Aug 2021 10:24:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6CB8A60835;
	Wed, 25 Aug 2021 10:24:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 507E1C0010;
	Wed, 25 Aug 2021 10:24:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39004C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 10:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2881060B4E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 10:24:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id liqHjrj0uGtY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 10:24:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B96C560835
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629887068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WVyb3Uv0Tbq8Di9FJJZjAihDGm9Mo6ze8JS8vqgSS3g=;
 b=EAfkLpsXlUScSo+qIYiRw+mmXPIdee+TkcwjPt14m4sIEOHROWcW+qqbW8Cgr3I9ib7C+V
 PhCmEcBz1LPwRO3K2lNeHKZmgrc/N2gwlZllBNKFJSB55bPYuOqfK9wOMz1yUJOv6EYi6x
 6Tokuv7EX9J9laYfJLKvYkzwmiEofeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-plshk3JbP2qnDyiPWsUHPQ-1; Wed, 25 Aug 2021 06:24:25 -0400
X-MC-Unique: plshk3JbP2qnDyiPWsUHPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F2ADF8AC;
 Wed, 25 Aug 2021 10:24:24 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83E545C1D1;
 Wed, 25 Aug 2021 10:24:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1] virtio-mem: fix sleeping in RCU read side section in
 virtio_mem_online_page_cb()
Date: Wed, 25 Aug 2021 12:24:15 +0200
Message-Id: <20210825102415.7516-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

virtio_mem_set_fake_offline() might sleep now, and we call it under
rcu_read_lock(). To fix it, simply move the rcu_read_unlock() further
up, as we're done with the device.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 6cc26d77613a: "virtio-mem: use page_offline_(start|end) when setting PageOffline()
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---

The problematic commit is in v5.14-rc1 .. v5.14-rc7, but it suspect
might be too late for v5.14.

The original commit went upstream via Andrews tree, we could take this fix
via Andrews tree as well or via the vhost tree (MST), I don't particularly
care. (putting Linus on CC just in case)

---
 drivers/virtio/virtio_mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 09ed55de07d7..b91bc810a87e 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1242,12 +1242,19 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 			do_online = virtio_mem_bbm_get_bb_state(vm, id) !=
 				    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE;
 		}
+
+		/*
+		 * virtio_mem_set_fake_offline() might sleep, we don't need
+		 * the device anymore. See virtio_mem_remove() how races
+		 * between memory onlining and device removal are handled.
+		 */
+		rcu_read_unlock();
+
 		if (do_online)
 			generic_online_page(page, order);
 		else
 			virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
 						    false);
-		rcu_read_unlock();
 		return;
 	}
 	rcu_read_unlock();
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
