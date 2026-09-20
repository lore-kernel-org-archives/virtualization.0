Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947E298CAF
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789865270; cv=none; b=tXx3yj/FMAEhHYPKq8wwKZUpewHLms72eGdrgcdIuVVSrDdYdg8OMbWCB1XuzXhkdursVj5sbHKvi4dnkPwxaXzZL+/Iyi7LQriP5kRSnUbLNaIU7+0DAR4at4VeHTjNfkPH+TFwjfmDFIuB1ZTc+jn/KJo+es1QNNI4qIye6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789865270; c=relaxed/simple;
	bh=i0mBiP1JkgHcESHm7CxWXeGEgOSmLAz/z/JCtwsAP8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFy1xw58yVwvcXg149v8GmDNwpnjAwPOcj/FOICD/oPEaOjAxOapfRcvey2bT3hp3kF0fOumM5wjtLalHrnAjdXON0lFLPBlgft5IbQtaImxU+EFKEdp/2SnB8LvS5GxotjFdmv1DcmIn0tgEWIJkXrbDuIkbyIULt7nQtaboxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9lAYyOz; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9lAYyOz"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso17835576d6.0
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 17:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789865268; x=1790470068; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNRwTnv6INwJTRG/2/luNN9rurp+iuSaljjyDm0JWe8=;
        b=H9lAYyOz7vm4Wvl/f+awB3J5/tWzL0pwXYpRYOMf2akXZKdqstCF0zHwzLi+rtG/oY
         FJSPKzI/M3WCTA8aV4athvk9K51YROwD+f1zgb9cV3C0ml1I7g30uuestxD5KiTlp9Bd
         4xGOuN+5qPE2P7z6X4My61jSHDA9P5at5f3AtAGN6rO9UqEOA2T3HLKUvnv9Qr/fJMLw
         dt9BHROkzpQCLUhJRwRAROdJvO5g20IOzrqsCSszjm4xfYBwSz1c+mxz9i4MfOkrqvrw
         Qx3xUgHW0+Z4OsCvUagT6ihCuOilgE3OBtIRJksbjqpSSfn2hg+uofv/iFvJ4NUgCGOg
         R3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789865268; x=1790470068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xNRwTnv6INwJTRG/2/luNN9rurp+iuSaljjyDm0JWe8=;
        b=rjjJQuSkTdzfLv1dejTHdS3Ex2E3/44nUV3gAUoes2b7PyTiiQrvBojym1QRI3eEIi
         0x0zB+mCHIsTdxXjFF+NJUdFMFmgqbP7bUHg4JJGgoWfoGyLl7Qm/ShB/t60CwGF3ydK
         fJQzzA7mAgqQ++dIS+s9EPnPCUDnytYFjjO8ChJSRqZZkQRk0oYA4T54w/D7RSlkCwX2
         /kbTNwdLRygCtx4Cx9lPc+tkHM2CVhAy66+0OkTB5ZQj1al9MboEzHbq44YRr8r+H8Mn
         +fEowkwy+TyQQbWKz/9UEZWNWN17xoa52ynnWmyhjoblPyjdbZtvxXgkyiOVhKf1grlo
         FgWQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/IxT7VwSnE2Qsojf40JFqKZMp48OTIxkNVVFsiKq8/wQJKsuP8KJTOtS3nDTKsUK5Yb9LXnveMCMPv8lLlA==@lists.linux.dev
X-Gm-Message-State: AFuF++l4Q0PrIgeaSM/hYHqHngHR0ORpAFbAJ6UpmR7A0EJoNdbUCj+R
	ejVVcW88xw6K0nJgLJuia1yXgoRxgP/Va8ZBs+NUUawmlqJlhNMPhPoK6m09442Zxm0=
X-Gm-Gg: AYBFou2/hgHwFRdPDOtwS4RLkL99o6EMJC6tGw2OiktRCut3qCt5Jx6mWo3KpZnhv9N
	lG+sRJw3DnGKOXy+CC6hk8BskOkmYsM0e6aPFSdH1RBVCG/gkcTXSJ8BQ5dNzdEQXc+t1LjLWIQ
	wgqE7OBQt8vDweD/KFaXFfHF51RIzwy2S7tUsgGinfXjM65ewxQpQQIe31EM9bvGN+xyvP2zFqH
	Ah2I0iMquq3uy5YMfMKu0o3Q9yRn12d8l+amO+bX/gt3yYaKq7tJGrLMWkO+VRjihxd3e9wcRbF
	un7+7QpIbvoPb9CsMAw9JeAqfjcoEGKnrQW6UD/XUQWikK86fqGB035ub3EkVX2Zcv3kDdXGIfE
	Qg1NwbIQvfQRo5tQadBvOvvukiZl+7kMIGPrMynJB4ZqZENAxKakJ0+kWdH5T0/iV3rEgVKtvuY
	rlpS0CrZSJ+sFAk7LwPEb7T15ipuwhVyFzkLQRfymL1RFE1c8W1XAl5irVJ4nrf3Nxj9e8LX1TV
	hFIEAUXzsoQtPAr39Fy5/uiTDlA1sp6N34ax0XrVcpxL6BFlJ48zw8jTobAmj17v68pRa4+
X-Received: by 2002:a05:6214:e81:b0:912:517b:90d with SMTP id 6a1803df08f44-912a9b49deamr40829346d6.44.1789865268273;
        Sat, 19 Sep 2026 17:47:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:c8b1:39dc:7ddc:dd0c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9126078cab2sm32122436d6.0.2026.09.19.17.47.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 17:47:47 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	hannes@stressinduktion.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/2] net: validate virtio checksum start after network header
Date: Sat, 19 Sep 2026 20:47:32 -0400
Message-ID: <20260920004733.6473-2-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260920004733.6473-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__virtio_net_hdr_to_skb() rejects a CHECKSUM_PARTIAL start smaller than an
estimated minimum network-header length. The comparison currently uses the
offset from skb->data rather than the offset from skb_network_header().

For an AF_PACKET frame, skb->data can still point at the Ethernet header
while skb_network_header() points past nested link-layer headers. A
checksum start at the network header can therefore pass, then target byte
zero after those headers are removed.

This does not require a virtual-machine guest. A TUN device with
virtio-net header support can supply the same checksum metadata.

Keep the existing data-relative lower bound and also require checksum
start to follow the estimated minimum relative to skb_network_header().

Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes in v4:
- State explicitly that a TUN device is sufficient and no guest is required,
  as noted by Michael S. Tsirkin. No code changes.

Changes in v3:
- Keep the network-relative comparison on one line for readability, as
  requested by David Ahern.

Changes in v2:
- Make nh_min_len an int and remove the casts, as suggested by Michael S.
  Tsirkin.

 include/linux/virtio_net.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index c381b91..a95ad46 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -52,7 +52,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 					  const struct virtio_net_hdr *hdr,
 					  bool little_endian, u8 hdr_gso_type)
 {
-	unsigned int nh_min_len = sizeof(struct iphdr);
+	int nh_min_len = sizeof(struct iphdr);
 	unsigned int gso_type = 0;
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
@@ -104,7 +104,8 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
-		if (skb_transport_offset(skb) < nh_min_len)
+		if (skb_transport_offset(skb) < nh_min_len ||
+		    skb_transport_offset(skb) - skb_network_offset(skb) < nh_min_len)
 			return -EINVAL;
 
 		nh_min_len = skb_transport_offset(skb);
