Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F93126C9
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531735; cv=none; b=dT9WS8Zz6NmXc908LAy4kMZotABvwrSGIgdZZp52Iq5Rzmb2o4aaDBvM9Ge2Ax4eLQsYV36SB+VHVhpa2PAqqDXtnXRtLwQNEVYxbG6onW1w0Wehcn2Lvu3ThcmSBG76E1gohK/DRYS8Hh/0SkPkrCBJjFtMTC4i/3Wr1ZduWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531735; c=relaxed/simple;
	bh=Vku+/uJzpCS6RD0PeArHpLQxFG9r5c2RoZlwMndC+jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U0WpKe4LoMjSmJTAj4pu3U9Y6Ue/GTcdK0hu2DtrG1r4Cp697hAtl+aXLz3J3aM6zTGtesrT9e/sJhhJ+uVYNT9Qy8zxfwdfip4YejLwKM2Hn0Z6N5K3M4UBkwHW3F1xMky769pmhidfD9wLFgRQMcY1umLfq340xAqlT467bxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O1PWwDPK; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O1PWwDPK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763531724; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EbE16rzqpQqa5q2H5pQnPYyWzuPV3tShqwz35R8n93M=;
	b=O1PWwDPKIYSIvKALw7uOE6l0lwDvC7oLtTvHRcptG8E+cbVbAsjqd+/2S5vuFVptMnmNxN20JXP4NRcKCkGT1Y3lweBmnc3C55whwSuiCHQHfl7DqJW2umQ8W0Ep/6R7E6rlBqZTNYGF4yLVpcxYE/bNmnYfV45b+AbGXtAM9xQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsnQKEy_1763531722 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 13:55:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v6 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Wed, 19 Nov 2025 13:55:20 +0800
Message-Id: <20251119055522.617-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 2ab728bd57df
Content-Transfer-Encoding: 8bit


v6:
  1. rename to guest_hdrlen
  2. introduce a function virtio_net_set_hdrlen to set the hdrlen

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This path set fixes that issue.

As discussed in [0], this version checks the VIRTIO_NET_F_GUEST_HDRLEN is
negotiated.


[0]: http://lore.kernel.org/all/20251029030913.20423-1-xuanzhuo@linux.alibaba.com


Xuan Zhuo (2):
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/tun_vnet.h     |  2 +-
 drivers/net/virtio_net.c   |  8 +++--
 include/linux/virtio_net.h | 71 ++++++++++++++++++++++++++++++--------
 3 files changed, 64 insertions(+), 17 deletions(-)

--
2.32.0.3.g01195cf9f

