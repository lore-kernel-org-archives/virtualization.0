Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F8C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 06:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 613BB4063C;
	Thu, 25 Nov 2021 06:06:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FlHrEywjjBW1; Thu, 25 Nov 2021 06:06:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB074405BC;
	Thu, 25 Nov 2021 06:06:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCE56C002F;
	Thu, 25 Nov 2021 06:06:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 170AAC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E69C7824B4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:06:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqgwyVlQDtmw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:06:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3FF382496
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637820367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1irKUJW33SWAxC/Ee23IycmsJtDByo2UcVUyInCyu64=;
 b=a9fyQGhGMS/CzYmAkgaPyAiRga05hOc6ja0kCwmerFHjyzSomNurMY70tSsZlgzqQb1iiK
 le1P7ZHBGPdxP6a8UJzbTuABg5FjNBBzjATMeBCs6rvUT3oXS0Hay1oR9Qkw2y00kIfaJ4
 dhs2NUOY4pDbhLYkO05Lf/QbnPaiQ8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-Yjjv7UETM-aFQhwCBHqOUA-1; Thu, 25 Nov 2021 01:06:04 -0500
X-MC-Unique: Yjjv7UETM-aFQhwCBHqOUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3D778042E2;
 Thu, 25 Nov 2021 06:06:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-162.pek2.redhat.com
 [10.72.12.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA545F4ED;
 Thu, 25 Nov 2021 06:05:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH net] virtio-net: enable big mode correctly
Date: Thu, 25 Nov 2021 14:05:47 +0800
Message-Id: <20211125060547.11961-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: netdev@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
large max_mtu. In this case, using small packet mode is not correct
since it may breaks the networking when MTU is grater than
ETH_DATA_LEN.

To have a quick fix, simply enable the big packet mode when
VIRTIO_NET_F_MTU is not negotiated. We can do optimization on top.

Reported-by: Eli Cohen <elic@nvidia.com>
Cc: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7c43bfc1ce44..83ae3ef5eb11 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->mtu = mtu;
 		dev->max_mtu = mtu;
 
-		/* TODO: size buffers correctly in this case. */
-		if (dev->mtu > ETH_DATA_LEN)
-			vi->big_packets = true;
 	}
 
+	/* TODO: size buffers correctly in this case. */
+	if (dev->max_mtu > ETH_DATA_LEN)
+		vi->big_packets = true;
+
 	if (vi->any_header_sg)
 		dev->needed_headroom = vi->hdr_len;
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
