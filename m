Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557219D082
	for <virtualization@lists.linux.dev>; Wed,  8 Oct 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923375; cv=none; b=DDbFdXOclq4j/i72sxxDGowa0Mi97XQ/188gExQgc8BSkjtu1013r1zmMhk7JsV6lmAH6K88fkvlYUu7ep5V5Z6NYMc2QitPuAph0fm8EluR7LnI22p1hdupq11Ttxung5ELnBfD/SMfnrk5T6l7cIWHlg/OrKwz0x4PwLUCm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923375; c=relaxed/simple;
	bh=IceakvOaggMPUYsKLAdHdeVuyQMjc5l28+Stg3yh6XI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0p/g/DQTNgFoqtfhhHT2Z29MPYJbi7uGjmeLsFMCd45VDHkvZ4CWsngAzdu6ZXPc7S1m/XwXZ+99swJRDNsv46g250Uq3dwc7pI9SOZU1FFdsAmbEoJYZt+vmo07J+87qQq6lJfAMwTs+48L/iPUi/PXxG5Mu5AvxQlBFPRGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YV2HEwIx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YV2HEwIx"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5985vuet031860;
	Wed, 8 Oct 2025 04:00:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
	8+MIe6TP86YLoOoNB1Vg1heguvOxIanTKUSmx1Po/w=; b=YV2HEwIxb+N7LtYmY
	cljyC3cpS6EamwaLzY4mYU0CY+osVJt2lzJuoyI9FmbZRy6N8Je799L8UGRhBwPS
	oc+S/3sWuFvSl/m07AVI/0dbNgnhOqOIA7BCPiJ3k8ULpQV/jPRur76PIvQxAm8a
	jfnJxEFCjms+l8Pzh2uFj6TBozv/V6faYAeRpopEFoghMEA/caUkMr52RgIQG9Z+
	xmgj3BgJ4qdXUXDo8yeXAS+nXl8J7ITSDtWFUinoC+xZRCf/9sF8x16S6xfmeF4H
	/+2z2R88GCqUS+AH5TQpYIDrmKAHUHcd/YyZSfdV0a2nw9Zk65KzAroXJsG2Kirz
	zPL+g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49nj8t0fwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 04:00:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Oct 2025 04:00:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Oct 2025 04:00:17 -0700
Received: from 5810.caveonetworks.com (unknown [10.29.45.105])
	by maili.marvell.com (Postfix) with ESMTP id 329125B693F;
	Wed,  8 Oct 2025 04:00:13 -0700 (PDT)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>, <jerinj@marvell.com>,
        <ndabilpuram@marvell.com>, <sburla@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v2 net-next  2/3] virtio_net: enable outer nw header offset support
Date: Wed, 8 Oct 2025 16:30:03 +0530
Message-ID: <20251008110004.2933101-3-kshankar@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008110004.2933101-1-kshankar@marvell.com>
References: <20251008110004.2933101-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDAzNyBTYWx0ZWRfX0SctKSmaRgzS
 gmzMQ/AoVIOwVc4MWdIIo+x/OXxkaA5PkyHgjX5tZwteHdDONEMFC9fadaPn3Mc1LGCT/6qKP2s
 R6J0s+DlnsAUwvvNBQItGx5IbQBhloarYUgpMA0fHjZGlpQr+MCziBMA/L308IhjKX8PUCsLSDn
 XV6GjrJCcXwPihwMJMMSLtE/borRldzhrfsM8G4MO1Q8NLl8yKEmqr6QCBgA4FMOCWl0ELsnOIH
 MrZ50v8rr5ljELahz+giD4l0Y+JoO53ZdnTAhpl+BZcprEeOkQ4csJqbEhGodxwTdFTQD6/Lics
 nhWhPw1O/FyHFawxvhTppELe5vXhZTqK11rL5k0La5baGTIUCcoqofE1KOOeeC6cKS3j1iATtSR
 RDdMJMfIjT9ebhgrtjahVjnPkhwagg==
X-Proofpoint-ORIG-GUID: 20P-PkoamAkIB2rX1GfKoXMq0WtzG-Oq
X-Proofpoint-GUID: 20P-PkoamAkIB2rX1GfKoXMq0WtzG-Oq
X-Authority-Analysis: v=2.4 cv=fuHRpV4f c=1 sm=1 tr=0 ts=68e64443 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=jGR1pZPCcwd-RLdNFkEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01

If outer network header feature is set, update header offset
in ingress and egress path.

If feature is not set, reset header offset to zero.

Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
---
 drivers/net/virtio_net.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7da5a37917e9..0b60cbbb3d33 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -451,6 +451,9 @@ struct virtnet_info {
 
 	bool rx_tnl_csum;
 
+	/* Outer network header support */
+	bool out_net_hdr_negotiated;
+
 	/* Is delayed refill enabled? */
 	bool refill_enabled;
 
@@ -511,6 +514,7 @@ struct virtio_net_common_hdr {
 		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
 		struct virtio_net_hdr_v1_hash hash_v1_hdr;
 		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
+		struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr out_net_hdr;
 	};
 };
 
@@ -2576,8 +2580,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	hdr->hdr.flags = flags;
 	if (virtio_net_handle_csum_offload(skb, &hdr->hdr, vi->rx_tnl_csum)) {
 		net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: %x rx_tnl_csum %d\n",
-				     dev->name, hdr->hdr.flags,
-				     hdr->hdr.gso_type, vi->rx_tnl_csum);
+				dev->name, hdr->hdr.flags,
+				hdr->hdr.gso_type, vi->rx_tnl_csum);
 		goto frame_err;
 	}
 
@@ -2591,6 +2595,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 		goto frame_err;
 	}
 
+	virtio_net_out_net_header_to_skb(skb, &hdr->out_net_hdr, vi->out_net_hdr_negotiated,
+					 virtio_is_little_endian(vi->vdev));
 	skb_record_rx_queue(skb, vq2rxq(rq->vq));
 	skb->protocol = eth_type_trans(skb, dev);
 	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
@@ -3317,6 +3323,9 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	else
 		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
 
+	virtio_net_out_net_header_from_skb(skb, &skb_vnet_common_hdr(skb)->out_net_hdr,
+					   vi->out_net_hdr_negotiated,
+					   virtio_is_little_endian(vi->vdev));
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
 					virtio_is_little_endian(vi->vdev), 0))
 		return -EPROTO;
@@ -6915,8 +6924,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_OUT_NET_HEADER))
+		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr);
+	else if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
+		 virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
 	else if (vi->has_rss_hash_report)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
@@ -6933,6 +6944,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
 		vi->tx_tnl = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_OUT_NET_HEADER))
+		vi->out_net_hdr_negotiated = true;
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -7247,6 +7261,7 @@ static unsigned int features[] = {
 	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
 	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
 	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
+	VIRTIO_NET_F_OUT_NET_HEADER,
 };
 
 static unsigned int features_legacy[] = {
-- 
2.48.1

