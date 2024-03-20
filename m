Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59BF3C478
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930031; cv=none; b=sIBIvR+mBzWuYwDMkvBH6ePx+xj4Uf+/n+rhFCVIlXE6L2yfVDwMbiGQlRs114BDXV01VN6SUXrY9nuRet/yClIBCu8XK7bcRmEZJhNs5yIzKS4vuPYc6L2oUnNRY3X5uIqEQjV/SVQAIOXQVHM66RWeFWwFS95LQBL2fhY8M38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930031; c=relaxed/simple;
	bh=53xBEHWSnLxXwQBryUKnnPb7iNmr3Gh+RO9howPWLMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FozYcE1mLj+R+dMgzphVlIDmYY66X56u/3k0oTGNg+dNAlYdPvLnYS8uSaMT3lN+A/jG+nojRLDT845r4FkLFicovM1IUINo+RvVMgt/NZIO93DYX0+fIr41kGobaV3obiDOvUIlSMpVdh6oW/F3RJ3qXRKL1L/Lfm6vNyKBybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tYjQ0qes; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tYjQ0qes"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710930026; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZK/1fPU2P6JGQovu6CqIpUNTRU4scN5CeSIZeQKlgUQ=;
	b=tYjQ0qesX7NlqdWIBs01ymq/k52Ya2qrT0JHADUuTN4w4NvtnrqWSIOVMkPA8xy6KfLkKgBPZw/Sc2i7clTB2J5DuXfaZfbYXBv9PlHNqs6zsYtU2NYBKyJd5xfN/P7Cv4MoNIFhFmBPJbnWyk/M9vHB0VsJ97SYaY2aDXCpqmw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2x65HT_1710930025;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2x65HT_1710930025)
          by smtp.aliyun-inc.com;
          Wed, 20 Mar 2024 18:20:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Spike Du <spiked@nvidia.com>
Subject: [PATCH vhost] virtio_net: update the hdr_len calculation for xmit
Date: Wed, 20 Mar 2024 18:20:25 +0800
Message-Id: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: e263084e43a9
Content-Transfer-Encoding: 8bit

The virtio spec says:
    If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
    been negotiated:
        If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
        and gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the driver
        MUST set hdr_len to a value equal to the length of the headers,
        including the transport header.

        If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated,
        or gso_type is VIRTIO_NET_HDR_GSO_NONE, the driver SHOULD set
        hdr_len to a value not less than the length of the headers,
        including the transport header.

So if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, the
hdr->hdr_len should be eth header + ip header + tcp/udp header.

But now:
    hdr->hdr_len = __cpu_to_virtio15(little_endian, skb_headlen(skb));

The skb_headlen() returns the linear space of the skb, not the header
size that only match the case the VIRTIO_NET_F_GUEST_HDRLEN feature has
not been negotiated, or gso_type is VIRTIO_NET_HDR_GSO_NONE.

We do not check the feature of the device. This function is a common
function used by many places. So we do more stricter work whatever
the features is negotiated.

For the case skb_is_gso(skb) is false, if none of the
VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have been negotiated,
the spec not define the action of setting hdr_len. Here I set it to
skb_headlen(). If one of the above features have been negotiated, we
should set a value not less than the length of "eth header + ip header +
tcp/udp header". So the skb_headlen() also is a valid value.

For the case skb_is_gso(skb) is true, it implies that one of
VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST have been
negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is negotiated, we MUST set
it to the length of "eth header + ip header + tcp/udp header".
If the VIRTIO_NET_F_GUEST_HDRLEN is not negotiated, that still be a
valid value.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Spike Du <spiked@nvidia.com>
---
 include/linux/virtio_net.h | 41 ++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 4dfa9b69ca8d..51d93f9762d7 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -201,24 +201,45 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		u32 hdrlen;
 
-		/* This is a hint as to how much should be linear. */
-		hdr->hdr_len = __cpu_to_virtio16(little_endian,
-						 skb_headlen(skb));
-		hdr->gso_size = __cpu_to_virtio16(little_endian,
-						  sinfo->gso_size);
-		if (sinfo->gso_type & SKB_GSO_TCPV4)
+		if (sinfo->gso_type & SKB_GSO_TCPV4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
-		else if (sinfo->gso_type & SKB_GSO_TCPV6)
+			hdrlen = tcp_hdrlen(skb) + skb_transport_offset(skb);
+
+		} else if (sinfo->gso_type & SKB_GSO_TCPV6) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
-		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			hdrlen = tcp_hdrlen(skb) + skb_transport_offset(skb);
+
+		} else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
-		else
+			hdrlen = sizeof(struct udphdr) + skb_transport_offset(skb);
+
+		} else {
 			return -EINVAL;
+		}
+
+		/* One of VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST
+		 * have been negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is
+		 * negotiated, we MUST set it to the length of "eth header + ip
+		 * header + tcp/udp header".  If the VIRTIO_NET_F_GUEST_HDRLEN
+		 * is not negotiated, that still be a valid value.
+		 */
+		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdrlen);
+		hdr->gso_size = __cpu_to_virtio16(little_endian,
+						  sinfo->gso_size);
+
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
-	} else
+	} else {
+		/* If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO
+		 * options have been negotiated, we should set hdr_len to a
+		 * value not less than the length of "eth header + ip header +
+		 * tcp/udp header".
+		 */
+		hdr->hdr_len = __cpu_to_virtio16(little_endian, skb_headlen(skb));
 		hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
+	}
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		hdr->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
-- 
2.32.0.3.g01195cf9f

