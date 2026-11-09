Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242113;
	b=jUAgJSrn2GI6RjM9RMopWMBiCEhkL/jaWErN9nhQSHZFzEtLBrHpXf0LwOAzbftN5bvl
	 hxb25cb8fGpbwd3EdkLihma3g11irVSB06oFgB1aIUdyadF49rWlbbVHQ5D0WZ3W+Dw86
	 XDOFKhGu4+RA2tChgjQgWfuL0Gqfro1IQrkmJfRnSthRhCVxCXSUm8UO7PT7GIuieEcBM
	 xZC0kRkJZDt0VUfzCgJhHuxfVgD0Tovh8VD2Osn4psY1VdNSJDmN0txCLs02A54TPXmZn
	 gQY35ihSzFMldMhk4xH/jVrVZFNtPH4GFu6BHq4N03vOoSFYDRoT0C+7uy+12lyNJmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242113;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s3FNQKnxxBeJXM/IAJChMkL3qREK6ogU+++FUlzfMyc=;
	b=hsehqAIEp2LPEs58FRArnHJqTTQrTG5zdbN7qMeyVub2LZZcapSqpg3tM+ursMo5eOXS
	 a6ghuoGhXwAbzf5boJ3OPDNPsqFrOUstRyinGlzbN5hBmnMQkOm6gt4KSKWhZrAkCJaZp
	 lYwQ90VJjVwf3JmFoPr1UR94lyVbtRjQb2NT/fO6v7NmeN0oAcconSbgqsy4RrOG2HqHN
	 B9wfA7a/xV+feLJF3s3fOpqYAPs6R/3eQfvRWxkePmAZHEVh0rQjd6gPxo8jrCdZhzy5U
	 5lO6vo+O/UMyYVg+HlXB3JtSyUFUcjjcsnZPzRHGu5Z9aWEUU91ogS2plf5eW4K+6rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhqeqlqY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A573606A334;
	Mon,  9 Nov 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhqeqlqY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E41F0089F;
	Mon,  9 Nov 2026 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242113;
	bh=s3FNQKnxxBeJXM/IAJChMkL3qREK6ogU+++FUlzfMyc=;
	h=From:To:Cc:Subject:Date;
	b=UhqeqlqYtEh/N+PRp7M23Mr8LmAHttyzK9sYMBc0wHVr5gGosUZnzGUXW0+1mySEu
	 +2aWH2xwgrT/Ss03yBGGxd916r6hujrGu1witGBf3fgB2bUQ2DJldUdJYip2pIgJCN
	 2wy05OLQWjCmieGu7+4gx9kViAsZzMrulxpe5oazkDh73RrkRuiSjaCyOg+JFYmSO8
	 0XvGjhI9FAALFsu4cwTOLwVW/7R7bVdi2BDtcGlrTCzw0trg6J+cHtOmOlbLGpa0ua
	 LbmvQZsgvxAhhqqxkd1Uph3NWI1JENlaRjmVLtsSkTeXUqeH3/qo4V4Lop4sqo5NMq
	 a9ezMVdbI7Ztw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v5 0/3] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Mon,  9 Nov 2026 17:35:04 +0100
Message-ID: <20261109163507.3102091-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_net_hdr_tnl_to_skb() does not check that a UDP tunnel GSO
packet really has outer IPv4/IPv6 and UDP headers matching the
declared tunnel type. A guest, or any tap writer, can send a frame
with another outer ethertype (NSH in the report), and the GSO stack
then builds segments with skb->data before skb->head. The host
crashes in skb_under_panic() as soon as a header is pushed.

Patch 1 fixes the producer side: virtio_net_hdr_tnl_from_skb() did
not account for the VLAN tag tun inserts in the frame, so
outer_th_offset and inner_nh_offset were 4 bytes short. Without it,
patch 2 would drop such frames. Hosts without patch 1 still send
these offsets, so it should go to stable along with patch 2.

Patch 2 validates the outer headers, using the parsing helpers from
Michael's series "net: resolve uncommon partial checksums at ingress",
as Willem suggested. The callers tell whether frames start with an
Ethernet header, as the device type of a tun device can be changed
with TUNSETLINK. The rest of Michael's series (checksum validation and
completion) is left to him.

Patch 3 clears a stale skb->protocol left on recycled NAPI frags skbs,
which could make the checks of patch 2 reject valid frames.

The selftests of v3 will follow in a separate series, with the fixes
Sashiko found in them.

v5:
- New patch 1: account for the VLAN tag in the tunnel offsets built by
  virtio_net_hdr_tnl_from_skb() (Sashiko).
- Patch 2: add Michael's Acked-by, no code change.

v4: https://lore.kernel.org/netdev/20261106095340.2113683-1-edumazet@kernel.org/
- Squash v3 patch 2 into patch 1 (Willem). Dropped Michael's Acked-by,
  as virtio_net_l3_start() now takes a has_eth argument.
- Patch 2: clear skb->protocol in tun_napi_alloc_frags(), the only
  place that needs it (Willem).
- Drop the selftests from this series (Willem).

v3: https://lore.kernel.org/netdev/20261105115715.1466924-1-edumazet@kernel.org/
- Patch 1: fix a comment, ipv6_find_hdr() stops at AH (Sashiko).
- New patch 2: do not use the device type to find the outer L3 header,
  TUNSETLINK can change it (Sashiko).
- New patch 3: clear a stale skb->protocol on IFF_NAPI_FRAGS skbs
  (Sashiko).
- More selftests, and big-endian fixes for them (Sashiko).

v2: https://lore.kernel.org/netdev/20261104050131.629967-1-edumazet@kernel.org/
- Use Michael's helpers instead of a new one: find the L3 header from
  the device type instead of assuming Ethernet when skb->protocol is
  unset, do not trust skb->protocol when it disagrees with the frame,
  and require UDP exactly at outer_th_offset. Stop at IPv6 AH headers
  (Willem).
- Selftest fixes, IFF_TUN tests.

v1: https://lore.kernel.org/netdev/20261103203113.550604-1-edumazet@kernel.org/

Eric Dumazet (3):
  net: virtio: account for the VLAN tag in UDP tunnel GSO offsets
  net: virtio: validate outer protocol of UDP tunnel GSO packets
  tun: clear stale skb->protocol of NAPI frags skbs

 drivers/net/tun.c          |  15 +++-
 drivers/net/tun_vnet.h     |   5 +-
 drivers/net/virtio_net.c   |   2 +-
 include/linux/virtio_net.h | 176 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 191 insertions(+), 7 deletions(-)


base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
-- 
2.53.0

