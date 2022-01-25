Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102ADC4332F
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 08:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A753C41788;
	Tue, 25 Jan 2022 08:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5VzlCxARwYAq; Tue, 25 Jan 2022 08:47:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3552941784;
	Tue, 25 Jan 2022 08:47:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4050AC0081;
	Tue, 25 Jan 2022 08:47:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D56AFC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1FE560BDC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NpNXPzzKw1TT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D47760B4F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id u6so23608821lfm.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 00:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KADXDwPSZzBNJZyGOf6/RaxmVEZ0dcQMEj4ph2LZrIA=;
 b=E5N6rnfpLVuomzpKv7B2iO6tqIya1+zMB7j6sPn5f/I6ggTAaJqoDqBHwysCe4g6D6
 FFcao7hF04BWqCwu9s+U+g3GORW4cq8dmt4RqSXNaDPnA329ZI81GDO8lKVEe11XmxoQ
 qdqv+GI8VdBE3edikJPt8xXPZZ59+BR55A+ZXBmrAZ/XtcgN0qouXrcIbmYQCfYJ1juM
 58JkfDeW2VsEdCxdU5Z8THlgm7GFAZOYY3Sv9b4Htj2gMJgKUTQkszP8lSJ24EnW4P4X
 GRkuYMYKrVRlJjnYxt6ud7UUwMM80YzgH3LH9zlOS/Gbh1c2aXETX6oG4qZtSPzLk19N
 KCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KADXDwPSZzBNJZyGOf6/RaxmVEZ0dcQMEj4ph2LZrIA=;
 b=2mTLM3uigZ9C9UFOpsHpskg89py0ZsYD7W6vfVU1E2WLfFn6Zx5SUciNC/mIvpluTu
 Xnwh7DVP3eD3UAX8z6Y6V3SsrQUWeThtInDO/kyx2O3PAzIem5lc/fQYHONMxTlJQ9Mx
 y3t2cgucEJ/+G/f/3nl86GzNR0RYC7j/tjOQg8V1MZnYoRUJbDqpeQEX3kOZK8xorXlQ
 eb6lcN11eipz1SeTP+j0mnbon8fGkQioiqYI5awjUAlQ6AdPsE52v2VFnH23qEMqOjIT
 GqZsFyYHNW5xmSJGReki1uBJ7E3d33TQE1fws9S6XGaDTPlyCufwblc/VLhcgnBUpVIv
 9kZQ==
X-Gm-Message-State: AOAM533I/rhpP245RLCyXJmm9xCrx1p7uyCdD1cYHIDVVUTwP5F8seuH
 pERlTdf/TZtLBHLKOMIK2memOw==
X-Google-Smtp-Source: ABdhPJxBOpDCi+HD+W7m+aCE1uJ74rL4NmI8ow4BsEsaN6ZHzn0gSv57q1zh/Uyab4PWRk17uBBwWA==
X-Received: by 2002:a05:6512:3d0a:: with SMTP id
 d10mr2796243lfv.472.1643100445460; 
 Tue, 25 Jan 2022 00:47:25 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id q5sm1418944lfe.279.2022.01.25.00.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 00:47:25 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 5/5] drivers/net/virtio_net.c: Added USO support.
Date: Tue, 25 Jan 2022 10:47:02 +0200
Message-Id: <20220125084702.3636253-6-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125084702.3636253-1-andrew@daynix.com>
References: <20220125084702.3636253-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

Now, it possible to enable GSO_UDP_L4("tx-udp-segmentation") for VirtioNet.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a801ea40908f..a45eee022be4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -60,13 +60,17 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
 	VIRTIO_NET_F_GUEST_UFO,
-	VIRTIO_NET_F_GUEST_CSUM
+	VIRTIO_NET_F_GUEST_CSUM,
+	VIRTIO_NET_F_GUEST_USO4,
+	VIRTIO_NET_F_GUEST_USO6
 };
 
 #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
 				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
 				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
-				(1ULL << VIRTIO_NET_F_GUEST_UFO))
+				(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
+				(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
+				(1ULL << VIRTIO_NET_F_GUEST_USO6))
 
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
@@ -2530,7 +2534,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
-		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
 		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
 		return -EOPNOTSUPP;
 	}
@@ -3155,6 +3161,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->hw_features |= NETIF_F_TSO6;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
 			dev->hw_features |= NETIF_F_TSO_ECN;
+		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
+			dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 		dev->features |= NETIF_F_GSO_ROBUST;
 
@@ -3169,6 +3177,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->features |= NETIF_F_GRO_HW;
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
 		dev->hw_features |= NETIF_F_GRO_HW;
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO4) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO6))
+		dev->hw_features |= NETIF_F_LRO;
 
 	dev->vlan_features = dev->features;
 
@@ -3200,7 +3211,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO4) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO6))
 		vi->big_packets = true;
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
@@ -3400,6 +3413,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
 	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
 	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
+	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
 	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
