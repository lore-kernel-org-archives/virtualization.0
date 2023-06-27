Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AC7EB64DC
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 11:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C965418DE;
	Tue, 27 Jun 2023 11:22:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C965418DE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DmL5UPYN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tWz-EL_qUUlz; Tue, 27 Jun 2023 11:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2C7184175D;
	Tue, 27 Jun 2023 11:22:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C7184175D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F22ECC007C;
	Tue, 27 Jun 2023 11:22:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAB2AC0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77C5860BB3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77C5860BB3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DmL5UPYN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KTYpjJUnVXJn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B747E611E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B747E611E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687864963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+JMX7PmWMV8slSmifeWswXiVAWwIFJBeTLnY9EmnBs=;
 b=DmL5UPYNTFGr2c1YxXOLGaWXYIJjnviz5YjQG1/mr5Doj02sMTGjn7Xuf/EI9z4VdaJ9Su
 UezqTjfguEyeU5lRixtdyWt/eA935Ym8Y7ogG95tmqKhvCtdZKk3eYfFp4UQKUMiFYtM6B
 2umo7VwNmeKGtPPWux9K0fiGLhux+3Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-_3hHQO3VOiqe86__7AxxGg-1; Tue, 27 Jun 2023 07:22:38 -0400
X-MC-Unique: _3hHQO3VOiqe86__7AxxGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE10B858290;
 Tue, 27 Jun 2023 11:22:37 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E37C0200A3AD;
 Tue, 27 Jun 2023 11:22:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] virtio-mem: check if the config changed before (fake)
 offlining memory
Date: Tue, 27 Jun 2023 13:22:20 +0200
Message-Id: <20230627112220.229240-6-david@redhat.com>
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

If we repeatedly fail to (fake) offline memory, we won't be sending
any unplug requests to the device. However, we only check if the config
changed when sending such (un)plug requests.

So we could end up trying for a long time to offline memory, even though
the config changed already and we're not supposed to unplug memory
anymore.

Let's optimize for that case, identified while testing the
offline_and_remove() memory timeout and simulating it repeatedly running
into the timeout.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 7468b4a907e3..247fb3e0ce61 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1922,6 +1922,10 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 	unsigned long start_pfn;
 	int rc;
 
+	/* Stop fake offlining attempts if the config changed. */
+	if (atomic_read(&vm->config_changed))
+		return -EAGAIN;
+
 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			     sb_id * vm->sbm.sb_size);
 
@@ -2233,6 +2237,10 @@ static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 		virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
 			cond_resched();
 
+			/* Stop (fake) offlining attempts if the config changed. */
+			if (atomic_read(&vm->config_changed))
+				return -EAGAIN;
+
 			/*
 			 * As we're holding no locks, these checks are racy,
 			 * but we don't care.
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
