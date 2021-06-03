Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C619BC47083
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4301061361
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4301061361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1720D40542;
	Thu,  3 Jun 2021 00:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fw4PH42t4PI5; Thu,  3 Jun 2021 00:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 454A240556;
	Thu,  3 Jun 2021 00:41:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E31AC002D;
	Thu,  3 Jun 2021 00:41:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FB49C002F;
 Thu,  3 Jun 2021 00:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42B6160692;
 Thu,  3 Jun 2021 00:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-IOlqWXKrfz; Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98C0F608A3;
 Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
IronPort-SDR: A9qbVTtF0XgQXj54JSLGGcWZOxeogjGd3UCmDAZxj+hi1cniB9P1ANyuNibu3blcfk7I7yrWgH
 81wJh+HmgTDA==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191281575"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="191281575"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:45 -0700
IronPort-SDR: 2pFejv7yOdCVkt/FpXsrK39AE0n8XlGFbMG7ggDFwWorVajHKUYwALrKujQ9Giok8owwu3kAMW
 bk1Ny78Bc9jg==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="549686683"
Received: from tassilo.jf.intel.com ([10.54.74.11])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: mst@redhat.com
Subject: [PATCH v1 8/8] virtio: Error out on endless free lists
Date: Wed,  2 Jun 2021 17:41:33 -0700
Message-Id: <20210603004133.4079390-9-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
MIME-Version: 1.0
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com
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

Error out with a warning when the free list loops longer
than the maximum size while freeing descriptors. While technically
we don't care about DOS it is still better to abort it early.

We ran into this problem while fuzzing the virtio interactions
where the fuzzed code would get stuck for a long time.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 244a5b62d85c..96adaa4c5404 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -685,6 +685,11 @@ static int detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		if (!inside_split_ring(vq, i))
 			return -EIO;
 		vq->vq.num_free++;
+		if (WARN_ONCE(vq->vq.num_free >
+				vq->split.queue_size_in_bytes /
+					sizeof(struct vring_desc),
+				"Virtio freelist corrupted"))
+			return -EIO;
 	}
 
 	vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
