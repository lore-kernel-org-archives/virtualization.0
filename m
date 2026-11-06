Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958825;
	b=dvaspFP+RZ0/IjEDb0Jr2Q7Pey/3MDaNBzzg07d9n5JnJA9ow/+rl1vXhCm4nOjjKu1g
	 uw3GGyk02WaVDTCRGpYVVldg+apizBH3hxqxMEkPUCrPzbyUNKmdSVKEgGeaGcFJPmLxx
	 rQ9mqEJHWKXah3Xf7ZZDpPZgGjRJpbXDBUn9Bm4YTC7sLNoOOGE9s/20Zkg5igXR7WcNI
	 Nj2mYwsnEtj44qI5CZ9b8hvyZ8A1Uo4qnOR5jfxq0oN2GCG+lZt/+PIVxh0PZ5zedFm4e
	 jMyYkXBL8TIMMMkNqhnqINpPSZ4ab9PLF+lPsSVxQoNCBvg9q1JHWY6ZoDS473pQCFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7LvVlJp3mLceHmkPiQDvM+GblBTrhCafJwX1Eszwuqw=;
	b=tdNytj8Ic4s/hn3Ci3AgRuD5xIKR52mIvJV+iQgjqEL+TuQRdLp7Xe3o1qAwN6/y9Oe/
	 mTf0ku4WSDFnI7cK3Wl8DxT6HDbVE3qMeufXMtW3ddxUuvAngox9Hp3Gfg4RLA3Tq6RJd
	 tpR5g/1eQd6Wwg1IxHv1A/VCN9ROWO6dqIqpvkOiWpYrxhbZiVnx/nDidykyZL5VaaPU0
	 KxUjfFHI/7cdv3wSanb4m7HJrmraBf556Xl3eTXbRbkyqqkt30wacRMeic9h1LIZIWhgp
	 p7oPLhf7zN0ci6gEHlh5/eGejxL2NMQpHW5Vbc/sCNAt9lSKLezIt1ZFiRg2VFKCG0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYkgwOdw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B02606A326;
	Fri,  6 Nov 2026 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYkgwOdw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0162F1F0089F;
	Fri,  6 Nov 2026 09:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958824;
	bh=7LvVlJp3mLceHmkPiQDvM+GblBTrhCafJwX1Eszwuqw=;
	h=From:To:Cc:Subject:Date;
	b=BYkgwOdw2m9hOp3ksqjkAN4XkpR1giNPd1iA3qw9qvB/Z0ECdvks88iO7YYJjow4t
	 3d6nMMYfyZIW9HPhE/YEURCaDTtjB2ImnbMkNYetRFGtTTsj4kKPyI4/OZeUeO3kE6
	 merqIcgsdrORaUw5i6E+r6NgpxIWTJ9BY6u9S32/DmwIjVojmoighBE3PTQw23iaEE
	 1Siph14EnQYJK+EjgKFWM8aCiO43oJvbcADiLC7+BWHX3FeUQnDzhG9fonipcysWKg
	 8ZisfmpwGl83tKj594Fwo7J8NIjlBFK00JNrnmWkdBVcD7AjQ5ILaqrvozBuR3FV9O
	 vHNpAZi/Z1ErA==
From: Eric Dumazet <edumazet@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v4 0/2] net: virtio: validate outer protocol of UDP tunnel GSO packets
Date: Fri,  6 Nov 2026 10:53:38 +0100
Message-ID: <20261106095340.2113683-1-edumazet@kernel.org>
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

Patch 1 validates the outer headers, using the parsing helpers from
Michael's series "net: resolve uncommon partial checksums at ingress",
as Willem suggested. The callers tell whether frames start with an
Ethernet header, as the device type of a tun device can be changed
with TUNSETLINK. The rest of Michael's series (checksum validation and
completion) is left to him.

Patch 2 clears a stale skb->protocol left on recycled NAPI frags skbs,
which could make the checks of patch 1 reject valid frames.

The selftests of v3 will follow in a separate series, with the fixes
Sashiko found in them.

v4:
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

Eric Dumazet (2):
  net: virtio: validate outer protocol of UDP tunnel GSO packets
  tun: clear stale skb->protocol of NAPI frags skbs

 drivers/net/tun.c          |  15 +++-
 drivers/net/tun_vnet.h     |   5 +-
 drivers/net/virtio_net.c   |   2 +-
 include/linux/virtio_net.h | 169 +++++++++++++++++++++++++++++++++++++
 4 files changed, 186 insertions(+), 5 deletions(-)


base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
-- 
2.53.0

