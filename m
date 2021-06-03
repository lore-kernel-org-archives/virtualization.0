Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF064C47092
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEE861359
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEE861359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54D6883D63;
	Thu,  3 Jun 2021 00:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FxE0EzwvNhk5; Thu,  3 Jun 2021 00:41:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E986B83D53;
	Thu,  3 Jun 2021 00:41:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4409FC0029;
	Thu,  3 Jun 2021 00:41:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3029AC002D;
 Thu,  3 Jun 2021 00:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDFA583D3E;
 Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b3P6Cr5oM7ij; Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E3D583D4A;
 Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
IronPort-SDR: 1ba48w/HGThOaZWmvPgbg3vFM0auzFspQ4Pdsew0tnIawxeIo6nZAmniY9M54xZkST8DY5L6/D
 2F5g43wXo/JQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191281566"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="191281566"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
IronPort-SDR: RcO/ziDZiA0zs9KDBzMVcDfkcrCyK0CG+VkWlPWMtZabfLPdUI3KlbztMzBnu5W2HGau7uO170
 UmLD4vf1CVKw==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="549686675"
Received: from tassilo.jf.intel.com ([10.54.74.11])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: mst@redhat.com
Subject: [PATCH v1 1/8] virtio: Force only split mode with protected guest
Date: Wed,  2 Jun 2021 17:41:26 -0700
Message-Id: <20210603004133.4079390-2-ak@linux.intel.com>
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

When running under TDX the virtio host is untrusted. The bulk
of the kernel memory is encrypted and protected, but the virtio
ring is in special shared memory that is shared with the
untrusted host.

This means virtio needs to be hardened against any attacks from
the host through the ring. Of course it's impossible to prevent DOS
(the host can chose at any time to stop doing IO), but there
should be no buffer overruns or similar that might give access to
any private memory in the guest.

virtio has a lot of modes, most are difficult to harden.

The best for hardening seems to be split mode without indirect
descriptors. This also simplifies the hardening job because
it's only a single code path.

Only allow split mode when in a protected guest. Followon
patches harden the split mode code paths, and we don't want
an malicious host to force anything else. Also disallow
indirect mode for similar reasons.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71e16b53e9c1..f35629fa47b1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
+#include <linux/protected_guest.h>
 #include <xen/xen.h>
 
 #ifdef DEBUG
@@ -2221,8 +2222,16 @@ void vring_transport_features(struct virtio_device *vdev)
 	unsigned int i;
 
 	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++) {
+
+		/*
+		 * In protected guest mode disallow packed or indirect
+		 * because they ain't hardened.
+		 */
+
 		switch (i) {
 		case VIRTIO_RING_F_INDIRECT_DESC:
+			if (protected_guest_has(VM_MEM_ENCRYPT))
+				goto clear;
 			break;
 		case VIRTIO_RING_F_EVENT_IDX:
 			break;
@@ -2231,9 +2240,12 @@ void vring_transport_features(struct virtio_device *vdev)
 		case VIRTIO_F_ACCESS_PLATFORM:
 			break;
 		case VIRTIO_F_RING_PACKED:
+			if (protected_guest_has(VM_MEM_ENCRYPT))
+				goto clear;
 			break;
 		case VIRTIO_F_ORDER_PLATFORM:
 			break;
+		clear:
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
