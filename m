Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622823;
	b=AdHlX4YerrVRx9y8j47BaarHoEs08Ra6Fer+kmSF2iWN+uYZxM7E4jcowLVK1sy2yXrV
	 wojAiuGTf5yx2sDoDvPquTSLeTbzBVBjcczQf2SbT27lDBCH5g4biNFPZdCJNcBqPSqEr
	 YHUvy6YlRXf0mWzQ83ch3bsqnxlq6dRoWMIYEbm0WuO/ifw4iUtrAUVYvWMLnbJTbvk1G
	 y/dFU1XlDWR+6wvCbfQ41QaAvfrMUG1gUmnHz+vM0qACmqpkB8S65/AmAIQLL5z/UR5Hz
	 ODWp+UEIjQbyC6QxAutf29zMiVCgZFMIb80ih4QStxYFc8WTQVo339sp+ovacC4lHFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622823;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G6T7jpstO8PkN3s/pf9ze2EnC64looMz52Ecp4aw0pc=;
	b=TZAGAx1nS1qeT2aU9zoFPNUGy3NCtr9Zao5DpHzgAyS/uazp1K49dfxlf8Upz29Dwh5N
	 Kjt2yuWK3x6JnCuGzZtNIr9xIkP3uamqsV2GH8aM803C/qkybNTXSe1flypKgcnZjfzc8
	 TS2j40gFJnxyTv6Db51L7oVkZZqNKQixoe1eUhbbfDy+Gbo6z7jNzAYVsH1ElIL9LpTCY
	 Unr/2Ac2lwak6RtLgzQ7/pnD9Ne/T/vC3tUfk1Wl1GYjPzdlRIpCdedw4zp0SwK8O4jhl
	 OPnZF0BRfNnBu1whgaVvsQmG4COghwLAkEf1UlAvtLOkNC28A3hJff+lgH7Q/vk5m1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6DF606A69A
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 16:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC6DF606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 6E425C935F; Thu, 26 Nov 2026 01:07:01 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chris Arges <carges@cloudflare.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	=?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	virtualization@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH RFC net v8 3/6] virtio_net: parse tunnel csum_start little-endian
Date: Thu, 26 Nov 2026 01:06:44 +0900
Message-ID: <20261126.rfcv8.99797.3.zakinko@snowrabbit.org>
In-Reply-To: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
References: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: "Michael S. Tsirkin" <mst@redhat.com>

All tunnel related virtio features are > 32, so none of this
functionality can be enabled on legacy mixed-endian device.

Accordingly, all tunnel header fields, csum_start included, are
little-endian.

The nested virtio net header import parses csum_start that way, but the
inner transport offset is parsed with the endianness specified by the
interface.

If tun is misconfigured to legacy big-endian mode while the tunnel
features are enabled, the two parses of this field disagree, and the
value stored in skb->inner_transport_header - which is only
bounds-checked from below - can point past the end of the packet, where
GSO segmentation later dereferences it.

To fix, parse the field little-endian in both places.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 include/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index fc9667176..3135dae03 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -490,7 +490,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	inner_l3min = virtio_l3min(inner_isv6);
 	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
 
-	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
+	inner_th = __virtio16_to_cpu(true, hdr->csum_start);
 	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
 	outer_th = le16_to_cpu(vhdr->outer_th_offset);
 	if (outer_th < outer_l3min ||
-- 
2.54.0 (Apple Git-157)

