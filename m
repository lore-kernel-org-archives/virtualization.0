Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6437CC4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 08:16:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D0D60FC0
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 08:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3D0D60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFF1E6069B;
	Wed, 11 Aug 2021 08:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srJvWs8vpdxT; Wed, 11 Aug 2021 08:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 48D6960633;
	Wed, 11 Aug 2021 08:16:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D4E7C0010;
	Wed, 11 Aug 2021 08:16:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61A9FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A0AF402A8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8mr1dX0JccIe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:16:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 565B7400F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628669801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zI0/uAuYDFBcIURwjRZoalT1u5FlB/tQ3FmUvIqhq04=;
 b=H8AC18OwRBQ6WFRZK1xK3LUhPLzAcePvevC+QFzUaV/OxmCVhd6R7BIlsnrIVy6Da5mKk6
 Ke48lmPSGnGJOVadFfKMyZEWyUVCoLyO9VcHExNTrUHTE8lcaWbzaNCNbnR9gi5ilLBrkS
 xoX0QRQAYLx7QbMYQ8HCaKaMkfnNMig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-D5vahKqcM-u3TUMOAR0Wfg-1; Wed, 11 Aug 2021 04:16:38 -0400
X-MC-Unique: D5vahKqcM-u3TUMOAR0Wfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46449DF8A5;
 Wed, 11 Aug 2021 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-243.pek2.redhat.com
 [10.72.13.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09A295C23A;
 Wed, 11 Aug 2021 08:16:29 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
Date: Wed, 11 Aug 2021 16:16:23 +0800
Message-Id: <20210811081623.9832-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: willemb@google.com, netdev@vger.kernel.org, ivan@prestigetransportation.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, davem@davemloft.net
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

Commit a02e8964eaf92 ("virtio-net: ethtool configurable LRO") tries to
advertise LRO on behalf of the guest offloading features and allow the
administrator to enable and disable those features via ethtool.

This may lead several issues:

- For the device that doesn't support control guest offloads, the
  "LRO" can't be disabled so we will get a warn in the
  dev_disable_lro()
- For the device that have the control guest offloads, the guest
  offloads were disabled in the case of bridge etc which may slow down
  the traffic.

Try to fix this by using NETIF_F_GRO_HW instead so we're not
guaranteed to be re-segmented as original. Or we may want a new netdev
feature like RX_GSO since the guest offloads for virtio-net is
actually to receive GSO packet.

Or we can try not advertise LRO is control guest offloads is not
enabled. This solves the warning but will still slow down the traffic.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0416a7e00914..10c382b08bce 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -63,7 +63,7 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_CSUM
 };
 
-#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
+#define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
 				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
 				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
 				(1ULL << VIRTIO_NET_F_GUEST_UFO))
@@ -2481,7 +2481,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
-		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing LRO/CSUM, disable LRO/CSUM first");
+		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
 		return -EOPNOTSUPP;
 	}
 
@@ -2612,15 +2612,15 @@ static int virtnet_set_features(struct net_device *dev,
 	u64 offloads;
 	int err;
 
-	if ((dev->features ^ features) & NETIF_F_LRO) {
+	if ((dev->features ^ features) & NETIF_F_GRO_HW) {
 		if (vi->xdp_enabled)
 			return -EBUSY;
 
-		if (features & NETIF_F_LRO)
+		if (features & NETIF_F_GRO_HW)
 			offloads = vi->guest_offloads_capable;
 		else
 			offloads = vi->guest_offloads_capable &
-				   ~GUEST_OFFLOAD_LRO_MASK;
+				   ~GUEST_OFFLOAD_GRO_HW_MASK;
 
 		err = virtnet_set_guest_offloads(vi, offloads);
 		if (err)
@@ -3100,9 +3100,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->features |= NETIF_F_RXCSUM;
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
-		dev->features |= NETIF_F_LRO;
+		dev->features |= NETIF_F_GRO_HW;
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
-		dev->hw_features |= NETIF_F_LRO;
+		dev->hw_features |= NETIF_F_GRO_HW;
 
 	dev->vlan_features = dev->features;
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
