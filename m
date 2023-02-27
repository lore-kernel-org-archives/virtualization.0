Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98944C64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 21:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1933841807;
	Mon, 27 Feb 2023 21:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1933841807
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WhrfJGdT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XxILMmma05oF; Mon, 27 Feb 2023 21:41:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 308A7416A5;
	Mon, 27 Feb 2023 21:41:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 308A7416A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 083E4C0032;
	Mon, 27 Feb 2023 21:41:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BB76C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 21:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19DB781469
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 21:41:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19DB781469
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WhrfJGdT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nogs5Qz_r45B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 21:41:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2832B8146A
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2832B8146A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677534094; x=1709070094;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5wnJ1Z7C8ZgfhrFhylj3bD2ZDIO5SaRzfsMBJ/57TjA=;
 b=WhrfJGdT2OZHE63fROhSIoyBbo2AOX0G5x7X/VYlNNBrYpNh99MRV2DR
 MM3VDkmrO9DAqjCo1JS4CLtH8h7E3N5f838WGt8BPZdGZYHN2iLP6p5wk
 J9QLDUfbE3gag8NI8D3mTfryZ9QD93dTvhfTGIXhbju2g1kDIXAPzHdJR
 WJr6qLyJof4g4/2OfYHxi/YElEQH3+WuK/yfE39KJZ0h1Mw4ehgrB4Q90
 Y0IkZ2yPcVvhFA7/DZJugOzVxqk3YBu9DisBnHBMAOAf4Jy+H/lOJLz++
 /DkKOBVeGQ582SmS9KHhvFNmQChdaT8jB5vHQsefgFNp7pp5BaE3h2yYg w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="331448954"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; d="scan'208";a="331448954"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2023 13:41:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="667194622"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; d="scan'208";a="667194622"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.1])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2023 13:41:32 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
To: kvm@vger.kernel.org
Subject: [PATCH] vhost: use struct_size and size_add to compute flex array
 sizes
Date: Mon, 27 Feb 2023 13:41:27 -0800
Message-Id: <20230227214127.3678392-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
MIME-Version: 1.0
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

The vhost_get_avail_size and vhost_get_used_size functions compute the size
of structures with flexible array members with an additional 2 bytes if the
VIRTIO_RING_F_EVENT_IDX feature flag is set. Convert these functions to use
struct_size() and size_add() instead of coding the calculation by hand.

This ensures that the calculations will saturate at SIZE_MAX rather than
overflowing.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
---

I found this using a coccinelle patch I developed and submitted at [1].

[1]: https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/

 drivers/vhost/vhost.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f11bdbe4c2c5..43fa626d4e44 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -436,8 +436,7 @@ static size_t vhost_get_avail_size(struct vhost_virtqueue *vq,
 	size_t event __maybe_unused =
 	       vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 
-	return sizeof(*vq->avail) +
-	       sizeof(*vq->avail->ring) * num + event;
+	return size_add(struct_size(vq->avail, ring, num), event);
 }
 
 static size_t vhost_get_used_size(struct vhost_virtqueue *vq,
@@ -446,8 +445,7 @@ static size_t vhost_get_used_size(struct vhost_virtqueue *vq,
 	size_t event __maybe_unused =
 	       vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 
-	return sizeof(*vq->used) +
-	       sizeof(*vq->used->ring) * num + event;
+	return size_add(struct_size(vq->used, ring, num), event);
 }
 
 static size_t vhost_get_desc_size(struct vhost_virtqueue *vq,
-- 
2.39.1.405.gd4c25cc71f83

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
