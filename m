Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346594;
	b=Eihz4/sw6CRx/NigVuHCuzwT56pnc2o7MQjSi8n8uSvzh/Btjmax9NVmsmSk92o3LpnC
	 qZFlYaf71z5l+x0pFttzhDSDlfiP+Jf8i042ZyLWVRUbugDGP0dbAPcK7VVtWKZoo9nhS
	 nVbaqMU4FdEkF58rZo3wkLHzG8hPLXvwb+602iMjXJ/JrERJ1S6ieIBVxUlQb+d4eMGjY
	 ghLPiv5jZqKrqJ2prAJZNpsbnCufZkp/vviicIBpDvO2vpSXjnAbhj+xmvF3TG8Hefxin
	 lqyG6R5nKJlCjQyUAhY/tTMfBJ+8enzDhugZMVnLnkGIIdfeZ6qtN0LMlmfS/2iDGVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346594;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8n0le04FNg/0rCa83fIxN5EOqJ6nyAusJtI49zdt4g8=;
	b=gcIrrsE5YRZLhYtES7mESwMR584hPTkVkxfrV2gdkm3DTswW2RoTcaMMitio9NOfYT13
	 LrPKjAxfISVvIT3+6TvnfmczZiU/14NbuGwPd2reCBqsXyetvJpX8cjsreFRY2qFOJwc5
	 ovNzrXy+k4p9RLt2RNmuz7/2aUCR6DAL9KoKk5ReDEGbp7jNuy5uPB7p54Y2tiuau+SGJ
	 e5XV5nS0DEqOra3RB1+YaXANDEXhROLDgQjXfWQwj6JK25rX+TPp1B2uXKy4W7X2kNqpQ
	 J9K/KlsXSxsIj/SFtlHooF275cr7dLu/MddxUPyryn2TSgr12DMnACDpGTPM7e58ojw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QF7n+VSI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07B606A31C;
	Tue, 10 Nov 2026 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QF7n+VSI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB371F0089F;
	Tue, 10 Nov 2026 21:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346593;
	bh=8n0le04FNg/0rCa83fIxN5EOqJ6nyAusJtI49zdt4g8=;
	h=From:To:Cc:Subject:Date;
	b=QF7n+VSIlcNx++it9DojKYSHFZSvlbPfny89ikkS0toDmJdJpI9KWh71wwzN7RFcN
	 LTC4fPbylf62bDQSxLDzJiDZ0pr49hNFKybYXXypetI9EuMLCsC2IHnZ/NsvxHwEq0
	 1XsGAsEbgI/ROxmtyOALdZZAtMspIlHJSBhiqZgcLmi8VUpUA9wHA7oyg6TEkQn6hG
	 fpT/wuza7a5deViRxeVNR2x1gerJpyjuHJfHKhQxw1fIsqEd3gx3P0YTU5Ck7YRopE
	 UWycLgYQZk55YZ/Ed1cJbSXpAXIsWyL6266lpX7nl8vv31CHlTHX5dd0kgHdXMlwZ3
	 WtsO5D5aGsTVA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	edumazet@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v6 0/3] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Tue, 10 Nov 2026 22:36:25 +0100
Message-ID: <20261110213628.3476051-1-edumazet@kernel.org>
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

Patch 1 fixes the producer side, virtio_net_hdr_tnl_from_skb(), for
VLAN tagged packets:
- the tunnel offsets did not account for the VLAN tag tun inserts in
  the frame, and were 4 bytes short.
- the outer family came from skb->protocol, which is the VLAN protocol
  when the tag is in the packet data, so an outer IPv6 header was
  reported as IPv4.
Without it, patch 3 would drop such packets. Kernels without this fix
still send such headers, so it should go to stable along with patch 3.

Patch 2 clears a stale skb->protocol left on recycled NAPI frags skbs,
which could make the checks of patch 3 reject valid frames.

Patch 3 validates the outer headers, using the parsing helpers from
Michael's series "net: resolve uncommon partial checksums at ingress",
as Willem suggested. The callers tell whether frames start with an
Ethernet header, as the device type of a tun device can be changed
with TUNSETLINK. The rest of Michael's series (checksum validation and
completion) is left to him.

The selftests of v3 will follow in a separate series, with the fixes
Sashiko found in them.

v6:
- Patch 1: also take the outer family from vlan_get_protocol()
  instead of skb->protocol (Sashiko). New title.
- Move the tun skb->protocol fix (now patch 2) before the outer
  protocol check (now patch 3), so that no commit rejects valid frames
  (Sashiko). Reword its changelog accordingly.
- No change to patch 3.

v5: https://lore.kernel.org/netdev/20261109163507.3102091-1-edumazet@kernel.org/
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
  net: virtio: fix UDP tunnel GSO header of VLAN tagged packets
  tun: clear stale skb->protocol of NAPI frags skbs
  net: virtio: validate outer protocol of UDP tunnel GSO packets

 drivers/net/tun.c          |  15 ++-
 drivers/net/tun_vnet.h     |   5 +-
 drivers/net/virtio_net.c   |   2 +-
 include/linux/virtio_net.h | 181 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 195 insertions(+), 8 deletions(-)


base-commit: fdca4b030c78fa2773a94fda3a6dc3ce5558a727
-- 
2.53.0

