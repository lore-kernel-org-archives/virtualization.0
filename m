Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79530C0FB
	for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658994; cv=none; b=hs8kXS3k0v3y3LEcP8s5sXJotuykDRqYdADCHv5mDvoD/emWJcotf7iALb2gan0xt+8fsjIl2HH9XX6gUAmw0rURRfNaSWFCHBIN93GNIWGYbjb3tgx7hNwU5QoE+hmEK1M5+ZUQk5hJZY2W7DJLIJqrbBaPRj6FebeaNHHllpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658994; c=relaxed/simple;
	bh=fayPTzFBxSb+RS3zbGgMpAHzPXJEgutTWFBX+U7n/ns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTbcVMk0qy+obcBXagPQSnv3PgupTGWYT0w+yvyLbLzyILy9XvH89/nLZGkJiYNkQ431snNkgrKh5ZoAEynAJvA1tyFMXapPj/8w9HUqzrYfYBfb7luiJk2XBHpTkc1vcpswH2wtt2Qe77R4gXISIA/Ci2DD+S11LFX64ZC3Gh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HqBI+qRu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HqBI+qRu"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NJGEMM013712;
	Tue, 23 Sep 2025 13:23:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	qNE4jnQ7UkLjhYlhntoXirWjqBMFClPSm4VC32LAUQ=; b=HqBI+qRuJOBlGoPOe
	wXfhaYG8xyEHl8isb1TXOp6vmhzOT34c64GwnVBmoURIpeOD0v8MjK+XZN8Dlm/A
	+gi+P9JwfqScLtS2gNiyEU8sR28xUo5zl0Y++rVnHyj328j07SLC/rX6FvYC90N/
	4ErlZL3qrf2N0HIVAD3WfPyC6nrhkPW7z3uIZz1pBncbOY5yeaVa5DcLIx7MmsQR
	su3gbtH/qMKkSKrydK/hKelxr5In+7JV08xcGBWWqjNFcMyc7jzV0Y45lMSEn4bd
	3FwLuWBBtFqZ5+4nphR2X/p1r8lLhMH5sVLJxowvJQXYGZ4mvTZBYH5BKelmIzO1
	7lO8g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49c1jag3yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 13:23:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Sep 2025 13:23:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Sep 2025 13:23:14 -0700
Received: from 5810.caveonetworks.com (unknown [10.29.45.105])
	by maili.marvell.com (Postfix) with ESMTP id AC6233F7064;
	Tue, 23 Sep 2025 13:23:03 -0700 (PDT)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>, <jerinj@marvell.com>,
        <ndabilpuram@marvell.com>, <sburla@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v1 net-next  1/3] net: implement virtio helper to handle outer nw offset
Date: Wed, 24 Sep 2025 01:52:56 +0530
Message-ID: <20250923202258.2738717-2-kshankar@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923202258.2738717-1-kshankar@marvell.com>
References: <20250923202258.2738717-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDE3NiBTYWx0ZWRfX3z2gV+W3Yk89 2Xf0VAgvWTGa0Q4yzk4GXfJlL4DllpUfgQu60p/KgtRuWbdoluY6kiai/nfYXT/IX87QrLPWj88 3gOrfYDelOZf9C7Zjv+o3HH77/QF4BB6OZqmDFg2mRfSekkUnoehQXg6BFcnNEbex08BhKdG0rc
 ZDBqp3/3i2fgVMtOtD7+7PmEOdAixdcTrTI/QnEwMOzpLsM79e7Cp1/KPvzTPqwhtNd+/e3Shu+ ro0yNfjMm4kCOz41uBoMG1RBZCPfep2erP5LTVsZIozUMm0d5oW0i55hb4k2Vb8mI9DcAoNEIE0 03H1JI6cXmV8O0+1pbUw/yqG5hiKZwh6iIppPZON1faHXs4Ny6ppNla6/ztRPea47/eSG4iG16J +Qib6/o9
X-Proofpoint-ORIG-GUID: xvHOBfMYiY5tRA-OwGRDlATY8q1H4VQO
X-Authority-Analysis: v=2.4 cv=C/rpyRP+ c=1 sm=1 tr=0 ts=68d301ab cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=rBhPDSTWFrAT6I7GfMQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: xvHOBfMYiY5tRA-OwGRDlATY8q1H4VQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_05,2025-09-22_05,2025-03-28_01

virtio specification introduced support for outer network
header offset broadcast.

This patch implements the needed defines and virtio header
parsing capabilities.

Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
---
 include/linux/virtio_net.h      | 40 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net.h |  8 +++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 20e0584db1dd..e6153e9106d3 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -374,6 +374,46 @@ static inline int virtio_net_handle_csum_offload(struct sk_buff *skb,
 	return 0;
 }
 
+static inline int
+virtio_net_out_net_header_to_skb(struct sk_buff *skb,
+				 struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr *vhdr,
+				 bool out_net_hdr_negotiated,
+				 bool little_endian)
+{
+	unsigned int out_net_hdr_off;
+
+	if (!out_net_hdr_negotiated)
+		return 0;
+
+	if (vhdr->outer_nh_offset) {
+		out_net_hdr_off = __virtio16_to_cpu(little_endian, vhdr->outer_nh_offset);
+		skb_set_network_header(skb, out_net_hdr_off);
+	}
+
+	return 0;
+}
+
+static inline int
+virtio_net_out_net_header_from_skb(const struct sk_buff *skb,
+				   struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr *vhdr,
+				   bool out_net_hdr_negotiated,
+				   bool little_endian)
+{
+	unsigned int out_net_hdr_off;
+
+	if (!out_net_hdr_negotiated) {
+		vhdr->outer_nh_offset = 0;
+		return 0;
+	}
+
+	out_net_hdr_off = skb_network_offset(skb);
+	if (out_net_hdr_off && skb->protocol == htons(ETH_P_IP))
+		vhdr->outer_nh_offset = __cpu_to_virtio16(little_endian,
+							  out_net_hdr_off);
+
+	return 0;
+}
+
 /*
  * vlan_hlen always refers to the outermost MAC header. That also
  * means it refers to the only MAC header, if the packet does not carry
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 8bf27ab8bcb4..6032b9e443bb 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -86,6 +86,7 @@
 						  * packets with partial csum
 						  * for the outer header
 						  */
+#define VIRTIO_NET_F_OUT_NET_HEADER 69	/* Outer network header offset */
 
 /* Offloads bits corresponding to VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO{,_CSUM}
  * features
@@ -214,6 +215,13 @@ struct virtio_net_hdr_v1_hash_tunnel {
 	__le16 inner_nh_offset;
 };
 
+/* outer network header */
+struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr {
+	struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
+	__le16 outer_nh_offset;
+	__u8 padding_reserved_2[6];
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
-- 
2.48.1

